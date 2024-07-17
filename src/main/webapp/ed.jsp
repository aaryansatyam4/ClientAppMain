<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


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
    <link href="./assets/css/ed.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>  
</head>

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
    <style>
        /* Custom CSS for severity classes */
        .severity-high {
            background-color: #dc3545; /* Red background for high severity */
            color: white; /* White text color */
        }

        .severity-medium {
            background-color: #ffc107; /* Yellow background for medium severity */
            color: black; /* Black text color */
        }

        .severity-low {
            background-color: #17a2b8; /* Blue background for low severity */
            color: white; /* White text color */
        }
    </style>

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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>

    $(document).ready(function() {
        var allTasks = [];
        var currentPage = 1;
        var pageSize = 10;  // Number of tasks per page

        function getTaskDetails(pageNumber) {
            $.ajax({
                url: 'http://localhost:8080/v1/api/t/c',
                type: 'GET',
                data: {
                    page: pageNumber,
                    pageSize: pageSize
                },
                dataType: 'json',
                success: function(response) {
                    if (response.status === "success") {
                        allTasks = JSON.parse(response.tickets);
                        populateTaskTable(allTasks);
                        updateCounts(allTasks);
                        renderPagination(response.totalPages);
                    } else {
                        alert(response.message);
                    }
                },
                error: function() {
                    alert('Error retrieving task details');
                }
            });
        }

        function populateTaskTable(tasks) {
            $('#taskTable tbody').empty();

            // Filter out completed tasks
            let ongoingTasks = tasks.filter(task => task.status && task.status.toLowerCase() !== 'completed');

            if (ongoingTasks.length === 0) {
                $('#taskTable tbody').append('<tr><td colspan="7" class="text-center">No Ongoing Tasks</td></tr>');
            } else {
                $.each(ongoingTasks, function(index, task) {
                    var rowHtml = '<tr>';
                    rowHtml += '<td class="d-none d-xl-table-cell">' + task.ticketId + '</td>';
                    rowHtml += '<td>' + task.title + '</td>';
                    rowHtml += '<td><span class="badge ' + getSeverityClass(task.severity.toLowerCase()) + '">' + task.severity + '</span></td>';
                    rowHtml += '<td class="d-none d-md-table-cell">' + task.createdBy + '</td>';
                    rowHtml += '<td class="d-none d-md-table-cell">' + task.createdAt + '</td>';
                    rowHtml += '<td class="d-none d-md-table-cell">' + task.dueDate + '</td>';
                    rowHtml += '<td><button class="btn btn-primary" onclick="openModal(' + task.ticketId + ')">Action</button></td>';
                    rowHtml += '</tr>';
                    $('#taskTable tbody').append(rowHtml);
                });
            }
        }

        function renderPagination(totalPages) {
            $('#pagination').empty();
            var paginationHtml = '';

            // Previous page button
            paginationHtml += '<li class="page-item ' + (currentPage === 1 ? 'disabled' : '') + '">';
            paginationHtml += '<a class="page-link" href="#" onclick="navigateToPage(' + (currentPage - 1) + ')">Previous</a>';
            paginationHtml += '</li>';

            // Page numbers
            for (let i = 1; i <= totalPages; i++) {
                paginationHtml += '<li class="page-item ' + (currentPage === i ? 'active' : '') + '">';
                paginationHtml += '<a class="page-link" href="#" onclick="navigateToPage(' + i + ')">' + i + '</a>';
                paginationHtml += '</li>';
            }

            // Next page button
            paginationHtml += '<li class="page-item ' + (currentPage === totalPages ? 'disabled' : '') + '">';
            paginationHtml += '<a class="page-link" href="#" onclick="navigateToPage(' + (currentPage + 1) + ')">Next</a>';
            paginationHtml += '</li>';

            $('#pagination').append(paginationHtml);
        }

        window.navigateToPage = function(pageNumber) {
            currentPage = pageNumber;
            getTaskDetails(pageNumber);
        };

        function updateCounts(tasks) {
            var pendingCount = 0;
            var completedCount = 0;
            var highSeverityCount = 0;
            var mediumSeverityCount = 0;
            var lowSeverityCount = 0;

            var monthlyCompletedCount = Array(12).fill(0);

            // Check if tasks array is empty
            if (tasks.length === 0) {
                $('#pending-count').text(0);
                $('#completed-count').text(0);
                $('#total-count').text(0);
                $('#high-severity-count').text(0);
                $('#medium-severity-count').text(0);
                $('#low-severity-count').text(0);

                renderMonthlyCompletedChart(monthlyCompletedCount);
                renderSeverityChart(highSeverityCount, mediumSeverityCount, lowSeverityCount);

                return;
            }

            $.each(tasks, function(index, task) {
                if (task.status === 'pending') {
                    pendingCount++;
                } else if (task.status.toLowerCase() === 'completed') {
                    completedCount++;
                    var createdDate = new Date(task.createdAt);
                    var month = createdDate.getMonth();
                    monthlyCompletedCount[month]++;
                }

                if (task.severity.toLowerCase() === 'high' && task.status.toLowerCase() !== 'completed') {
                    highSeverityCount++;
                } else if (task.severity.toLowerCase() === 'medium' && task.status.toLowerCase() !== 'completed') {
                    mediumSeverityCount++;
                } else if (task.severity.toLowerCase() === 'low' && task.status.toLowerCase() !== 'completed') {
                    lowSeverityCount++;
                }
            });

            // Update the text content of each count element
            $('#pending-count').text(pendingCount);
            $('#completed-count').text(completedCount);
            $('#total-count').text(tasks.length);
            $('#high-severity-count').text(highSeverityCount);
            $('#medium-severity-count').text(mediumSeverityCount);
            $('#low-severity-count').text(lowSeverityCount);

            // Render charts with updated data
            renderMonthlyCompletedChart(monthlyCompletedCount);
            renderSeverityChart(highSeverityCount, mediumSeverityCount, lowSeverityCount);
        }


        function getSeverityClass(severity) {
            switch (severity) {
                case 'high':
                    return 'severity-high';
                case 'medium':
                    return 'severity-medium';
                case 'low':
                    return 'severity-low';
                default:
                    return '';
            }
        }

        function renderMonthlyCompletedChart(monthlyData) {
            var ctx = document.getElementById('monthlyCompletedChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Completed Tickets',
                        data: monthlyData,
                        backgroundColor: 'rgba(95, 158, 160)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        function renderSeverityChart(high, medium, low) {
            var ctx = document.getElementById('severityChart').getContext('2d');
            new Chart(ctx, {
                type: 'polarArea',
                data: {
                    labels: ['High', 'Medium', 'Low'],
                    datasets: [{
                        label: 'Severity',
                        data: [high, medium, low],
                        backgroundColor: [
                            'rgba(199, 0, 57)', 
                            'rgba(225, 193, 110)', 
                            'rgba(115, 147, 179)'
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
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                    }
                }
            });
        }

        

        getTaskDetails();
    });



       </script>
<div class="preloader" id="preloader"></div>
    <div class="wrapper">
        <jsp:include page="sidebar.jsp"></jsp:include>      
        
        <div class="main">
            <jsp:include page="nav.jsp"></jsp:include>
            <main class="content">
            
                <div class="container-fluid p-0">
    <!-- Top Boxes -->                  
    <div class="row">
        <div class="col-md-3 col-sm-6 mb-3">
            <div class="card" onclick="openCompletedTasksPopup()">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <h3 id="completed-count" class="mb-2"></h3>
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
            <a href="#ongoing">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-grow-1">
                                <h3 id="pending-count" class="mb-2"></h3>
                                <p class="mb-0">Pending Tasks</p>
                            </div>
                            <div class="flex-shrink-0">
                                <i class="fa fa-hourglass-half text-warning fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-3 col-sm-6 mb-3">
            <a href="task.jsp">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-grow-1">
                                <h3 id="total-count" class="mb-2"></h3>
                                <p class="mb-0">Total Tasks</p>
                            </div>
                            <div class="flex-shrink-0">
                                <i class="fa fa-tasks text-info fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </div>                      
        <div class="col-md-3 col-sm-6 mb-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <h3 id="transferred-count" class="mb-2"></h3>
                            <p class="mb-0">Ticket Transferred</p>
                        </div>
                        <div class="flex-shrink-0">
                            <i class="fa fa-exchange text-success fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>                       
    </div>
    <div class="row">
        <div class="col-md-3 col-sm-6 mb-3">
            <div class="card" onclick="openHighSeverityTasksPopup()">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <h3 id="high-severity-count" class="mb-2"></h3>
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
            <div class="card" onclick="openMediumSeverityTasksPopup()">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <h3 id="medium-severity-count" class="mb-2"></h3>
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
            <div class="card" onclick="openLowSeverityTasksPopup()">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <h3 id="low-severity-count" class="mb-2"></h3>
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
</div>
                
                    <!-- Logs Created by the User -->                                           
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
                <h6 class="card-title">Pending Tickets</h6>
                <canvas id="severityChart"></canvas>
            </div>
        </div>
    </div>
</div>
              
              
             
                <%-- Pending Tickets Table --%>
 <div class="container-fluid mt-4">
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title"> TASKS ASSIGNED TO ME</h5>
                </div>
                <div class="card-body" id="ongoing">
                    <div class="table-responsive">
                        <table id="taskTable" class="table table-hover">
                            <thead>
                                <tr>
                                    <th class="d-none d-xl-table-cell">Task Id</th>
                                    <th>Task Name</th>
                                    <th>Severity</th>
                                    <th class="d-none d-md-table-cell">Assigned By</th>
                                    <th class="d-none d-md-table-cell">Assigned Date</th>
                                    <th class="d-none d-md-table-cell">Due Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="7" class="text-center">Loading...</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <nav aria-label="Page navigation">
                        
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
 

              
            </main>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
                 
<!-- The Modal -->
<div id="ticketModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <form method="post" action="ticketAction">
      <input type="hidden" name="ticketId" id="ticketId">
      <div class="form-group mb-3">
        <label for="action" class="form-label">Action</label>
        <select name="action" id="action" class="form-select" onchange="handleActionChange()">
          <option value="completed">Mark as Completed</option>
        </select>
      </div>
      
      <div class="form-group mb-3">
        <label for="remarks" class="form-label">Remarks</label>
        <textarea name="remarks" id="remarks" class="form-control"></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>
  </div>
</div>
 <!-- Completed Tasks Modal -->
<div id="completedTasksModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeCompletedTasksPopup()">&times;</span>
        <h2>Last 10 Completed Tasks</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th> 
                    <th>Task Name</th>
                    <th>Severity</th>
                    <th>Completed At</th>
                    <th>Due Date</th>
                    <th>Remarks</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="5" class="text-center">No ongoing tasks</td>
                </tr>
            </tbody>
        </table>
        <div class="modal-footer">
            For further details, go to <a href="task.jsp">tasks</a>
        </div>
    </div>
</div>

<!-- High Severity Tasks Modal -->
<div id="highSeverityTasksModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeSeverityTasksPopup('high')">&times;</span>
        <h2>High Severity Tasks</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th> 
                    <th>Task Name</th>
                    <th>Assigned at </th>
                    <th>Due Date</th>
                    <th>Manager</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="5" class="text-center">
            </tbody>
        </table>
        <div class="modal-footer">
            For further details, go to <a href="task.jsp">tasks</a>
        </div>
    </div>
</div>

<!-- Medium Severity Tasks Modal -->
<div id="mediumSeverityTasksModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeSeverityTasksPopup('medium')">&times;</span>
        <h2>Medium Severity Tasks</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th> 
                    <th>Task Name</th>
                    <th>Assigned at </th>
                    <th>Due Date</th>
                    <th>Manager</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="5" class="text-center">No ongoing tasks</td>
                </tr>
            </tbody>
        </table>
        <div class="modal-footer">
            For further details, go to <a href="task.jsp">tasks</a>
        </div>
    </div>
</div>

<!-- Low Severity Tasks Modal -->
<div id="lowSeverityTasksModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeSeverityTasksPopup('low')">&times;</span>
        <h2>Low Severity Tasks</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th> 
                    <th>Task Name</th>
                    <th>Assigned at </th>
                    <th>Due Date</th>
                    <th>Manager</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="5" class="text-center">No ongoing tasks</td>
                </tr>
            </tbody>
        </table>
        <div class="modal-footer">
            For further details, go to <a href="task.jsp">tasks</a>
        </div>
    </div>
</div>
 <script>
 $(document).ready(function() {
	    getTaskDetails();
	});

	function getTaskDetails() {
	    $.ajax({
	        url: 'http://localhost:8080/v1/api/t/c',
	        type: 'GET',
	        dataType: 'json',
	        success: function(response) {
	            if (response.status === "success") {
	                var allTasks = JSON.parse(response.tickets);
	                populateCompletedTasks(allTasks);
	                populateSeverityTasks(allTasks, 'high');
	                populateSeverityTasks(allTasks, 'medium');
	                populateSeverityTasks(allTasks, 'low');
	                updateCounts(allTasks);
	            } else {
	                alert(response.message);
	            }
	        },
	        error: function() {
	            alert('Error retrieving task details');
	        }
	    });
	}

	function populateCompletedTasks(tasks) {
	    var tbody = $('#completedTasksModal tbody');
	    tbody.empty();

	    var completedTasks = tasks.filter(function(task) {
	        return task.status.toLowerCase() === 'completed';
	    }).slice(0, 10);

	    if (completedTasks.length === 0) {
	        tbody.append('<tr><td colspan="5" class="text-center">No completed tasks found</td></tr>');
	    } else {
	        $.each(completedTasks, function(index, task) {
	            var row = '<tr>' +
	                '<td>' + task.ticketId + '</td>' +
	                '<td>' + task.title + '</td>' +
	                '<td>' + task.severity + '</td>' +
	                '<td>' + task.DueDate + '</td>' +
	                '<td>' + task.CompletedAt + '</td>' +
	                '<td>' + task.Remark + '</td>' +
	                '</tr>';
	            tbody.append(row);
	        });
	    }
	}

	function populateSeverityTasks(tasks, severity) {
	    var tbody = $('#' + severity + 'SeverityTasksModal tbody');
	    tbody.empty();

	    var severityTasks = tasks.filter(function(task) {
	        return task.severity.toLowerCase() === severity && task.status.toLowerCase() !== 'completed';
	    });

	    if (severityTasks.length === 0) {
	        tbody.append('<tr><td colspan="5" class="text-center">No ' + severity + ' severity tasks found</td></tr>');
	    } else {
	        $.each(severityTasks, function(index, task) {
	            var row = '<tr>' +
	                '<td>' + task.ticketId + '</td>' +
	                '<td>' + task.title + '</td>' +
	                '<td>' + task.createdAt + '</td>' +
	                '<td>' + task.DueDate + '</td>' +
	                '<td>' + task.Manager + '</td>' +
	                '</tr>';
	            tbody.append(row);
	        });
	    }
	}

	function closeCompletedTasksPopup() {
	    $('#completedTasksModal').hide();
	}

	function closeSeverityTasksPopup(severity) {
	    $('#' + severity + 'SeverityTasksModal').hide();
	}

	function openModal(modalId) {
	    $('#' + modalId).show();
	}

	function updateCounts(tasks) {
	    var pendingCount = 0;
	    var completedCount = 0;
	    var highSeverityCount = 0;
	    var mediumSeverityCount = 0;
	    var lowSeverityCount = 0;

	    var monthlyCompletedCount = Array(12).fill(0);

	    $.each(tasks, function(index, task) {
	        if (task.status.toLowerCase() === 'pending') {
	            pendingCount++;
	        } else if (task.status.toLowerCase() === 'completed') {
	            completedCount++;
	            var createdDate = new Date(task.created_at);
	            var month = createdDate.getMonth();
	            monthlyCompletedCount[month]++;
	        }

	        if (task.severity.toLowerCase() === 'high' && task.status.toLowerCase() !== 'completed') {
	            highSeverityCount++;
	        } else if (task.severity.toLowerCase() === 'medium' && task.status.toLowerCase() !== 'completed') {
	            mediumSeverityCount++;
	        } else if (task.severity.toLowerCase() === 'low' && task.status.toLowerCase() !== 'completed') {
	            lowSeverityCount++;
	        }
	    });

	    $('#pending-count').text(pendingCount);
	    $('#completed-count').text(completedCount);
	    $('#total-count').text(tasks.length);
	    $('#high-severity-count').text(highSeverityCount);
	    $('#medium-severity-count').text(mediumSeverityCount);
	    $('#low-severity-count').text(lowSeverityCount);

	    renderMonthlyCompletedChart(monthlyCompletedCount);
	    renderSeverityChart(highSeverityCount, mediumSeverityCount, lowSeverityCount);
	}

 </script>

<script>

function closeSeverityTasksPopup(severity) {
    var modal = document.getElementById(severity + "SeverityTasksModal");
    modal.style.display = "none";
}

// Function to open the Medium Severity Tasks popup
function openMediumSeverityTasksPopup() {
    var modal = document.getElementById("mediumSeverityTasksModal");
    modal.style.display = "block";
}
</script>

<script src="./assets/js/ed.js"></script>
    <script src="./assets/js/app.js"></script>
</body>
</html>