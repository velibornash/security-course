package com.expo.security.service;

import com.expo.security.model.*;
import com.expo.security.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CourseService {

    private final SectionRepository sectionRepository;
    private final LessonRepository lessonRepository;
    private final QuizQuestionRepository questionRepository;
    private final UserProgressRepository progressRepository;
    private final QuizAttemptRepository attemptRepository;
    private final PdfCertificateService pdfService;
    private final EmailService emailService;

    private final Path uploadPath = Paths.get("./uploads").toAbsolutePath().normalize();

    public List<Section> getAllSections() {
        return sectionRepository.findAllByOrderBySortOrderAsc();
    }

    public Lesson getLesson(Long id) {
        return lessonRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Lekcija nije pronađena"));
    }

    public List<Lesson> getAllLessonsOrdered() {
        return lessonRepository.findAllByOrderBySortOrderAsc();
    }

    public long getCompletedLessonsCount(Long userId) {
        return progressRepository.countByUserIdAndCompletedTrue(userId);
    }

    public long getTotalLessonsCount() {
        return lessonRepository.count();
    }

    @Transactional
    public void markLessonCompleted(User user, Long lessonId) {
        Lesson lesson = getLesson(lessonId);
        progressRepository.findByUserIdAndLessonId(user.getId(), lessonId)
                .ifPresentOrElse(
                        p -> {
                            if (!p.isCompleted()) {
                                p.setCompleted(true);
                                p.setCompletedAt(LocalDateTime.now());
                                progressRepository.save(p);
                            }
                        },
                        () -> progressRepository.save(UserProgress.builder()
                                .user(user)
                                .lesson(lesson)
                                .completed(true)
                                .completedAt(LocalDateTime.now())
                                .build())
                );
    }

    public boolean isLessonCompleted(Long userId, Long lessonId) {
        return progressRepository.findByUserIdAndLessonId(userId, lessonId)
                .map(UserProgress::isCompleted)
                .orElse(false);
    }

    public List<QuizQuestion> getAllQuestions() {
        return questionRepository.findAllByOrderBySortOrderAsc();
    }

    @Transactional
    public QuizAttempt submitQuiz(User user, List<String> answers) {
        List<QuizQuestion> questions = getAllQuestions();
        if (answers.size() != questions.size()) {
            throw new IllegalArgumentException("Broj odgovora ne odgovara broju pitanja");
        }

        int correct = 0;
        QuizAttempt attempt = QuizAttempt.builder()
                .user(user)
                .totalQuestions(questions.size())
                .certificateCode(UUID.randomUUID().toString().substring(0, 8).toUpperCase())
                .attemptedAt(LocalDateTime.now())
                .build();

        for (int i = 0; i < questions.size(); i++) {
            QuizQuestion q = questions.get(i);
            String selected = answers.get(i);
            boolean isCorrect = q.getCorrectAnswer().equalsIgnoreCase(selected);
            if (isCorrect) correct++;

            QuizAnswer answer = QuizAnswer.builder()
                    .attempt(attempt)
                    .question(q)
                    .selectedAnswer(selected)
                    .correct(isCorrect)
                    .build();
            attempt.getAnswers().add(answer);
        }

        attempt.setScore(correct);
        attempt.setPercentage((correct * 100.0) / questions.size());
        attempt.setPassed(attempt.getPercentage() >= 90.0);

        QuizAttempt saved = attemptRepository.save(attempt);

        // If passed, generate PDF, save to disk, and send email
        if (saved.isPassed()) {
            try {
                byte[] pdfBytes = pdfService.generateCertificate(saved);
                String pdfUrl = savePdfToDisk(pdfBytes, saved.getCertificateCode());
                saved.setCertificatePdfUrl(pdfUrl);
                attemptRepository.save(saved);
                emailService.sendCertificate(user, pdfBytes, saved.getCertificateCode());
            } catch (Exception e) {
                System.err.println("Warning: Could not generate/send certificate PDF: " + e.getMessage());
            }
        }

        return saved;
    }

    private String savePdfToDisk(byte[] pdfBytes, String code) throws IOException {
        Path certDir = uploadPath.resolve("certificates");
        if (!Files.exists(certDir)) {
            Files.createDirectories(certDir);
        }
        String filename = "sertifikat-" + code + ".pdf";
        Path target = certDir.resolve(filename);
        Files.write(target, pdfBytes);
        return "/uploads/certificates/" + filename;
    }

    public byte[] generatePdf(Long attemptId) throws Exception {
        QuizAttempt attempt = attemptRepository.findById(attemptId)
                .orElseThrow(() -> new RuntimeException("Pokušaj nije pronađen"));
        return pdfService.generateCertificate(attempt);
    }

    // ========== ADMIN ==========

    @Transactional
    public Lesson updateLesson(Long id, String title, String content, MultipartFile image) throws IOException {
        Lesson lesson = getLesson(id);
        lesson.setTitle(title);
        lesson.setContent(content);

        if (image != null && !image.isEmpty()) {
            String url = uploadImage(image);
            lesson.setImagePath(url);
        }
        return lessonRepository.save(lesson);
    }

    @Transactional
    public Lesson addLesson(Long sectionId, String title, String content, int sortOrder) {
        Section section = sectionRepository.findById(sectionId)
                .orElseThrow(() -> new RuntimeException("Sekcija nije pronađena"));
        Lesson lesson = Lesson.builder()
                .title(title)
                .content(content)
                .sortOrder(sortOrder)
                .section(section)
                .build();
        return lessonRepository.save(lesson);
    }

    @Transactional
    public void deleteLesson(Long id) {
        lessonRepository.deleteById(id);
    }

    @Transactional
    public void removeLessonImage(Long id) {
        Lesson lesson = getLesson(id);
        lesson.setImagePath(null);
        lessonRepository.save(lesson);
    }

    @Transactional
    public Section addSection(String title, String description, int sortOrder) {
        Section section = Section.builder()
                .title(title)
                .description(description)
                .sortOrder(sortOrder)
                .build();
        return sectionRepository.save(section);
    }

    @Transactional
    public Section updateSection(Long id, String title, String description, int sortOrder) {
        Section section = sectionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Sekcija nije pronađena"));
        section.setTitle(title);
        section.setDescription(description);
        section.setSortOrder(sortOrder);
        return sectionRepository.save(section);
    }

    @Transactional
    public void deleteSection(Long id) {
        sectionRepository.deleteById(id);
    }

    public Section getSection(Long id) {
        return sectionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Sekcija nije pronađena"));
    }

    public QuizAttempt getAttempt(Long id) {
        return attemptRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pokušaj nije pronađen"));
    }

    public QuizAttempt findByCertificateCode(String code) {
        return attemptRepository.findByCertificateCode(code)
                .orElse(null);
    }

    /** Upload image and return public URL path like /uploads/xxx.jpg */
    public String uploadImage(MultipartFile image) throws IOException {
        if (image == null || image.isEmpty()) {
            throw new IllegalArgumentException("Fajl je prazan");
        }
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        String original = image.getOriginalFilename() != null ? image.getOriginalFilename() : "image.jpg";
        String filename = UUID.randomUUID() + "_" + original.replaceAll("[^a-zA-Z0-9._-]", "_");
        Path target = uploadPath.resolve(filename);
        Files.copy(image.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
        System.out.println("Uploaded image to: " + target.toAbsolutePath());
        return "/uploads/" + filename;
    }
}