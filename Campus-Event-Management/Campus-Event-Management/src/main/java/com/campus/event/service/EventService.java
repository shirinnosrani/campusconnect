package com.campus.event.service;

import com.campus.event.model.Event;
import com.campus.event.model.Registration;
import com.campus.event.repository.EventRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class EventService {

    private final EventRepository repo;

    public EventService(EventRepository repo) {
        this.repo = repo;
    }

    public List<Event> findAll() {
        return repo.findAll();
    }

    public Event save(Event event) {

        return repo.save(event);
    }

    public void deleteEvent(int eventId) {
        repo.deleteById((long) eventId);
    }

    public Optional<Event> getEventById(int eventId) {
        return repo.findById((long) eventId);
    }

    public List<Event> filterUnregisteredEvents(List<Event> allEvents, List<Registration> registrations) {

        // Collect registered event IDs
        Set<Long> registeredEventIds = registrations.stream()
                .map(r -> r.getEvent().getId())
                .collect(Collectors.toSet());

        // Remove registered events
        return allEvents.stream()
                .filter(event -> !registeredEventIds.contains(event.getId()))
                .collect(Collectors.toList());
    }
}
