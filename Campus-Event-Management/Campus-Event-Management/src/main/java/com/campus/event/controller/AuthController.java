package com.campus.event.controller;

import com.campus.event.model.User;
import com.campus.event.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.Objects;

@Controller
public class AuthController {

    private final UserService service;

    public AuthController(UserService service) {
        this.service = service;
    }

    @GetMapping("/")
    public String loginPage(@RequestParam(required = false) String view, Model model) {
        model.addAttribute("view", view);
        return "login-register";
    }

    @GetMapping("/login-register")
    public String loginRegisterPage() {
        return "login-register";
    }


    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, RedirectAttributes redirectAttributes) {

        User user = service.login(email, password);

        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Invalid email or password");
            return "redirect:/?view=login";
        }
        session.setAttribute("user", user);
        session.setAttribute("today", LocalDate.now());

        String role = user.getRole() == null ? "" : user.getRole().trim().toUpperCase();

        if ("ADMIN".equals(role)) {
            return "redirect:/events";
        }

        if ("STUDENT".equals(role)) {
            return "redirect:/student-events";
        }

        redirectAttributes.addFlashAttribute("error", "Invalid user role");
        return "redirect:/?view=login";

    }

    @PostMapping("/register")
    public String register(@RequestParam String fullName, @RequestParam String email, @RequestParam String password,
                        @RequestParam String confirmPassword, HttpSession session, RedirectAttributes redirectAttributes) {

        // Name check
        if (fullName.length() < 3) {
            redirectAttributes.addFlashAttribute("error", "Name must be at least 3 characters");
            return "redirect:/?view=register";
        }

        // Email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            redirectAttributes.addFlashAttribute("error", "Invalid email format");
            return "redirect:/?view=register";
        }

        // Password length
        if (password.length() < 8) {
            redirectAttributes.addFlashAttribute("error", "Password must be at least 8 characters");
            return "redirect:/?view=register";
        }

        // Password match
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/?view=register";
        }

        // Email exists
        if (service.findUserByEmail(email) != null) {
            redirectAttributes.addFlashAttribute("error", "Email already registered. Please login.");
            return "redirect:/?view=login";
        }

        // Save user
        User user = new User();
        user.setName(fullName);
        user.setEmail(email);

        // TEMP (use BCrypt later)
        user.setPassword(password);

        user.setRole("STUDENT");
        service.save(user);

        // SUCCESS MESSAGE
        redirectAttributes.addFlashAttribute("success", "Registration successful. Please login.");

        return "redirect:/?view=login";

    }

    @PostMapping("/forgot_password")
    public String forgotPassword(@RequestParam String email, @RequestParam String password,
                           @RequestParam String confirmPassword, RedirectAttributes redirectAttributes) {

        // Email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            redirectAttributes.addFlashAttribute(
                    "error", "Invalid email format"
            );
            return "redirect:/?view=forgot_password";
        }

        // Password length
        if (password.length() < 8) {
            redirectAttributes.addFlashAttribute(
                    "error", "Password must be at least 8 characters"
            );
            return "redirect:/?view=forgot_password";
        }

        // Password match
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute(
                    "error", "Passwords do not match"
            );
            return "redirect:/?view=forgot_password";
        }

        User user = service.findUserByEmail(email);

        if (user == null) {
            redirectAttributes.addFlashAttribute(
                    "error", "Email not found. Please register."
            );
            return "redirect:/?view=register";
        }

        // ✅ UPDATE EXISTING USER PASSWORD
        user.setPassword(password); // TEMP (BCrypt later)
        service.save(user);

        redirectAttributes.addFlashAttribute(
                "success", "Password updated successfully. Please login."
        );

        return "redirect:/?view=login";
//        // Email format
//        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
//            model.addAttribute("error", "Invalid email format");
//            model.addAttribute("view", "forgot_password");
//            return "/login-register";
//        }
//
//        // Password length
//        if (password.length() < 8) {
//            model.addAttribute("error", "Password must be at least 8 characters");
//            model.addAttribute("view", "forgot_password");
//            return "/login-register";
//        }
//
//        // Password match
//        if (!password.equals(confirmPassword)) {
//            model.addAttribute("error", "Passwords do not match");
//            model.addAttribute("view", "forgot_password");
//            return "/login-register";
//        }
//
//
//        User userDetail = service.findUserByEmail(email);
//
//        if (userDetail != null && email.equals(userDetail.getEmail())) {
//
//            User user = new User();
//            user.setName(userDetail.getName());
//            user.setEmail(userDetail.getEmail());
//            user.setRole(userDetail.getRole());
//            user.setPassword(userDetail.getPassword());
//            service.save(user);
//            model.addAttribute("error", "Passwords do not match");
//            model.addAttribute("view", "login");
//            return "/login-register";
//
//        } else {
//            model.addAttribute("error", "Email id not match with our records. Please register your self.");
//            model.addAttribute("view", "register");
//        }
//
//        return "/login-register";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {

        // 🔥 clear all session data
        session.invalidate();

        // 🔥 prevent browser cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        return "/login-register";
    }

}
