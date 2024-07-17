<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="java.util.List" %>
<%@ page import="com.digicode.model.TicketsModel" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Initialize Hibernate SessionFactory
    Configuration configuration = new Configuration().configure();
    SessionFactory sessionFactory = configuration.buildSessionFactory();

    // Open a new Hibernate Session
    Session hibernateSession = sessionFactory.openSession();

    Transaction transaction = null;

    String username = "Guest";
    List<TicketsModel> assignedTickets = new ArrayList<>();
    Long highSeverityCount = 0L;
    Long mediumSeverityCount = 0L;
    Long lowSeverityCount = 0L;
    Long completedCount = 0L;

    try {
        transaction = hibernateSession.beginTransaction();

        // Retrieve username from cookies
        javax.servlet.http.Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (javax.servlet.http.Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    username = cookie.getValue();
                    break;
                }
            }
        }

        // Query tickets assigned to the user
        org.hibernate.Query query = hibernateSession.createQuery("FROM TicketsModel WHERE created_by= :'super_admin' AND status !='Completed' ");
        
        assignedTickets = query.list();

        // Query count of tickets by severity
        highSeverityCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE severity = 'High' AND status != 'Completed'  AND assignee = :username").setParameter("username", username).uniqueResult();
        mediumSeverityCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Medium' AND status != 'Completed'  AND assignee = :username").setParameter("username", username).uniqueResult();
        lowSeverityCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Low' AND status != 'Completed'  AND assignee = :username").setParameter("username", username).uniqueResult();
        completedCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE status = 'Completed' AND assignee = :username").setParameter("username", username).uniqueResult();

        transaction.commit();
    } catch (Exception e) {
        if (transaction != null) {
            transaction.rollback();
        }
        e.printStackTrace();
    } finally {
        // Close Hibernate session
        hibernateSession.close();
        // Close Hibernate SessionFactory (not necessary in simple cases)
        // sessionFactory.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Dashboard</title>
    <!-- Include your CSS and other head elements -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin & Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="./assets/img/icons/icon-48x48.png" />
    <link rel="canonical" href="https://demo-basic.adminkit.io/" />
    <link href="./assets/css/app.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .card-equal-height {
            height: 100%;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <jsp:include page="sidebar.jsp"></jsp:include>
        <div class="main">
            <jsp:include page="nav.jsp"></jsp:include>
            <main class="content">
                <div class="container-fluid p-0">
                    <!-- Top Boxes -->
                    <div class="row">
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2"><%= highSeverityCount %></h3>
                                            <p class="mb-0">High Severity</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-exclamation-triangle text-danger fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2"><%= mediumSeverityCount %></h3>
                                            <p class="mb-0">Medium Severity</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-exclamation-circle text-warning fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2"><%= lowSeverityCount %></h3>
                                            <p class="mb-0">Low Severity</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-info-circle text-info fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2"><%= completedCount %></h3>
                                            <p class="mb-0">Completed</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-check-circle text-success fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                 
                    <!-- Pending Tickets -->
                    <div class="row">
                        <div class="col-xl-12 col-xxl-12 d-flex">
                            <div class="card flex-fill w-100">
                                <div class="card-header">
                                    <h5 class="card-title">Pending Tickets</h5>
                                </div>
                                <div class="card-body">
                                    <table class="table table-hover my-0">
                                        <thead>
                                            <tr>
                                                <th>Ticket Name</th>
                                                <th class="d-none d-xl-table-cell">Ticket Id</th>
                                                <th>Severity</th>
                                                <th class="d-none d-md-table-cell">Remarks </th>
                                                <th class="d-none d-md-table-cell">Assigned By</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (TicketsModel ticket : assignedTickets) { %>
                                                <tr>
                                                    <td><%= ticket.getTicketName() %></td>
                                                    <td class="d-none d-xl-table-cell"><%= ticket.getId() %></td>
                                                    <td><span class="badge bg-danger"><%= ticket.getSeverity() %></span></td>
                                                    <td class="d-none d-md-table-cell"><%= ticket.getRemark() %></td>
                                                    <td class="d-none d-md-table-cell"><%= ticket.getCreatedBy() %></td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
    <script src="./assets/js/app.js"></script>
</body>
</html>