package com.expo.security.controller;

import com.expo.security.model.Exercise;
import com.expo.security.model.Lesson;
import com.expo.security.model.QuizQuestion;
import com.expo.security.model.Section;
import com.expo.security.service.CourseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final CourseService courseService;

    @GetMapping
    public String adminHome(Model model) {
        List<Section> sections = courseService.getAllSections();
        model.addAttribute("sections", sections);
        return "admin/index";
    }

    // ========== SECTIONS ==========

    @PostMapping("/section/add")
    public String addSection(@RequestParam String title,
                             @RequestParam(required = false) String description,
                             @RequestParam int sortOrder,
                             RedirectAttributes ra) {
        try {
            courseService.addSection(title, description != null ? description : "", sortOrder);
            ra.addFlashAttribute("success", "Sekcija dodata");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin";
    }

    @PostMapping("/section/{id}/edit")
    public String editSection(@PathVariable Long id,
                              @RequestParam String title,
                              @RequestParam(required = false) String description,
                              @RequestParam int sortOrder,
                              RedirectAttributes ra) {
        try {
            courseService.updateSection(id, title, description != null ? description : "", sortOrder);
            ra.addFlashAttribute("success", "Sekcija ažurirana");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin";
    }

    @PostMapping("/section/{id}/delete")
    public String deleteSection(@PathVariable Long id, RedirectAttributes ra) {
        try {
            courseService.deleteSection(id);
            ra.addFlashAttribute("success", "Sekcija obrisana");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin";
    }

    // ========== LESSONS ==========

    @GetMapping("/lesson/{id}/edit")
    public String editLessonForm(@PathVariable Long id, Model model) {
        Lesson lesson = courseService.getLesson(id);
        model.addAttribute("lesson", lesson);
        return "admin/edit-lesson";
    }

    @PostMapping("/lesson/{id}/edit")
    public String editLesson(@PathVariable Long id,
                             @RequestParam String title,
                             @RequestParam String content,
                             @RequestParam(required = false) MultipartFile image,
                             @RequestParam(required = false) Boolean removeImage,
                             RedirectAttributes ra) {
        try {
            courseService.updateLesson(id, title, content, image);
            if (Boolean.TRUE.equals(removeImage)) {
                courseService.removeLessonImage(id);
            }
            ra.addFlashAttribute("success", "Lekcija uspešno ažurirana");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/lesson/" + id + "/edit";
    }

    @PostMapping("/lesson/add")
    public String addLesson(@RequestParam Long sectionId,
                            @RequestParam String title,
                            @RequestParam String content,
                            @RequestParam int sortOrder,
                            RedirectAttributes ra) {
        try {
            courseService.addLesson(sectionId, title, content, sortOrder);
            ra.addFlashAttribute("success", "Lekcija dodata");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin";
    }

    @PostMapping("/lesson/{id}/delete")
    public String deleteLesson(@PathVariable Long id, RedirectAttributes ra) {
        courseService.deleteLesson(id);
        ra.addFlashAttribute("success", "Lekcija obrisana");
        return "redirect:/admin";
    }

    // ========== IMAGE UPLOAD (for inserting into content) ==========

    @PostMapping("/upload-image")
    @ResponseBody
    public Map<String, String> uploadImage(@RequestParam("file") MultipartFile file) throws Exception {
        String url = courseService.uploadImage(file);
        return Map.of("url", url);
    }

    @GetMapping("/upload-image/list")
    @ResponseBody
    public List<Map<String, String>> listUploadedImages() throws IOException {
        Path uploadDir = Paths.get("./uploads").toAbsolutePath().normalize();
        List<Map<String, String>> images = new ArrayList<>();
        if (Files.exists(uploadDir)) {
            try (DirectoryStream<Path> stream = Files.newDirectoryStream(uploadDir, "*.{jpg,jpeg,png,gif,JPG,JPEG,PNG,GIF,webp,WEBP}")) {
                for (Path entry : stream) {
                    String filename = entry.getFileName().toString();
                    images.add(Map.of(
                        "url", "/uploads/" + filename,
                        "name", filename.contains("_") ? filename.substring(filename.indexOf('_') + 1) : filename
                    ));
                }
            }
        }
        return images;
    }

    // ========== QUIZ QUESTIONS ==========

    @GetMapping("/quiz")
    public String quizQuestions(Model model) {
        List<QuizQuestion> questions = courseService.getAllQuestions();
        model.addAttribute("questions", questions);
        return "admin/quiz";
    }

    @PostMapping("/quiz/add")
    public String addQuestion(@RequestParam String questionText,
                              @RequestParam String optionA,
                              @RequestParam String optionB,
                              @RequestParam String optionC,
                              @RequestParam(required = false) String optionD,
                              @RequestParam String correctAnswer,
                              @RequestParam int sortOrder,
                              RedirectAttributes ra) {
        try {
            courseService.addQuestion(questionText, optionA, optionB, optionC,
                    optionD != null ? optionD : "", correctAnswer, sortOrder);
            ra.addFlashAttribute("success", "Pitanje dodato");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/quiz";
    }

    @PostMapping("/quiz/{id}/edit")
    public String editQuestion(@PathVariable Long id,
                               @RequestParam String questionText,
                               @RequestParam String optionA,
                               @RequestParam String optionB,
                               @RequestParam String optionC,
                               @RequestParam(required = false) String optionD,
                               @RequestParam String correctAnswer,
                               @RequestParam int sortOrder,
                               RedirectAttributes ra) {
        try {
            courseService.updateQuestion(id, questionText, optionA, optionB, optionC,
                    optionD != null ? optionD : "", correctAnswer, sortOrder);
            ra.addFlashAttribute("success", "Pitanje ažurirano");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/quiz";
    }

    @PostMapping("/quiz/{id}/delete")
    public String deleteQuestion(@PathVariable Long id, RedirectAttributes ra) {
        try {
            courseService.deleteQuestion(id);
            ra.addFlashAttribute("success", "Pitanje obrisano");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/quiz";
    }

    // ========== EXERCISES (Pokreni vežbu) ==========

    @GetMapping("/lesson/{id}/exercises")
    public String manageExercises(@PathVariable Long id, Model model) {
        Lesson lesson = courseService.getLesson(id);
        List<Exercise> exercises = courseService.getExercisesForLesson(id);
        model.addAttribute("lesson", lesson);
        model.addAttribute("exercises", exercises);
        return "admin/exercises";
    }

    @PostMapping("/lesson/{id}/exercise/add")
    public String addExercise(@PathVariable Long id,
                              @RequestParam String prompt,
                              @RequestParam String optionA,
                              @RequestParam String optionB,
                              @RequestParam String optionC,
                              @RequestParam String optionD,
                              @RequestParam String correctAnswer,
                              @RequestParam(required = false) String feedbackCorrect,
                              @RequestParam(required = false) String feedbackWrong,
                              @RequestParam int sortOrder,
                              RedirectAttributes ra) {
        try {
            courseService.addExercise(id, prompt, optionA, optionB, optionC, optionD,
                    correctAnswer, feedbackCorrect, feedbackWrong, sortOrder);
            ra.addFlashAttribute("success", "Vežba dodata");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/lesson/" + id + "/exercises";
    }

    @PostMapping("/exercise/{id}/edit")
    public String editExercise(@PathVariable Long id,
                               @RequestParam String prompt,
                               @RequestParam String optionA,
                               @RequestParam String optionB,
                               @RequestParam String optionC,
                               @RequestParam String optionD,
                               @RequestParam String correctAnswer,
                               @RequestParam(required = false) String feedbackCorrect,
                               @RequestParam(required = false) String feedbackWrong,
                               @RequestParam int sortOrder,
                               RedirectAttributes ra) {
        try {
            courseService.updateExercise(id, prompt, optionA, optionB, optionC, optionD,
                    correctAnswer, feedbackCorrect, feedbackWrong, sortOrder);
            ra.addFlashAttribute("success", "Vežba ažurirana");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/lesson/" + courseService.getExercise(id).getLesson().getId() + "/exercises";
    }

    @PostMapping("/exercise/{id}/delete")
    public String deleteExercise(@PathVariable Long id, RedirectAttributes ra) {
        try {
            Long lessonId = courseService.getExercise(id).getLesson().getId();
            courseService.deleteExercise(id);
            ra.addFlashAttribute("success", "Vežba obrisana");
            return "redirect:/admin/lesson/" + lessonId + "/exercises";
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin";
        }
    }

    @PostMapping("/lesson/{id}/scenario/edit")
    public String editScenarioInfo(@PathVariable Long id,
                                   @RequestParam(required = false) String scenarioTitle,
                                   @RequestParam(required = false) String scenarioDescription,
                                   RedirectAttributes ra) {
        try {
            courseService.updateLessonScenario(id, scenarioTitle, scenarioDescription);
            ra.addFlashAttribute("success", "Informacije o scenariju ažurirane");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/lesson/" + id + "/exercises";
    }
}