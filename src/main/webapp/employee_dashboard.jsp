<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="java.util.List" %>
<%@ page import="com.digicode.model.TicketsModel" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.digicode.model.EmployeeModel" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.digicode.model.TicketLogs" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
    List<EmployeeModel> users = new ArrayList<>();
    Long logCount = 0L; // To count the number of logs created by the user
    Long totalTicketsCount = 0L; // To count the total number of tickets
    Long pendingTicketsCount = 0L; // To count the number of pending tickets
    long[] monthlyCompletedCounts = new long[12];
    
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
        org.hibernate.Query query = hibernateSession.createQuery("FROM TicketsModel WHERE assignee = :username AND status != 'Completed'");
        query.setParameter("username", username);
        assignedTickets = query.list();

        // Query count of tickets by severity
        highSeverityCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE severity = 'High' AND status != 'Completed' AND assignee = :username").setParameter("username", username).uniqueResult();
        mediumSeverityCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Medium' AND status != 'Completed' AND assignee = :username").setParameter("username", username).uniqueResult();
        lowSeverityCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Low' AND status != 'Completed' AND assignee = :username").setParameter("username", username).uniqueResult();
        completedCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE status = 'Completed' AND assignee = :username").setParameter("username", username).uniqueResult();

        // Query all users for transfer options
        users = hibernateSession.createQuery("FROM EmployeeModel").list();
        
        // Query number of logs created by the user
        logCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketLogs WHERE createdBy = :username").setParameter("username", username).uniqueResult();

        // Query total tickets count
        totalTicketsCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE assignee = :username").setParameter("username", username).uniqueResult();

        // Query pending tickets count
        pendingTicketsCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE status != 'Completed' AND assignee = :username").setParameter("username", username).uniqueResult();

        
        // Query the number of completed tickets per month
        List<Object[]> completedPerMonth = hibernateSession.createQuery(
            "SELECT MONTH(CompletedAt), COUNT(*) FROM TicketsModel WHERE status = 'Completed' AND assignee = :username GROUP BY MONTH(CompletedAt)"
        ).setParameter("username", username).list();
        
        for (Object[] result : completedPerMonth) {
            int month = ((Integer) result[0]) - 1; // Months in Java are 0-based for arrays
            long count = (Long) result[1];
            monthlyCompletedCounts[month] = count;
        }
        
        
        
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        .card-equal-height {
            height: 100%;
        }
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%;
            height: 100%; 
            overflow: auto; 
            background-color: rgb(0,0,0); 
            background-color: rgba(0,0,0,0.4); 
            padding-top: 60px; 
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 80%; 
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
            .chart-container {
        position: relative;
        width: 100%;
        height: 300px; /* Adjust height as needed */
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
                         <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2"><%= pendingTicketsCount %></h3>
                                            <p class="mb-0">Pending Tasks</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-hourglass-half text-warning fa-2x"></i>
                                            
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
                                            <h3 class="mb-2"><%= totalTicketsCount %></h3>
                                            <p class="mb-0">Total Tasks</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-tasks text-info fa-2x"></i>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
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
                                            <i class="fa fa-arrow-down text-success fa-2x"></i>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                       
                    </div>
                    
                    <!-- Logs Created by the User -->
                   
                </div>
                
              <div class="row">
                    <div class="col-lg-6 mb-3">
                        <div class="card card-equal-height">
                            <div class="chart-container">
                                <h6 class="card-title">Completed Tickets Per Month</h6>
                                <canvas id="monthlyCompletedChart" class="chart-container"></canvas>
                            </div>
                        </div>
                    </div>
                     <div class="col-lg-6 mb-3">
                        <div class="card card-equal-height">
                            <div class="chart-container">
                                <h6 class="card-title">Completed Tickets Per Month</h6>
                                <canvas id="severityChart"></canvas>
                                
                            </div>
                        </div>
                    </div>
                </div>
                
                
   
                
                <%-- Pending Tickets Table --%>
<div class="row">
    <div class="col-xl-12 col-xxl-12 d-flex">
        <div class="card flex-fill w-100">
            <div class="card-header">
                <h5 class="card-title">ONGOING TASKS</h5>
            </div>
            <div class="card-body">
                <table class="table table-hover my-0">
                    <thead>
                        <tr>
                            <th>Ticket Name</th>
                            <th class="d-none d-xl-table-cell">Ticket Id</th>
                            <th>Severity</th>
                            <th class="d-none d-md-table-cell">Remarks</th>
                            <th class="d-none d-md-table-cell">Assigned By</th>
                            <th>Action</th>
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
                                <td><button class="btn btn-primary" onclick="openModal('<%= ticket.getId() %>')">Action</button></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


 
                
            </main>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
                    

                    

                    <%-- The Modal --%>
<div id="ticketModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <form method="post" action="ticketAction">
            <input type="hidden" name="ticketId" id="ticketId">
            <div class="form-group">
                <label for="action">Action</label>
                <select name="action" id="action" class="form-control" onchange="handleActionChange()">
                    <option value="completed">Mark as Completed</option>
                    <option value="transfer">Transfer to</option>
                </select>
            </div>
            <div class="form-group" id="transferToGroup" style="display:none;">
                <label for="transferTo">Transfer To</label>
                <select name="transferTo" id="transferTo" class="form-control">
                    <% for (EmployeeModel user : users) { %>
                        <option value="<%= user.getUserId() %>"><%= user.getFirstName() %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="remarks">Remarks</label>
                <textarea name="remarks" id="remarks" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>

<script>
    var modal = document.getElementById("ticketModal");
    var span = document.getElementsByClassName("close")[0];
    var transferToGroup = document.getElementById("transferToGroup");

    function openModal(ticketId) {
        document.getElementById("ticketId").value = ticketId;
        modal.style.display = "block";
    }

    span.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    function handleActionChange() {
        var action = document.getElementById("action").value;
        if (action === "transfer") {
            transferToGroup.style.display = "block";
        } else {
            transferToGroup.style.display = "none";
        }
    }
</script>

<script>
var ctx = document.getElementById('severityChart').getContext('2d');
var severityChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['High Severity', 'Medium Severity', 'Low Severity'],
        datasets: [{
            label: 'Severity Counts',
            data: [<%= highSeverityCount %>, <%= mediumSeverityCount %>, <%= lowSeverityCount %>],
            backgroundColor: [
                'rgba(255, 99, 132, 0.6)', // Red for High Severity
                'rgba(255, 206, 86, 0.6)', // Yellow for Medium Severity
                'rgba(54, 162, 235, 0.6)' // Blue for Low Severity
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(54, 162, 235, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
            display: true,
            position: 'bottom',
            labels: {
                fontColor: '#333',
                fontSize: 12
            }
        }
    }
});
</script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var ctxBar = document.getElementById('monthlyCompletedChart').getContext('2d');
        var monthlyCompletedChart = new Chart(ctxBar, {
            type: 'bar',
            data: {
                labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                datasets: [{
                    label: 'Completed Tickets',
                    data: <%= new com.google.gson.Gson().toJson(monthlyCompletedCounts) %>,
                    backgroundColor: 'rgba(75, 192, 192, 0.6)', // Light teal
                    borderColor: 'rgba(75, 192, 192, 1)', // Teal
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 5 // Adjust the step size here as needed
                        }
                    }
                },
                plugins: {
                    tooltip: {
                        enabled: false // Disable tooltips
                    },
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: {
                            fontColor: '#333',
                            fontSize: 12
                        }
                    }
                },
                hover: {
                    mode: null // Disable hovering effect
                },
                interaction: {
                    mode: 'index', // Keep track of index for tooltips
                    intersect: false
                }
            }
        });

        // Ensure chart resizes with container
        window.addEventListener('resize', function () {
            monthlyCompletedChart.resize();
        });
    });
</script>



   

    <script src="./assets/js/app.js"></script>
</body>
</html>
