<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CampusEvents | Create Event</title>
    <link rel="stylesheet" href="<c:url value='/css/app.css'/>">
</head>
<body>

<!-- TOP NAVBAR -->
<header class="navbar">
    <div class="nav-left">
        <div class="brand">C</div>
        <span class="brand-name">CampusEvents</span>

        <nav>
            <a href="<c:url value='/events'/>">Events</a>
            <a class="active" href="<c:url value='/create-event'/>">Create Event</a>
        </nav>
    </div>

    <div class="nav-right">
        <div class="user">
            <span class="avatar">${user.name.substring(0,1)}</span>
            <div>
                <strong>${user.name}</strong>
                <small>${user.role}</small>
            </div>
        </div>
        <a class="logout" href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</header>
<!-- PAGE CONTENT -->
<div class="page-center">

    <div class="form-card">

        <div class="form-header">
            <div class="icon-box">📅</div>
            <h2>Create New Event</h2>
            <p>Organize a new event for the campus community.</p>
        </div>

        <form action="<c:url value='/create-new-event'/>" method="post">

            <!-- EVENT TITLE -->
            <label>Event Title</label>
            <input type="text"
                   name="title"
                   placeholder="e.g., Annual Tech Symposium"
                   required>

            <!-- DESCRIPTION -->
            <label>Description</label>
            <textarea name="description"
                      placeholder="What is this event about?"
                      rows="4"
                      required></textarea>

            <!-- DATE & CAPACITY -->
            <div class="row">
                <div class="col">
                    <label>Date</label>
                    <input type="date"
                           name="eventDate"
                           required>
                </div>

                <div class="col">
                    <label>Capacity</label>
                    <input type="number"
                           name="capacity"
                           value="50"
                           min="1"
                           required>
                </div>
            </div>

            <!-- LOCATION -->
            <label>Location</label>
            <input type="text"
                   name="location"
                   placeholder="e.g., Auditorium A"
                   required>

            <!-- ACTION BUTTONS -->
            <div class="actions">

                <button type="submit" class="btn primary">Create Event</button>
            </div>

        </form>

    </div>

</div>

</body>
</html>
