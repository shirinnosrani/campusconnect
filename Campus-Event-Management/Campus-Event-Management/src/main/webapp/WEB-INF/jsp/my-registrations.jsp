<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CampusEvents | My Registrations</title>
    <link rel="stylesheet" href="<c:url value='/css/app.css'/>">
</head>
<body>

<header class="navbar">
    <div class="nav-left">
        <div class="brand">C</div>
        <span class="brand-name">CampusEvents</span>
        <nav>
            <a href="<c:url value='/student-events'/>">Events</a>
            <a class="active" href="<c:url value='/my-registrations'/>">My Registrations</a>
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
            <h1>My Registrations</h1>
            <p>Events you are attending.</p>
        </div>
    </div>
    <div class="grid">
            <c:forEach var="registration" items="${registrations}">
                <div class="event-card">
                    <span class="badge">
                        <c:choose>
                            <c:when test="${registration.event.eventDate lt today}">
                                Past Event
                            </c:when>
                            <c:otherwise>
                                Upcoming
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <h2>${registration.event.title}</h2>
                    <p class="desc">${registration.event.description}</p>

                    <div class="meta">
                        <span>📅 ${registration.event.eventDate}</span>
                        <c:if test="${not empty event.location}">
                            <span>📍 ${registration.event.location}</span>
                        </c:if>

                        <span>👥 Capacity: ${registration.event.capacity} people</span>
                    </div>

                    <button class="outline" disabled style="margin-top:16px;">
                        Already Registered
                    </button>
                </div>
            </c:forEach>

            <c:if test="${empty registrations}">
                <p>No events available.</p>
            </c:if>

        </div>
</main>
</body>
</html>
