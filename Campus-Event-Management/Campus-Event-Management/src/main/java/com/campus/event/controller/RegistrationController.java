package com.campus.event.controller;

import com.campus.event.model.Registration;
import com.campus.event.model.User;
import com.campus.event.service.RegistrationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class RegistrationController {

    private final RegistrationService service;

    public RegistrationController(RegistrationService service) {
        this.service = service;
    }

    @PostMapping("/event-register/{eventId}")
    public String eventRegister(@PathVariable int eventId, HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        Registration registration = service.eventRegister(eventId, Math.toIntExact(user.getId()));

        return "redirect:/my-registrations";
    }

    @GetMapping("/my-registrations")
    public String myRegistrations(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        List<Registration> registrations = service.findByUser(user.getId());

        model.addAttribute("registrations",registrations);

        return "my-registrations";
    }
}
