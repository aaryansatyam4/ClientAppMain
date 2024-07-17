<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Super Admin Dashboard</title>
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
        .generate-ticket-btn {
            background-color: #4CAF50; /* Green background */
            border: none; /* Remove borders */
            color: white; /* White text */
            padding: 15px 32px; /* Some padding */
            text-align: center; /* Center the text */
            text-decoration: none; /* Remove underline */
            display: inline-block; /* Get the block to flow with other elements */
            font-size: 16px; /* Increase font size */
            margin: 10px 2px; /* Some margin */
            cursor: pointer; /* Pointer/hand icon on hover */
            border-radius: 12px; /* Rounded corners */
        }

        .generate-ticket-btn:hover {
            background-color: #45a049; /* Darker green on hover */
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
                                            <h3 id="total" class="mb-2">Loading...</h3>
                                            <p class="mb-0">Total</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-tasks text-primary fa-2x"></i>

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
                                            <h3 id="highSeverityCount" class="mb-2">Loading...</h3>
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
                                            <h3 id="mediumSeverityCount" class="mb-2">Loading...</h3>
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
                                            <h3 id="lowSeverityCount" class="mb-2">Loading...</h3>
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
                                            <h3 id="completedCount" class="mb-2">Loading...</h3>
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
                                    <table id="pendingTicketsTable" class="table table-hover my-0">
                                        <thead>
                                            <tr>
                                                <th>Ticket Name</th>
                                                <th class="d-none d-xl-table-cell">Ticket Id</th>
                                                <th>Severity</th>
                                                <th class="d-none d-md-table-cell">Remarks</th>
                                                <th class="d-none d-md-table-cell">Assigned By</th>
                                                
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
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // Function to fetch data from servlet
            function fetchDataAndUpdateDashboard() {
                $.ajax({
                    url: "SuperAdminDashboardServlet",
                    type: "GET",
                    dataType: "json",
                    success: function(data) {
                        // Update dashboard elements with fetched data
                        $("#total").text(data.total);
                        $("#highSeverityCount").text(data.highSeverityCount);
                        $("#mediumSeverityCount").text(data.mediumSeverityCount);
                        $("#lowSeverityCount").text(data.lowSeverityCount);
                        $("#completedCount").text(data.completedCount);
                    },
                    error: function(xhr, status, error) {
                        console.error("Error fetching data from servlet:", error);
                    }
                });
            }

            // Call the function initially when the page loads
            fetchDataAndUpdateDashboard();
        });
    </script>
</body>
</html>
