<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CampusEvents | Login</title>

    <!-- CSS -->
    <link rel="stylesheet" href="<c:url value='/css/app.css' />">
</head>
<body>

<div class="container">

    <!-- LEFT PANEL -->
    <div class="left">
        <div class="logo">🎓</div>

        <h1>Manage Campus<br>Events with Ease</h1>

        <p>
            Discover workshops, seminars, and social gatherings happening around campus.
            Connect, learn, and grow with your community.
        </p>

        <div class="stats">
            <div class="stat">
                <h2>500+</h2>
                <span>Monthly Events</span>
            </div>
            <div class="stat">
                <h2>10k+</h2>
                <span>Active Students</span>
            </div>
        </div>
    </div>

    <!-- RIGHT PANEL -->
    <div class="right">
        <div class="card">

            <!-- LOGIN VIEW -->
            <c:if test="${view == null || view == 'login'}">
                <div class="view">
                    <h2>Welcome Back</h2>
                    <p class="sub">Enter your credentials to access your account</p>

                    <div class="tabs">
                        <button type="button" class="active" onclick="location.href='<c:url value='/?view=login' />'">Login</button>
                        <button type="button" onclick="location.href='<c:url value='/?view=register' />'">Register</button>
                    </div>

                    <form action="<c:url value='/login' />" method="post">
                        <label>Email Id</label>
                        <input type="email" name="email" placeholder="Email Id" required>

                        <label>Password</label>
                        <input type="password" name="password" placeholder="••••••••" required>
                        <div style="text-align:right; margin-bottom:6px;">
                            <a href="<c:url value='/?view=forgot_password' />"
                               style="font-size:13px; color:#1f3a8a; text-decoration:none;">
                                Forgot password?
                            </a>
                        </div>
                        <c:if test="${not empty error}">
                            <p style="color:red;">${error}</p>
                        </c:if>

                        <button type="submit" class="primary">Log In</button>
                    </form>
                </div>
            </c:if>

            <!-- REGISTER VIEW -->
            <c:if test="${view == 'register'}">
                <div class="view">
                    <h2>Create Account</h2>
                    <p class="sub">Join the community to start exploring events</p>

                    <div class="tabs">
                        <button type="button" onclick="location.href='<c:url value='/?view=login' />'">Login</button>
                        <button type="button" class="active" onclick="location.href='<c:url value='/?view=register' />'">Register</button>
                    </div>

                    <form action="<c:url value='/register' />" method="post">

                        <label>Full Name</label>
                        <input type="text" name="fullName" placeholder="Full Name" lengthen="3" required>

                        <label>Email Id</label>
                        <input type="email" name="email" placeholder="Email Id" required>

                        <label>Password</label>
                        <input type="password" name="password" minlength="8" placeholder="••••••••" required>

                        <label>Confirm Password</label>
                        <input type="password" name="confirmPassword" minlength="8" placeholder="••••••••" required>

                        <c:if test="${not empty error}">
                            <p style="color:red;">${error}</p>
                        </c:if>

                        <button type="submit" class="primary">Create Account</button>
                    </form>
                </div>
            </c:if>

            <!-- LOGIN VIEW -->
            <c:if test="${view == 'forgot_password'}">
                <div class="view">
                    <h2>Forgot Password</h2>
                    <p class="sub">Enter your details to reset your password</p>

                    <form action="<c:url value='/forgot_password' />" method="post">
                        <label>Email Id</label>
                        <input type="email" name="email" placeholder="Email Id" required>

                        <label>Password</label>
                        <input type="password" name="password" minlength="8" placeholder="••••••••" required>

                        <label>Confirm Password</label>
                        <input type="password" name="confirmPassword" minlength="8" placeholder="••••••••" required>

                        <div style="text-align:right; margin-bottom:6px;">
                            <a href="<c:url value='/?view=login' />"
                               style="font-size:13px; color:#1f3a8a; text-decoration:none;">
                                Goto LOGIN Page.
                            </a>
                        </div>
                        <c:if test="${not empty error}">
                            <p style="color:red;">${error}</p>
                        </c:if>

                        <button type="submit" class="primary">Reset Password</button>
                    </form>
                </div>
            </c:if>
        </div>
    </div>

</div>
<script>
    setTimeout(() => {
        const msg = document.querySelector('.msg');
        if (msg) {
            msg.style.opacity = '0';
            setTimeout(() => msg.style.display = 'none', 500);
        }
    }, 3000);
</script>


</body>
</html>
