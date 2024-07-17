
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
                    <!-- Top Boxes -->                  
                    <div class="row">
                    
                     <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card" onclick="openCompletedTasksPopup()">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2"></h3>
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
                                            <h3 class="mb-2"></h3>
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
                                            <h3 class="mb-2"></h3>
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
                                            <h3 class="mb-2"></h3>
                                            <p class="mb-0">Ticket Transfered</p>
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
                                            <h3 class="mb-2"></h3>
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
                                            <h3 class="mb-2"></h3>
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
                                            <h3 class="mb-2"></h3>
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
                 <div class="col-xl-12 col-xxl-12">
							 
							<div class="card flex-fill w-100">
								<div class="card-header">
									<h5 class="card-title">Task Chart</h5>
								</div>
								<div class="card-body">
									<div class="chart">
										<canvas id="chartjs-line"></canvas>
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
<div class="container mt-4">
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">ONGOING TASKS</h5>
                </div>
                <div class="card-body">
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
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
                                        <td class="d-none d-xl-table-cell"></td>
                                        <td></td>
                                        <td><span class="badge"></span></td>
                                        <td class="d-none d-md-table-cell"></td>
                                        <td class="d-none d-md-table-cell"></td>
                                        <td class="d-none d-md-table-cell"></td>
                                        <td><button class="btn btn-primary" onclick="openModal('')">Action</button></td>
                                    </tr>
                           
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
                </tr>
            </thead>
            <tbody>
               
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
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
                        <td></td>
                        <td></td>
                         <td></td>
                        <td></td>
                         <td></td>
                    </tr>
             
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
                       <td></td>
                        <td></td>
                         <td></td>
                        <td></td>
                         <td></td>
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
                        <td></td>
                        <td></td>
                         <td></td>
                        <td></td>
                         <td></td>
                    </tr>
           
            </tbody>
        </table>
         <div class="modal-footer">
            For further details, go to <a href="task.jsp">tasks</a>
        </div>
    </div>
</div>
<script>
var pendingTasksData = [];
var hasPendingTasks = pendingTasksData.reduce((a, b) => a + b, 0) > 0; // Check if there are any pending tasks

var ctx = document.getElementById('severityChart').getContext('2d');
var severityChart = new Chart(ctx, {
    type: 'polarArea',
    data: {
        labels: hasPendingTasks ? ['High Severity', 'Medium Severity', 'Low Severity'] : ['No Pending Tasks'],
        datasets: [{
            label: 'Severity Counts',
            data: hasPendingTasks ? pendingTasksData : [1], // Show 1 to avoid empty chart issue
            backgroundColor: hasPendingTasks ? [
                'rgba(199, 0, 57)', // Red for High Severity
                'rgba(225, 193, 110)', // Yellow for Medium Severity
                'rgba(115, 147, 179)' // Blue for Low Severity
            ] : ['rgba(211, 211, 211, 0.6)'], // Grey for no pending tasks
            borderColor: hasPendingTasks ? [
                'rgba(255, 99, 132, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(54, 162, 235, 1)'
            ] : ['rgba(211, 211, 211, 1)'], // Grey for no pending tasks
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: true,
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

// Add event listeners for hover and click
ctx.canvas.addEventListener('mouseenter', function() {
    document.getElementById('element').classList.add('hovered');
});

ctx.canvas.addEventListener('mouseleave', function() {
    document.getElementById('element').classList.remove('hovered');
});

ctx.canvas.addEventListener('click', function() {
    document.getElementById('element').classList.toggle('clicked');
});

document.addEventListener('DOMContentLoaded', function () {
    var ctxBar = document.getElementById('monthlyCompletedChart').getContext('2d');
    var monthlyCompletedChart = new Chart(ctxBar, {
        type: 'bar',
        data: {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
            datasets: [{
                label: 'Completed Tickets',
                data: ,
                backgroundColor: 'rgba(95, 158, 160)', 
                borderColor: 'rgba(75, 192, 192, 1)', 
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
                }xw
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

<script src="./assets/js/ed.js"></script>
    <script src="./assets/js/app.js"></script>
</body>
</html>