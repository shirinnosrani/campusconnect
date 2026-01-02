package com.campus.event.controller;

import com.campus.event.model.Event;
import com.campus.event.model.Registration;
import com.campus.event.model.User;
import com.campus.event.service.EventService;
import com.campus.event.service.RegistrationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
public class EventController {

    private final EventService service;

    private final RegistrationService registrationService;

    public EventController(EventService service, RegistrationService registrationService) {
        this.service = service;
        this.registrationService = registrationService;
    }

    @GetMapping("/events")
    public String events(Model model) {
        System.out.println("Inside events");
        model.addAttribute("events", service.findAll());

        return "events";
    }

    @GetMapping("/student-events")
    public String studentEvents(Model model, HttpSession session) {

        User user = (User) session.getAttribute("user");
        List<Event> allEvents = service.findAll();
        List<Registration> registrations =
                registrationService.findByUser(user.getId());

        // Java-side filtering
        List<Event> availableEvents =
                service.filterUnregisteredEvents(allEvents, registrations);

        model.addAttribute("events", availableEvents);

        return "student-events";
    }

    @GetMapping("/create-event")
    public String createEventPage() {

        return "create-event";
    }

    @PostMapping("/create-new-event")
    public String createEvent(Event event, Model model) {

        service.save(event);
        model.addAttribute("events", service.findAll());

        return "events";
    }

    @PostMapping("/delete-event/{eventId}")
    public String deleteEvent(@PathVariable int eventId, Model model) {

        Optional<Event> event = service.getEventById(eventId);

        if (event.isPresent()) {
            List<Registration> registrations = registrationService.findAll();
            for (Registration registration : registrations) {
                if (eventId == registration.getEvent().getId()) {
                    Long registrationId = registration.getId();
                    registrationService.deleteRegistration(registrationId);
                }
            }
            service.deleteEvent(eventId);
            model.addAttribute("events", service.findAll());
            return "events";
        }

        return "events";
    }
}
