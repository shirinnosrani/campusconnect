package com.campus.event.service;

import com.campus.event.model.Event;
import com.campus.event.model.Registration;
import com.campus.event.model.User;
import com.campus.event.repository.EventRepository;
import com.campus.event.repository.RegistrationRepository;
import com.campus.event.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class RegistrationService {

    private final RegistrationRepository registrationRepository;

    private final UserRepository userRepository;

    private final EventRepository eventRepository;

    public RegistrationService(RegistrationRepository registrationRepository, UserRepository userRepository, EventRepository eventRepository) {
        this.registrationRepository = registrationRepository;
        this.userRepository = userRepository;
        this.eventRepository = eventRepository;
    }

    public Registration save(Registration registration) {
        return registrationRepository.save(registration);
    }

    public List<Registration> findByUser(Long userId) {
        return registrationRepository.findByUserId(userId);
    }

    public List<Registration> findAll() {
        return registrationRepository.findAll();
    }

    public Registration eventRegister(int eventId, int userId) {

        Optional<User> user = userRepository.findById((long) userId);
        Optional<Event> event = eventRepository.findById((long) eventId);

        Registration registration = new Registration();

        Registration regi = null;
        if (user.isPresent() && event.isPresent()) {
            registration.setEvent(event.get());
            registration.setUser(user.get());
            registration.setRegisteredAt(LocalDate.now());
            regi = registrationRepository.save(registration);
        }

        return regi;
    }

    public void deleteRegistration(Long eventId) {
        registrationRepository.deleteById(eventId);
    }
}
