<%@ page import="com.digicode.dao.LoginServiceImpl" %>
<%@ page import="com.digicode.model.EmployeeModel" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%
    // Initialize the username variable
    String username = "Guest";
    
    // Get the cookies from the request
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("username".equals(cookie.getName())) {
                username = cookie.getValue();
                break;
            }
        }
    }
    
    LoginServiceImpl loginService = new LoginServiceImpl();
    EmployeeModel user = loginService.getUserById(username);
    String position = user != null ? user.getPosition() : "user";
%>

<nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar">
        <a class="sidebar-brand" href="index.html">
            <span class="align-middle">DigiCode</span>
        </a>

        <ul class="sidebar-nav">
            <li class="sidebar-item active">
                <%-- Check user position and redirect if not admin or super admin --%>
                <% 
                    if ("admin".equals(position) || "super_admin".equals(position)) { 
                %>
                    <a class="sidebar-link" href="index.jsp">
                        <i class="align-middle" data-feather="sliders"></i>
                        <span class="align-middle">Dashboard</span>
                    </a>
                <% } else { %>
                    <a class="sidebar-link" href="employee_dashboard.jsp">
                        <i class="align-middle" data-feather="sliders"></i>
                        <span class="align-middle">Dashboard</span>
                    </a>
                <% } %>
            </li>

            <%-- Conditionally show "Employees" link based on user position --%>
            <% 
                if ("admin".equals(position) || "super_admin".equals(position)) { 
            %>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="employee.jsp">
                        <i class="align-middle" data-feather="user"></i>
                        <span class="align-middle">Employees</span>
                    </a>
                </li>
            <% } %>

            <%-- Conditionally show "Departments" link based on user position --%>
            <% 
                if ("admin".equals(position) || "super_admin".equals(position)) { 
            %>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="#">
                        <i class="align-middle" data-feather="log-in"></i>
                        <span class="align-middle">Departments</span>
                    </a>
                </li>
            <% } %>

            <li class="sidebar-item">
                <a class="sidebar-link" href="task.jsp">
                    <i class="align-middle" data-feather="user-plus"></i>
                    <span class="align-middle">Tasks</span>
                </a>
            </li>

            <li class="sidebar-header">Settings</li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="#">
                    <i class="align-middle" data-feather="user"></i>
                    <span class="align-middle">Announcement</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="#">
                    <i class="align-middle" data-feather="check-square"></i>
                    <span class="align-middle">Messages</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="profile.jsp">
                    <i class="align-middle" data-feather="grid"></i>
                    <span class="align-middle">Profile</span>
                </a>
            </li>
        </ul>
    </div>
</nav>
