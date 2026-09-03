package com.expo.security.controller;

import com.expo.security.model.Lesson;
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
}