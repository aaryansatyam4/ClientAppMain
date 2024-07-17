<%@ page import="com.digicode.dao.LoginServiceImpl" %>
<%@ page import="com.digicode.model.EmployeeModel" %>
<%@ page import="com.digicode.model.TicketsModel" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%
    // Initialize the username variable
    String username = "Guest";
    
    // Get the cookies from the request
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("user".equals(cookie.getName())) {
                username = cookie.getValue();
                break;
            }
        }
    }
    
    LoginServiceImpl loginService = new LoginServiceImpl();
    EmployeeModel user = loginService.getUserById(username);
    String position = user != null ? user.getPosition() : "user";
    
    // Fetch unread tickets for notifications
    List<TicketsModel> unreadTickets = loginService.getUnreadTicketsByAssignee(username);
%>

<nav class="navbar navbar-expand navbar-light navbar-bg">
    <a class="sidebar-toggle js-sidebar-toggle">
        <i class="hamburger align-self-center"></i>
    </a>

    <div class="navbar-collapse collapse">
        <ul class="navbar-nav navbar-align">
            <%-- Conditionally display "Plant" dropdown for super_admin --%>
            <% if ("super_admin".equals(position)) { %>
                <li>
                    <select id="plant" class="form-control browser-default custom-select">
                        <option value="global">Global</option>
                        <option value="Plant1">Plant1</option>
                        <option value="Plant2">Plant2</option>
                        <option value="Plant3">Plant3</option>
                    </select>
                </li>
            <% } %>

            <!-- Notifications dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
                    <div class="position-relative">
                        <i class="align-middle" data-feather="bell"></i>
                        <span class="indicator"><%= unreadTickets.size() %></span>
                    </div>
                </a>
                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
                    <div class="dropdown-menu-header"><%= unreadTickets.size() %> New Notifications</div>
                    <div class="list-group">
                        <% for (TicketsModel ticket : unreadTickets) { %>
                            <a href="#" class="list-group-item mark-as-read" data-ticket-id="<%= ticket.getId() %>">
                                <div class="row g-0 align-items-center">
                                    <div class="col-2">
                                        <i class="text-danger" data-feather="alert-circle"></i>
                                    </div>
                                    <div class="col-10">
                                        <div class="text-dark"><%= ticket.getTicketName() %></div>
                                        <div class="text-muted small mt-1"><%= ticket.getTicketDescription() %></div>
                                        <div class="text-muted small mt-1">Created <%= ticket.getCreatedAt() %></div>
                                    </div>
                                </div>
                            </a>
                        <% } %>
                    </div>
                </div>
            </li>

            <!-- Other navigation items -->
            <li class="nav-item dropdown">
                <a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-bs-toggle="dropdown">
                    <i class="align-middle" data-feather="settings"></i>
                </a>
                <a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
                    <span class="text-dark">Hi <%= user != null ? user.getFirstName() : "Guest" %></span>
                </a>
                <div class="dropdown-menu dropdown-menu-end">
                    <a class="dropdown-item" href="profile.jsp"><i class="align-middle me-1" data-feather="user"></i> Profile</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="logout1">Log out</a>
                </div>
            </li>
        </ul>
    </div>
</nav>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const alertsDropdown = document.getElementById("alertsDropdown");

    if (alertsDropdown) {
        alertsDropdown.addEventListener("click", function() {
            const username = "<%= username %>";
          

            fetch("MarkNotificationsReadServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams({username: username})
            })
            .then(response => response.text())
            .then(result => {
                
                if (result === "success") {
                    console.log("Notifications marked as read.");
                } else {
                    console.log("Failed to mark notifications as read.");
                }
            })
            .catch(error => console.error("Error:", error));
        });
    }
});
</script>

