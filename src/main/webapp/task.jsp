<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="java.util.List" %>
<%@ page import="com.digicode.model.TicketsModel" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.HashSet" %>
<%
    // Initialize Hibernate SessionFactory
    Configuration configuration = new Configuration().configure();
    SessionFactory sessionFactory = configuration.buildSessionFactory();

    // Open a new Hibernate Session
    Session hibernateSession = sessionFactory.openSession();

    Transaction transaction = null;

    String username = "Guest";
    List<TicketsModel> assignedTickets = new ArrayList<>();
    boolean isAdminOrSuperAdmin = false; // Flag to check admin or super admin status

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
        org.hibernate.Query query = hibernateSession.createQuery("FROM TicketsModel WHERE assignee = :username");
        query.setParameter("username", username);
        assignedTickets = query.list();

        // Check if the user is admin or super admin
        // Assuming roles are stored in a database and retrieved here
        HashSet<String> adminRoles = new HashSet<>(Arrays.asList("admin", "super_admin"));
        if (adminRoles.contains(username)) {
            isAdminOrSuperAdmin = true;
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
    }
%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
    <link rel="shortcut icon" href="./assets/img/icons/icon-48x48.png" />
    <title>Task</title>
    <link href="./assets/css/app.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/3.0.2/css/buttons.dataTables.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
/* Modal Overlay */
.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.5); /* Dark overlay */
}

/* Modal Content */
.modal-content {
    background-color: #fff;
    margin: 5% auto; /* Center the modal */
    padding: 20px;
    border-radius: 10px; /* Rounded corners */
    width: 90%;
    max-width: 800px; /* Increased max-width for better table display */
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* Soft shadow */
    animation: slideIn 0.5s; /* Slide-in animation */
    overflow-x: auto; /* Horizontal scroll for small screens */
}

/* Close Button */
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}

/* Table Styles */
.modal-content table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    font-size: 14px;
}

.modal-content th, 
.modal-content td {
    padding: 12px;
    text-align: left;
    border: 1px solid #ddd;
}

.modal-content th {
    background-color: #f4f4f4;
    font-weight: bold;
}

.modal-content td {
    background-color: #fff;
}

.modal-content tr:nth-child(even) td {
    background-color: #f9f9f9; /* Alternate row colors */
}

/* Adjustments for mobile view */
@media screen and (max-width: 600px) {
    .modal-content table {
        font-size: 12px;
    }
}

/* Animations */
@keyframes slideIn {
    from { transform: translateY(-100px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

      /* Example: Override row selection background */
table.dataTable > tbody > tr.selected > * {
  box-shadow: inset 0 0 0 9999px rgba(255, 0, 0, 0.5); /* Custom background color */
}

/* Example: Override header styles */
table.dataTable th {
  background-color: #f0f0f0; /* Custom header background color */
  color: #333; /* Custom header text color */
}
.textc{
color:#72A0C1;
}
      
    </style>
    <style>
    .preloader {
        background: rgba(0, 0, 0, 0.5); /* Semi-transparent black background */
        backdrop-filter: blur(10px); /* Adjust blur radius as needed */
        -webkit-backdrop-filter: blur(10px); /* For Safari */
        height: 100vh; /* Full viewport height */
        width: 100vw; /* Full viewport width */
        position: fixed;
        top: 0;
        left: 0;
        z-index: 100;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .preloader::before {
        content: '';
        background: url("./assets/img/photos/preloader.png") no-repeat center center;
        background-size: 300px; /* Fixed size for the preloader image */
        width: 300px; /* Fixed width for the preloader image */
        height: 300px; /* Fixed height for the preloader image */
        position: absolute;
        animation: rotate 15s infinite linear; /* Rotation animation */
    }

    @keyframes rotate {
        from {
            transform: rotate(0deg);
        }
        to {
            transform: rotate(360deg);
        }
    }
</style>
</head>

<body>
   <script>
        // JavaScript to hide the preloader after a delay
        document.addEventListener("DOMContentLoaded", function() {
            var loader = document.getElementById("preloader");

            // Add a delay of 1.5 seconds (1500 milliseconds) before hiding the preloader
            setTimeout(function () {
                loader.style.display = "none";
            }, 1500);
        });
    </script>
<div class="preloader" id="preloader"></div>
    <div class="wrapper">
        <jsp:include page="sidebar.jsp"></jsp:include>
        <div class="main">
            <jsp:include page="nav.jsp"></jsp:include>
            <main class="content">
                <div class="container-fluid p-0">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <Strong class="h3 mb-3">Tasks </Strong>
                                    <% if (isAdminOrSuperAdmin) { %>
                                        <button type="button" class="btn btn-link float-end newEmployee">Add New task</button>
                                    <% } %>
                                </div>
                                <div class="card-body">
                                    <div class="">
                                        <table id="example" class="display" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <th>Task ID</th>
                                                    <th>Task Description</th>
                                                    <th>Severity</th>
                                                   
                                                    <th>Assign Date</th>
                                                    <th>Current Status</th>
                                                    <th>Remarks</th>
                                                    
                                                </tr>
                                            </thead>
                                           <tbody>
    <% for (TicketsModel ticket : assignedTickets) { %>
        <tr>
            <td class="taskId textc" 
                data-task-id="<%= ticket.getId() %>"
                data-description="<%= ticket.getTicketDescription() %>"
                data-severity="<%= ticket.getSeverity() %>"
                data-remarks="<%= ticket.getRemark() %>"
                data-assignee="<%= ticket.getAssignee() %>"
                data-created-at="<%= new java.text.SimpleDateFormat("dd-MM-yyyy").format(ticket.getCreatedAt()) %>"
                data-status="<%= ticket.getStatus() %>"
                data-due-date="<%= ticket.getDueDate() != null ? new java.text.SimpleDateFormat("dd-MM-yyyy").format(ticket.getDueDate()) : "" %>"
                data-completed-at="<%= ticket.getCompletedAt() != null ? new java.text.SimpleDateFormat("dd-MM-yyyy").format(ticket.getCompletedAt()) : "" %>"
               
                data-ticket-name="<%= ticket.getTicketName() %>"
                data-created-by="<%= ticket.getCreatedBy() %>"
                data-updated-by="<%= ticket.getUpdatedBy() %>"
                data-updated-at="<%= ticket.getUpdatedAt() != null ? new java.text.SimpleDateFormat("dd-MM-yyyy").format(ticket.getUpdatedAt()) : "" %>"
                data-manager="<%= ticket.getManager() %>">
                <%= ticket.getId() %>
            </td>
            <td><%= ticket.getTicketDescription() %></td>
            <td><%= ticket.getSeverity() %></td>
            
            <td><%= new java.text.SimpleDateFormat("dd-MM-yyyy").format(ticket.getCreatedAt()) %></td>
            <td><%= ticket.getStatus() %></td>
            <td><%= ticket.getRemark() %></td>
        </tr>
    <% } %>
</tbody>
                                           
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <div id="ticketModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Tasks Details</h2>
        <table>
            <tr>
                <th>Ticket ID</th>
                <td id="ticketId" ></td>
            </tr>
            <tr>
                <th>Task Name</th>
                <td id="ticketName"></td>
            </tr>
            <tr>
                <th>Task Description</th>
                <td id="ticketDescription"></td>
            </tr>
            <tr>
                <th>Severity</th>
                <td id="ticketSeverity"></td>
            </tr>
            <tr>
                <th>Remarks</th>
                <td id="ticketRemarks"></td>
            </tr>
            <tr>
                <th>Assigned To</th>
                <td id="ticketAssignee"></td>
            </tr>
            <tr>
                <th>Assign Date</th>
                <td id="ticketCreatedAt"></td>
            </tr>
            <tr>
                <th>Due Date</th>
                <td id="ticketDueDate"></td>
            </tr>
            <tr>
                <th>Completed At</th>
                <td id="ticketCompletedAt"></td>
            </tr>
            <tr>
                <th>Current Status</th>
                <td id="ticketStatus"></td>
            </tr>
            <tr>
                <th>Created By</th>
                <td id="ticketCreatedBy"></td>
            </tr>
            <tr>
                <th>Updated By</th>
                <td id="ticketUpdatedBy"></td>
            </tr>
            <tr>
                <th>Updated At</th>
                <td id="ticketUpdatedAt"></td>
            </tr>
            <tr>
                <th>Manager</th>
                <td id="ticketManager"></td>
            </tr>
        </table>
    </div>
</div>
            

            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>

    <script src="./assets/js/app.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/dataTables.buttons.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.dataTables.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.colVis.min.js"></script>

    <script>
    $(document).ready(function () {
        // Initialize DataTable with separate buttons for Export and Column Visibility
        var table = $('#example').DataTable({
            buttons: [
                {
                    extend: 'collection',
                    text: 'Export <i class="fa fa-caret-down" aria-hidden="true"></i>',
                    buttons: [
                        'pdf',
                        'csv',
                        'excel'
                    ]
                },
                {
                    extend: 'collection',
                    text: 'Column Visibility <i class="fa fa-caret-down" aria-hidden="true"></i>',
                    buttons: ['columnsToggle']
                }
            ],
            dom: 'Bfrtip' // Display buttons
        });

        // Redirect to new task page on button click
        $('.newEmployee').click(function () {
            location.href = "newTask.jsp";
        });

        // Modal functionality
        var modal = document.getElementById("ticketModal");
        var span = document.getElementsByClassName("close")[0];

        // Event delegation for dynamically loaded content
        $(document).on("click", ".taskId", function () {
            // Populate the modal with data from the clicked task ID column
            $("#ticketId").text($(this).data("task-id"));
            $("#ticketName").text($(this).data("ticket-name"));
            $("#ticketDescription").text($(this).data("description"));
            $("#ticketSeverity").text($(this).data("severity"));
            $("#ticketRemarks").text($(this).data("remarks"));
            $("#ticketAssignee").text($(this).data("assignee"));
            $("#ticketCreatedAt").text($(this).data("created-at"));
            $("#ticketDueDate").text($(this).data("due-date"));
            $("#ticketCompletedAt").text($(this).data("completed-at"));
            $("#ticketStatus").text($(this).data("status"));
            $("#ticketCreatedBy").text($(this).data("created-by"));
            $("#ticketUpdatedBy").text($(this).data("updated-by"));
            $("#ticketUpdatedAt").text($(this).data("updated-at"));
            $("#ticketManager").text($(this).data("manager"));

            // Display the modal
            modal.style.display = "block";
        });

        // Close the modal when the user clicks the "close" button
        span.onclick = function () {
            modal.style.display = "none";
        };

        // Close the modal when the user clicks outside the modal content
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        };
    });


    </script>

</body>

</html>
                    
