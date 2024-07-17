<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin & Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="./assets/img/icons/icon-48x48.png" />

    <link rel="canonical" href="https://demo-basic.adminkit.io/" />

    <title>AdminKit Demo - Bootstrap 5 Admin Template</title>

    <link href="./assets/css/app.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/3.0.2/css/buttons.dataTables.css" rel="stylesheet">

    <style>
        label {
            font-weight: 600;
            color: #666;
        }
        body {
            background: #f1f1f1;
            font-family: 'Inter', sans-serif;
        }
        .box8 {
            box-shadow: 0px 0px 5px 1px #999;
        }
        .mx-t3 {
            margin-top: -3rem;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #fff;
            border-bottom: none;
        }
        .card-body {
            padding: 2rem;
        }
        h2 {
            font-size: 1.75rem;
            margin-bottom: 1.5rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
            font-size: 1.25rem;
        }
        select, input, textarea {
            border-radius: 8px;
            border: 1px solid #ccc;
            padding: 0.75rem;
            font-size: 1rem;
        }
        button {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-size: 1rem;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <jsp:include page="sidebar.jsp"></jsp:include>

        <div class="main">
            <jsp:include page="nav.jsp"></jsp:include>

            <!-- main container start -->
            <main class="content">
                <div class="container-fluid p-0">
                    <div class="row justify-content-center">
                        <div class="col-lg-8 col-md-10">
                            <div class="card mt-5">
                                <div class="card-header text-center">
                                    <h2 class="text-info">New Ticket Form</h2>
                                </div>
                                <div class="card-body">
                                    <form id="taskFrm">
                                        <div class="form-group">
                                            <label for="group-dropdown">Ticket Group</label>
                                            <select class="form-control" name="groupName" id="group-dropdown" required>
                                                <option value="">Select Existing or Custom Group Name</option>
                                                <option value="Custom">Custom</option>
                                            </select>
                                            <input type="text" class="form-control mt-2" id="group-input" name="groupInput" placeholder="Enter Custom Group Name" style="display: none;">
                                        </div>

                                        <div class="form-group">
                                            <label for="subgroup-dropdown">Ticket Subgroup</label>
                                            <select class="form-control" name="subgroupName" id="subgroup-dropdown" required>
                                                <option value="">Select Existing or Custom Subgroup Name</option>
                                            </select>
                                            <input type="text" class="form-control mt-2" id="subgroup-input" name="subgroupInput" placeholder="Enter Custom Subgroup Name" style="display: none;">
                                        </div>

                                        <div class="form-group">
                                            <label for="ticket-dropdown">Ticket</label>
                                            <select class="form-control" name="ticketName" id="ticket-dropdown" required>
                                                <option value="">Select Existing Ticket</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="ticketDescription">Ticket Description</label>
                                            <textarea class="form-control" name="ticketDescription" id="ticketDescription" rows="4" placeholder="Enter ticket description..." required></textarea>
                                        </div>

                                        <div class="form-group">
                                            <label for="dueDate">Due Date</label>
                                            <input type="date" class="form-control" name="dueDate" id="dueDate" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="severity">Severity</label>
                                            <select class="form-control" name="severity" id="severity" required>
                                                <option value="Sev1">High</option>
                                                <option value="Sev2">Medium</option>
                                                <option value="Sev3">Low</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="employee-dropdown">Assigned to</label>
                                            <select class="form-control" name="assignedTo" id="employee-dropdown" required>
                                                <option value="">Select Employee</option>
                                            </select>
                                        </div>

                                        <div class="form-group text-right">
                                            <button type="submit" class="btn btn-primary" id="submitForm">Assign Task</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <!-- main container end -->

            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>

    <script src="./assets/js/app.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
$(document).ready(function() {
    // Fetch groups, subgroups, and tickets
    $.ajax({
        url: 'listTicketGroups',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            var groupDropdown = $('#group-dropdown');
            var subgroupDropdown = $('#subgroup-dropdown');
            var ticketDropdown = $('#ticket-dropdown');

            // Populate group dropdown
            groupDropdown.empty();
            groupDropdown.append($('<option></option>').attr('value', '').text('Select Existing or Custom Group Name'));
            groupDropdown.append($('<option></option>').attr('value', 'Custom').text('Custom'));
            $.each(data, function(index, group) {
                groupDropdown.append($('<option></option>').attr('value', group.groupName).text(group.groupName));
            });

            // Handle group selection
            groupDropdown.change(function() {
                var selectedGroup = $(this).val();
                subgroupDropdown.empty();
                subgroupDropdown.append($('<option></option>').attr('value', '').text('Select Existing or Custom Subgroup Name'));
                subgroupDropdown.append($('<option></option>').attr('value', 'Custom').text('Custom'));

                if (selectedGroup === 'Custom') {
                    $('#group-input').show();
                    subgroupDropdown.val('Custom');
                    $('#subgroup-input').show();
                } else {
                    $('#group-input').hide();
                    $('#subgroup-input').hide();
                    $.each(data, function(index, group) {
                        if (group.groupName === selectedGroup) {
                            $.each(group.subgroups, function(index, subgroup) {
                                subgroupDropdown.append($('<option></option>').attr('value', subgroup.subgroupName).text(subgroup.subgroupName));
                            });
                        }
                    });
                }
            });

            // Handle subgroup selection
            subgroupDropdown.change(function() {
                var selectedSubgroup = $(this).val();
                ticketDropdown.empty();
                ticketDropdown.append($('<option></option>').attr('value', '').text('Select Existing Ticket'));

                if (selectedSubgroup === 'Custom') {
                    $('#subgroup-input').show();
                } else {
                    $('#subgroup-input').hide();
                    $.each(data, function(index, group) {
                        $.each(group.subgroups, function(index, subgroup) {
                            if (subgroup.subgroupName === selectedSubgroup) {
                                $.each(subgroup.tickets, function(index, ticket) {
                                    ticketDropdown.append($('<option></option>').attr('value', ticket.ticketName).text(ticket.ticketName));
                                });
                            }
                        });
                    });
                }
            });

            // Handle ticket selection
            ticketDropdown.change(function() {
                $('#ticketDescription').val('');
            });
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data: ' + error);
        }
    });

    $.ajax({
        url: 'fetchAdmins', // Update to your servlet mapping
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            var employeeDropdown = $('#employee-dropdown');
            employeeDropdown.empty();
            employeeDropdown.append($('<option></option>').attr('value', '').text('Select Admin'));
            $.each(data, function(index, admin) {
                employeeDropdown.append($('<option></option>').attr('value', admin.userId).text(admin.userId));
            });
        },
        error: function(xhr, status, error) {
            console.error('Error fetching admins: ' + error);
        }
    });

    // Submit form via Ajax
    $('#submitForm').click(function(event) {
        event.preventDefault();

        var formData;

        if ($('#group-dropdown').val() === 'Custom') {
            formData = {
                groupName: $('#group-input').val(),
                subgroupName: $('#subgroup-input').val(),
                ticketName: $('#ticket-dropdown').val(),
                ticketDescription: $('#ticketDescription').val(),
                dueDate: $('#dueDate').val(),
                severity: $('#severity').val(),
                assignedTo: $('#employee-dropdown').val()
            };
        } else if ($('#subgroup-dropdown').val() === 'Custom') {
            formData = {
                groupName: $('#group-dropdown').val(),
                subgroupName: $('#subgroup-input').val(),
                ticketName: $('#ticket-dropdown').val(),
                ticketDescription: $('#ticketDescription').val(),
                dueDate: $('#dueDate').val(),
                severity: $('#severity').val(),
                assignedTo: $('#employee-dropdown').val()
            };
        } else {
            formData = $('#taskFrm').serialize();
        }

        $.ajax({
            type: 'POST',
            url: 'CreateTaskServlet',
            data: formData,
            success: function(response) {
                alert('Task assigned successfully!');
                $('#taskFrm')[0].reset();
            },
            error: function(xhr, status, error) {
                if (xhr.status === 400) {
                    alert(xhr.responseText);
                } else {
                    alert('Error occurred while assigning task.');
                }
            }
        });
    });
});
</script>

</body>
</html>
