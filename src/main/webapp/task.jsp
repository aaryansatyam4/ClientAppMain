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
        HashSet<String> adminRoles = new HashSet<>(Arrays.asList("admin", "superadmin"));
        if ("admin".equals(username) || "superadmin".equals(username)) {
            isAdminOrSuperAdmin = true;
        }

        transaction.commit();
    } catch (Exception e) {
        if (transaction != null) {
            transaction.rollback();
        }
        e.printStackTrace();
    } finally {
        hibernateSession.close();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin & Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
    <link rel="shortcut icon" href="./assets/img/icons/icon-48x48.png" />
    <link rel="canonical" href="https://demo-basic.adminkit.io/" />
    <title>Task</title>
    <link href="./assets/css/app.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/3.0.2/css/buttons.dataTables.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script>
        div.dt-button-collection {
            width: 400px;
        }
        div.dt-button-collection button.dt-button {
            display: inline-block;
            width: 32%;
        }
        div.dt-button-collection button.buttons-colvis {
            display: inline-block;
            width: 49%;
        }
        div.dt-button-collection h3 {
            margin-top: 5px;
            margin-bottom: 5px;
            font-weight: 100;
            border-bottom: 1px solid rgba(150, 150, 150, 0.5);
            font-size: 1em;
            padding: 0 1em;
        }
        div.dt-button-collection h3.not-top-heading {
            margin-top: 10px;
        }
    </script>
</head>
<body>
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
                                    <Strong class="h3 mb-3">Tasks</Strong>
                                    <%
                                    if (isAdminOrSuperAdmin) {
                                    %>
                                    <button type="button" class="btn btn-link float-end newEmployee">Add New Task</button>
                                    <%
                                    }
                                    %>
                                </div>
                                <div class="card-body">
                                    <div class="">
                                        <table id="example" class="display" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <th>Task ID</th>
                                                    <th>Task Description</th>
                                                    <th>Severity</th>
                                                    <th>Remarks</th>
                                                    <th>Assigned To</th>
                                                    <th>Assign Date</th>
                                                    <th>Current Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (TicketsModel ticket : assignedTickets) { %>
                                                <tr>
                                                    <td>
                                                        <a href="#" class="ticket-link" data-id="<%= ticket.getId() %>"><%= ticket.getId() %></a>
                                                    </td>
                                                    <td><%= ticket.getTicketDescription() %></td>
                                                    <td><%= ticket.getSeverity() %></td>
                                                    <td><%= ticket.getRemark() %></td>
                                                    <td><%= ticket.getAssignee() %></td>
                                                    <td><%= new java.text.SimpleDateFormat("dd-MM-yyyy").format(ticket.getCreatedAt()) %></td>
                                                    <td><%= ticket.getStatus() %></td>
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
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>

    <!-- Modal for displaying ticket details -->
    <div id="ticketModal" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ticket Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p><strong>Task ID:</strong> <span id="ticketId"></span></p>
                    <p><strong>Description:</strong> <span id="ticketDescription"></span></p>
                    <p><strong>Severity:</strong> <span id="ticketSeverity"></span></p>
                    <p><strong>Remarks:</strong> <span id="ticketRemarks"></span></p>
                    <p><strong>Assigned To:</strong> <span id="ticketAssignee"></span></p>
                    <p><strong>Assign Date:</strong> <span id="ticketAssignDate"></span></p>
                    <p><strong>Status:</strong> <span id="ticketStatus"></span></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="./assets/js/app.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/dataTables.buttons.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.colVis.min.js"></script>

    <script>
    new DataTable(
			'#example',
			{
				layout : {
					topStart : {
						buttons : [ {
							extend : 'collection',
							className : 'custom-html-collection',
							buttons : [
									'<h3>Export</h3>',
									'pdf',
									'csv',
									'excel',
									'<h3 class="not-top-heading">Column Visibility</h3>',
									'columnsToggle' ]
						} ]
					}
				}
			});

        $(document).ready(function() {
            $('.ticket-link').click(function(e) {
                e.preventDefault();
                var ticketId = $(this).data('id');

                // AJAX call to fetch ticket details
                $.ajax({
                    url: 'TicketDetailsServlet1',
                    method: 'GET',
                    data: { id: ticketId },
                    success: function(response) {
                        var ticket = JSON.parse(response);
                        $('#ticketId').text(ticket.id);
                        $('#ticketDescription').text(ticket.ticketDescription);
                        $('#ticketSeverity').text(ticket.severity);
                        $('#ticketRemarks').text(ticket.remark);
                        $('#ticketAssignee').text(ticket.assignee);
                        $('#ticketAssignDate').text(new Date(ticket.createdAt).toLocaleDateString());
                        $('#ticketStatus').text(ticket.status);

                        // Show the modal
                        $('#ticketModal').modal('show');
                    }
                });
            });

            $('.newEmployee').click(function(){
                location.href= "newTask.jsp";
            });
        });
    </script>
</body>
</html>
