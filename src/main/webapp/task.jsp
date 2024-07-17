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
    <title>Task </title>
    <link href="./assets/css/app.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.0.5/css/buttons.dataTables.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        /* Modal styles, animation, and other CSS */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            border-radius: 10px;
            width: 80%;
            max-width: 800px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            animation: fadeIn 0.3s;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e5e5e5;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .modal-header h2 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
        }
        .table {
            width: 100%;
            margin-bottom: 1rem;
            color: #212529;
        }
        .table th,
        .table td {
            padding: 0.75rem;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }
        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <!-- Include your sidebar and navigation -->
        <jsp:include page="sidebar.jsp"></jsp:include>
        <div class="main">
            <jsp:include page="nav.jsp"></jsp:include>
            <main class="content">
                <div class="container-fluid p-0">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong class="h3 mb-3">Tasks</strong>
                                   <button type="button" class="btn btn-link float-end" id="openAddTaskModal">Add New Task</button>
                                </div>
                                <div class="card-body">
                                    <table id="ticketTable" class="display" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th>Ticket ID</th>
                                                <th>Title</th>
                                                <th>Description</th>
                                                <th>Severity</th>
                                                <th>Assignee</th>
                                                <th>Status</th>
                                                <th>Due Date</th>
                                                <th>Updated At</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Table rows will be populated dynamically -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <!-- Modal for displaying task details -->
            <div id="ticketModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Ticket Details</h2>
                        <span class="close">&times;</span>
                    </div>
                    <table class="table table-striped">
                        <tr>
                            <th>Ticket ID</th>
                            <td id="modalTicketId"></td>
                        </tr>
                        <tr>
                            <th>Title</th>
                            <td id="modalTitle"></td>
                        </tr>
                        <tr>
                            <th>Description</th>
                            <td id="modalDescription"></td>
                        </tr>
                        <tr>
                            <th>Severity</th>
                            <td id="modalSeverity"></td>
                        </tr>
                        <tr>
                            <th>Assignee</th>
                            <td id="modalAssignee"></td>
                        </tr>
                        <tr>
                            <th>Status</th>
                            <td id="modalStatus"></td>
                        </tr>
                        <tr>
                            <th>Due Date</th>
                            <td id="modalDueDate"></td>
                        </tr>
                        <tr>
                            <th>Updated At</th>
                            <td id="modalUpdatedAt"></td>
                        </tr>
                        <tr>
                            <th>Remark</th>
                            <td id="modalRemark"></td>
                        </tr>
                        <tr>
                            <th>Created At</th>
                            <td id="modalCreatedAt"></td>
                        </tr>
                        <tr>
                            <th>Created By</th>
                            <td id="modalCreatedBy"></td>
                        </tr>
                        <tr>
                            <th>Completed At</th>
                            <td id="modalCompletedAt"></td>
                        </tr>
                        <tr>
                            <th>Manager</th>
                            <td id="modalManager"></td>
                        </tr>
                    </table>
                </div>
            </div>
            
            
            
              <!-- Add New Task Modal -->
            <div id="addTaskModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Add New Task</h2>
                        <span class="close">&times;</span>
                    </div>
                    <div class="modal-body">
                        <form id="addTaskForm">
                            <div class="form-group">
                                <label for="ticket_name">Ticket Name</label>
                                <input type="text" id="ticket_name" name="ticket_name" required>
                            </div>
                            <div class="form-group">
                                <label for="ticket_description">Ticket Description</label>
                                <input type="text" id="ticket_description" name="ticket_description" required>
                            </div>
                            <div class="form-group">
                                <label for="severity">Severity</label>
                                <select id="severity" name="severity" required>
                                    <option value="Low">Low</option>
                                    <option value="Medium">Medium</option>
                                    <option value="High">High</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="due_date">Due Date</label>
                                <input type="date" id="due_date" name="due_date" required>
                            </div>
                            <div class="form-group">
                                <label for="employee_id">Assignee (Employee ID)</label>
                                <input type="text" id="employee_id" name="employee_id" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Task</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Include footer -->
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>

    <!-- JavaScript dependencies -->
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.0.5/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.0.5/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.0.5/js/buttons.print.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.0.5/js/buttons.colVis.min.js"></script>
    
    <script>
    $(document).ready(function() {
        // Initialize DataTable with buttons
        var table = $('#ticketTable').DataTable({
            dom: 'Bfrtip', // Display buttons for export and column visibility
            buttons: [
                'pdf', 'csv', 'excel', // Export buttons
                'colvis' // Column visibility toggle
            ]
        });

        function populateDataTable() {
            $.ajax({
                url: 'http://localhost:8080/v1/api/t/c', 
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    console.log(response);
                    if (response && response.status === "success") {
                        var tickets = JSON.parse(response.tickets); 
                        if (tickets && tickets.length > 0) {
                            tickets.forEach(function(ticket) {
                                table.row.add([
                                    '<a href="#" class="ticketId" data-ticket-id="' + ticket.ticketId + '">' + ticket.ticketId + '</a>',
                                    ticket.title,
                                    ticket.description,
                                    ticket.severity,
                                    ticket.assignee,
                                    ticket.status,
                                    ticket.DueDate,
                                    ticket.updatedAt,
                                    
                                ]).draw(false);
                            });
                        }
                    } else {
                        console.error('Failed to fetch tickets:', response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to fetch tickets:', error);
                }
            });
        }
        populateDataTable();

        // Modal handling code
        var modal = document.getElementById("ticketModal");
        var span = document.getElementsByClassName("close")[0];

        $(document).on("click", ".ticketId", function(e) {
            e.preventDefault();
            var ticketId = $(this).data('ticket-id');
            $.ajax({
                url: 'http://localhost:8080/v1/api/t/c/' + ticketId,
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    if (response.status === "success") {
                        var ticket = response.ticket;
                        $("#modalTicketId").text(ticket.ticketId);
                        $("#modalTitle").text(ticket.title);
                        $("#modalDescription").text(ticket.description);
                        $("#modalSeverity").text(ticket.severity);
                        $("#modalAssignee").text(ticket.assignee);
                        $("#modalStatus").text(ticket.status);
                        $("#modalDueDate").text(ticket.DueDate);
                        $("#modalUpdatedAt").text(ticket.updatedAt);
                        $("#modalRemark").text(ticket.Remark);
                        $("#modalCreatedAt").text(ticket.createdAt);
                        $("#modalCreatedBy").text(ticket.createdBy);
                        $("#modalCompletedAt").text(ticket.CompletedAt);
                        $("#modalManager").text(ticket.Manager);
                        modal.style.display = "block";
                    } else {
                        alert('Failed to fetch ticket details: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to fetch ticket details:', error);
                }
            });
        });
        
        
        
        // Open Add Task Modal
        $('#openAddTaskModal').on('click', function() {
            $('#addTaskModal').css('display', 'block');
        });
        
        window.onclick = function(event) {
            if (event.target == document.getElementById('ticketModal') ||
                event.target == document.getElementById('addTaskModal')) {
                $('.modal').css('display', 'none');
            }
        }
        

        // Close modal when clicking on close button (x)
        span.onclick = function() {
            modal.style.display = "none";
        };
    });
    </script>
</body>
</html>
