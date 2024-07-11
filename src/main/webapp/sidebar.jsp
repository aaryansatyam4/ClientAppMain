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
        <a class="sidebar-brand" href="#">
            <span class="align-middle">NIC</span>
        </a>

        <ul class="sidebar-nav">
            <li class="sidebar-item">
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

           <!--  <li class="sidebar-item">
                <a class="sidebar-link" href="#">
                    <i class="align-middle" data-feather="check-square"></i>
                    <span class="align-middle">Messages</span>
                </a>
            </li> -->

            <li class="sidebar-item">
                <a class="sidebar-link" href="profile.jsp">
                    <i class="align-middle" data-feather="grid"></i>
                    <span class="align-middle">Profile</span>
                </a>
            </li>

            <% 
                if ("super_admin".equals(position)) { 
            %>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="admins.jsp">
                        <i class="align-middle" data-feather="user"></i>
                        <span class="align-middle">Admins</span>
                    </a>
                </li>
            <% } %>

            <% 
                if ("super_admin".equals(position)) { 
            %>
                <li class="sidebar-item">
                    <a data-bs-target="#tickets-submenu" data-bs-toggle="collapse" class="sidebar-link collapsed">
                        <i class="align-middle" data-feather="log-in"></i>
                        <span class="align-middle">Tickets</span>
                    </a>
                    <ul id="tickets-submenu" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="AddTicketGroup.jsp">
                                <i class="align-middle" data-feather="plus-square"></i>
                                <span class="align-middle">New Ticket</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="list_tickets.jsp">
                                <i class="align-middle" data-feather="file-text"></i>
                                <span class="align-middle">List Tickets</span>
                            </a>
                        </li>
                    </ul>
                </li>
            <% } %>
        </ul>
    </div>
</nav>

<script>
    // Function to highlight the active sidebar item
    document.addEventListener('DOMContentLoaded', function() {
        const sidebarLinks = document.querySelectorAll('.sidebar-link');

        sidebarLinks.forEach(link => {
            link.addEventListener('click', function() {
                sidebarLinks.forEach(link => link.parentElement.classList.remove('active'));
                this.parentElement.classList.add('active');
            });
        });

        // Highlight the current active link based on the current URL
        const currentUrl = window.location.href;
        sidebarLinks.forEach(link => {
            if (link.href === currentUrl) {
                link.parentElement.classList.add('active');
            }
        });
    });
</script>
