package com.expo.security.controller;

import com.expo.security.model.Exercise;
import com.expo.security.model.Lesson;
import com.expo.security.model.QuizAttempt;
import com.expo.security.model.Section;
import com.expo.security.model.User;
import com.expo.security.service.CourseService;
import com.expo.security.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class CourseController {

    private final CourseService courseService;
    private final ObjectMapper objectMapper;
    private final UserService userService;

    @GetMapping({"/", "/dashboard"})
    public String dashboard(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        User user = userService.findByEmail(userDetails.getUsername());
        List<Section> sections = courseService.getAllSections();
        long completed = courseService.getCompletedLessonsCount(user.getId());
        long total = courseService.getTotalLessonsCount();

        model.addAttribute("user", user);
        model.addAttribute("sections", sections);
        model.addAttribute("completed", completed);
        model.addAttribute("total", total);
        model.addAttribute("progressPercent", total > 0 ? (completed * 100 / total) : 0);
        return "course/dashboard";
    }

    @GetMapping("/lesson/{id}")
    public String lesson(@PathVariable Long id,
                         @AuthenticationPrincipal UserDetails userDetails,
                         Model model) {
        User user = userService.findByEmail(userDetails.getUsername());
        Lesson lesson = courseService.getLesson(id);
        List<Lesson> allLessons = courseService.getAllLessonsOrdered();

        int currentIndex = -1;
        for (int i = 0; i < allLessons.size(); i++) {
            if (allLessons.get(i).getId().equals(id)) {
                currentIndex = i;
                break;
            }
        }

        Lesson prev = currentIndex > 0 ? allLessons.get(currentIndex - 1) : null;
        Lesson next = currentIndex < allLessons.size() - 1 ? allLessons.get(currentIndex + 1) : null;

        // Mark as completed when viewing
        courseService.markLessonCompleted(user, id);

        List<Exercise> exercises = courseService.getExercisesForLesson(id);

        model.addAttribute("lesson", lesson);
        model.addAttribute("prev", prev);
        model.addAttribute("next", next);
        model.addAttribute("currentIndex", currentIndex + 1);
        model.addAttribute("totalLessons", allLessons.size());
        model.addAttribute("exercises", exercises);
        List<Map<String, Object>> exerciseData = new ArrayList<>();
        for (Exercise e : exercises) {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("id", e.getId());
            m.put("prompt", e.getPrompt());
            m.put("optionA", e.getOptionA());
            m.put("optionB", e.getOptionB());
            m.put("optionC", e.getOptionC());
            m.put("optionD", e.getOptionD());
            m.put("correctAnswer", e.getCorrectAnswer());
            m.put("feedbackCorrect", e.getFeedbackCorrect());
            m.put("feedbackWrong", e.getFeedbackWrong());
            exerciseData.add(m);
        }
        model.addAttribute("exerciseData", exerciseData);
        return "course/lesson";
    }

    @GetMapping("/quiz")
    public String quiz(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        model.addAttribute("questions", courseService.getAllQuestions());
        return "quiz/quiz";
    }

    @PostMapping("/quiz/submit")
    public String submitQuiz(@AuthenticationPrincipal UserDetails userDetails,
                             @RequestParam Map<String, String> params,
                             Model model) {
        User user = userService.findByEmail(userDetails.getUsername());

        List<String> answers = courseService.getAllQuestions().stream()
                .map(q -> params.getOrDefault("q_" + q.getId(), ""))
                .collect(Collectors.toList());

        QuizAttempt attempt = courseService.submitQuiz(user, answers);
        model.addAttribute("attempt", attempt);
        return "quiz/result";
    }

    @GetMapping("/certificate/{attemptId}")
    public ResponseEntity<byte[]> downloadCertificate(@PathVariable Long attemptId) throws Exception {
        byte[] pdf = courseService.generatePdf(attemptId);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=sertifikat-expo2027.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdf);
    }

    @GetMapping("/verify/{code}")
    public String verify(@PathVariable String code, Model model) {
        QuizAttempt attempt = courseService.findByCertificateCode(code);
        model.addAttribute("attempt", attempt);
        return "quiz/verify";
    }
}
