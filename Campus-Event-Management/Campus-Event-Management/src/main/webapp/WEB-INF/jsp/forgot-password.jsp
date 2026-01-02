<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
</head>
<body>

<div class="page center">
    <div class="form-card">

        <h2>Forgot Password</h2>
        <p class="sub">Enter your email to reset your password</p>

        <c:if test="${not empty error}">
            <p style="color:red;">${error}</p>
        </c:if>

        <c:if test="${not empty success}">
            <p style="color:green;">${success}</p>
        </c:if>

        <form action="<c:url value='/forgot-password' />" method="post">
            <label>Email Id</label>
            <input type="email" name="email" required>

            <button class="primary">Send Reset Link</button>
        </form>

        <div style="margin-top:12px;">
            <a href="<c:url value='/' />">Back to Login</a>
        </div>
    </div>
</div>

</body>
</html>
