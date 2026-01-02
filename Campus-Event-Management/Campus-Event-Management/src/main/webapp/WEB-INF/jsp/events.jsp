<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CampusEvents | Events</title>
    <link rel="stylesheet" href="<c:url value='/css/app.css'/>">
</head>
<body>

<!-- TOP NAVBAR -->
<header class="navbar">
    <div class="nav-left">
        <div class="brand">C</div>
        <span class="brand-name">CampusEvents</span>

        <nav>
            <a class="active" href="<c:url value='/events'/>">Events</a>
            <a href="<c:url value='/create-event'/>">Create Event</a>
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
<div class="page">

    <!-- HEADER -->
    <div class="page-header">
        <div>
            <h1>Welcome back, ${user.name}</h1>
            <p>Browse and join upcoming campus events.</p>
        </div>
    </div>
    <!-- EVENTS GRID -->
    <div class="grid">
        <c:forEach items="${events}" var="event">
            <div class="event-card">
                <!-- CONTENT -->
                <span class="badge">
                    <c:choose>
                        <c:when test="${event.eventDate lt today}">
                            Past Event
                        </c:when>
                        <c:otherwise>
                            Upcoming
                        </c:otherwise>
                    </c:choose>
                </span>
                <h2>${event.title}</h2>
                <p class="desc">${event.description}</p>
                <div class="meta">
                    <span>📅 ${event.eventDate}</span>
                    <span>📍 ${event.location}</span>
                    <span>👥 Capacity: ${event.capacity} people</span>
                </div>

                <!-- ADMIN ACTION -->
                <c:if test="${user.role == 'ADMIN'}">
                    <form action="<c:url value='/delete-event/${event.id}' />" method="post">
                        <button class="primary" style="margin-top:16px;">
                            🗑 Delete Event
                        </button>
                    </form>
                </c:if>
            </div>
        </c:forEach>
        <!-- EMPTY STATE -->
        <c:if test="${empty events}">
            <p>No events available.</p>
        </c:if>
    </div>
</div>

</body>
</html>
