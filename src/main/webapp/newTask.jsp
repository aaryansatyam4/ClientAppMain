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

    <title>Add New Task</title>

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
                                            <label for="group-dropdown">Task Group</label>
                                            <select class="form-control" name="groupName" id="group-dropdown" required>
                                                <option value="">Select Existing or Custom Group Name</option>
                                                <option value="Custom">Custom</option>
                                            </select>
                                            <input type="text" class="form-control mt-2" id="group-input" name="groupInput" placeholder="Enter Custom Group Name" style="display: none;">
                                        </div>

                                        <div class="form-group">
                                            <label for="subgroup-dropdown">Task Subgroup</label>
                                            <select class="form-control" name="subgroupName" id="subgroup-dropdown" required>
                                                <option value="">Select Existing or Custom Subgroup Name</option>
                                            </select>
                                            <input type="text" class="form-control mt-2" id="subgroup-input" name="subgroupInput" placeholder="Enter Custom Subgroup Name" style="display: none;">
                                        </div>
                                        <div class="form-group">
                                            <label for="task-dropdown">Task</label>
                                            <select class="form-control" name="taskName" id="task-dropdown" required>
                                                <option value="">Select Existing or Custom Task Name</option>
                                            </select>
                                            <input type="text" class="form-control mt-2" id="task-input" name="taskInput" placeholder="Enter Custom Task Name" style="display: none;">
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
    
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const groupDropdown = document.getElementById('group-dropdown');
        const subgroupDropdown = document.getElementById('subgroup-dropdown');

       
        fetch('http://localhost:8080/v1/api/TaskGroup/allGroup')
            .then(response => response.json())
            .then(data => {
                const groups = JSON.parse(data.tickets);
                groups.forEach(group => {
                    const option = document.createElement('option');
                    option.value = group.ticketId; 
                    option.textContent = group.title;
                    groupDropdown.appendChild(option);
                });
            })
            .catch(error => {
                console.error('Error fetching task groups:', error);
                alert('Error fetching task groups, check console for details.');
            });

     
        groupDropdown.addEventListener('change', function() {
            const parentGroupId = this.value;

            
            subgroupDropdown.innerHTML = '<option value="">Select Existing or Custom Subgroup Name</option>';

            if (parentGroupId) {
                fetch('http://localhost:8080/v1/api/sub/subgroup', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        id: parentGroupId
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        data.subgroups.forEach(subgroup => {
                            const option = document.createElement('option');
                            option.value = subgroup.id;
                            option.textContent = subgroup.subgroupName;
                            subgroupDropdown.appendChild(option);
                        });
                    } else {
                        console.error('Error fetching subgroups:', data.message);
                        alert('Error fetching subgroups: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error fetching subgroups:', error);
                    alert('Error fetching subgroups, check console for details.');
                });
            }
        });
        
        

        
    });

</script>

<script>
const groupDropdown = document.getElementById('group-dropdown');
const subgroupDropdown = document.getElementById('subgroup-dropdown');

groupDropdown.addEventListener('change', function() {
    const parentGroupId = this.value;

    subgroupDropdown.innerHTML = '<option value="">Select Subgroup</option>';

    if (parentGroupId) {
        fetch('http://localhost:8080/v1/Task/bysubgroup', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({
                id: parentGroupId
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                data.subgroups.forEach(subgroup => {
                    const option = document.createElement('option');
                    option.value = subgroup.id;
                    option.textContent = subgroup.taskName;
                    subgroupDropdown.appendChild(option);
                });
            } else {
                console.error('Error fetching subgroups:', data.message);
   \             alert('Error fetching subgroups: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error fetching subgroups:', error);
            alert('Error fetching subgroups, check console for details.');
        });
    }
});
</script>


<script>
   
   
</script>





    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>
