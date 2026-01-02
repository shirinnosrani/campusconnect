<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CampusEvents | Student Events</title>
    <link rel="stylesheet" href="<c:url value='/css/app.css'/>">
</head>
<body>

<header class="navbar">
    <div class="nav-left">
        <div class="brand">C</div>
        <span class="brand-name">CampusEvents</span>

        <nav>
            <a class="active" href="<c:url value='/student-events'/>">Events</a>
            <a href="<c:url value='/my-registrations'/>">My Registrations</a>
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

<main class="page">
    <div class="page-header">
        <div>
            <h1>Welcome back, ${user.name}</h1>
            <p>Browse and join upcoming campus events.</p>
        </div>
    </div>
    <div class="grid">
        <c:forEach var="event" items="${events}">

                    <div class="event-card">
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
                            <c:if test="${not empty event.location}">
                                <span>📍 ${event.location}</span>
                            </c:if>

                            <span>👥 Capacity: ${event.capacity} people</span>
                        </div>

                        <!-- Show Register button only for upcoming events -->

                        <c:if test="${event.eventDate gt today}">
                            <form action="<c:url value='/event-register/${event.id}' />" method="post">
                                <button class="primary" style="margin-top:16px;">
                                    Register Now
                                </button>
                            </form>
                        </c:if>

                    </div>

        </c:forEach>

        <c:if test="${empty events}">
            <p>No events available.</p>
        </c:if>

    </div>

</main>

</body>
</html>
