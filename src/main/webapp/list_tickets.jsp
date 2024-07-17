<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>List Ticket Groups</title>
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
	body {
        font-family: 'Inter', Arial, sans-serif; /* Use Inter font for better readability */
        background-color: #f0f0f0; /* Example background color */
        margin: 0;
        padding: 0;
    }

    .card-equal-height {
        height: 100%;
    }
        
    .table tbody tr:hover {
        cursor: pointer;
        background-color: #f8f8f8 ; /* Light gray background on hover */
    }

    .table {
        border: 1.5px solid #ddd; /* Add a border around the table */
        border-collapse: collapse; /* Collapse borders for a cleaner look */
        width: 100%; /* Ensure table spans full width */
        margin-bottom: 20px; /* Add spacing below the table */
    }

    .table th, .table td {
        border: 1.5px solid #ddd; /* Add border to table cells */
        padding: 10px; /* Add padding inside cells */
        text-align: left; /* Center-align text in cells */
        font-size: 1.1em;
        background-color: #FFFFFF;
    }
    .table tbody tr:hover td {
    	background-color: #f8f8f8; /* Light gray background on hover */
	}

    .table thead th {
        background-color: #f2f2f2; /* Light gray background for header */
    }

    .table tbody tr:nth-child(even) {
        background-color: #f9f9f9; /* Alternate row background color */
    }

    .page-heading {
        text-align: center;
        margin-top: 5px; /* Adjust spacing from the top */
        font-size: 1.5em; /* Adjust font size */
        color: #333; /* Text color */
        text-transform: uppercase; /* Uppercase text */
        letter-spacing: 2px; /* Adjust letter spacing */
        font-weight: bold; /* Bold font weight */
    }

    .card {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        text-align: center;
        margin: auto;
        width: 100%;
    }

    .pagination {
        margin-top: 20px; /* Adjust margin as needed */
        text-align: center; /* Center align pagination */
    }

    .pagination ul {
        display: inline-block;
        padding-left: 0;
        margin: 0;
        border-radius: 0.25rem;
    }

    .pagination li {
        display: inline;
    }

    .pagination li a,
    .pagination li span {
        position: relative;
        float: left;
        padding: 0.5rem 0.75rem;
        margin-left: -1px;
        line-height: 1.25;
        color: #007bff;
        text-decoration: none;
        background-color: #fff;
        border: 1px solid #dee2e6;
    }

    .pagination .page-link {
        position: relative;
        display: block;
        padding: 0.5rem 0.75rem;
        margin-left: -1px;
        line-height: 1.25;
        color: #007bff;
        background-color: #fff;
        border: 1px solid #dee2e6;
    }

    .pagination .page-item.active .page-link {
        z-index: 1;
        color: #fff;
        background-color: #007bff;
        border-color: #007bff;
    }

    .pagination .page-item.disabled .page-link {
        color: #6c757d;
        pointer-events: none;
        cursor: auto;
        background-color: #fff;
        border-color: #dee2e6;
    }

    .col-serial-number {
        width: 10%; /* Width for the serial number column */
    }

    .col-group-name {
        width: 40%; /* Adjust the width as needed */
    }

    .col-subgroups-count {
        width: 25%; /* Adjust the width as needed */
        
    }

    .col-total-tickets {
        width: 25%; /* Adjust the width as needed */
      
    }

    .table .empty-cell {
        width: 10%; /* Ensure empty cells have the same width as serial number column */
    }

    .table .subgroup-row td {
        padding-left: 140px; /* Indent subgroup rows */
    }

    .table .ticket-row td {
        padding-left: 180px; /* Indent ticket rows further */
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
        background-size: 300px;
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
                    <!-- Page Header -->
                    <div class="row mb-3">
                        <div class="col-12">
                            <div class="card">
                                <h4 class="page-heading">Default Ticket Categories</h4>
                            </div>
                        </div>
                    </div>
                    <div class="pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item" id="firstPage"><a class="page-link" href="#">First</a></li>
                            <li class="page-item" id="prevPage"><a class="page-link" href="#">Previous</a></li>
                            <li class="page-item" id="nextPage"><a class="page-link" href="#">Next</a></li>
                            <li class="page-item" id="lastPage"><a class="page-link" href="#">Last</a></li>
                        </ul>
                    </div>
                    <!-- Ticket Sections -->
                    <div class="table-responsive">
                        <table class="table table-bordered" id="ticketsTable">
                            <colgroup>
                                <col class="col-serial-number">
                                <col class="col-group-name">
                                <col class="col-subgroups-count">
                                <col class="col-total-tickets">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>S. No.</th>
                                    <th>Group Name</th>
                                    <th>Number of Subgroups</th>
                                    <th>Total Number of Tickets</th>
                                </tr>
                            </thead>
                            <tbody id="ticketsBody">
                                <!-- Content will be dynamically loaded here -->
                            </tbody>
                        </table>
                    </div>
                </div> 
            </main>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="./assets/js/app.js"></script>
    <script>
    $(document).ready(function() {
        var data = []; // Store fetched data
        var currentPage = 1;
        var itemsPerPage = 10;

        function fetchData() {
            $.ajax({
                url: 'listTicketGroups', // Replace with your servlet URL
                method: 'GET',
                dataType: 'json',
                success: function(response) {
                    data = response;
                    renderPage(currentPage);
                    updatePaginationControls();
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching data:', error);
                }
            });
        }

        function renderPage(page) {
            var startIndex = (page - 1) * itemsPerPage;
            var endIndex = startIndex + itemsPerPage;
            var pageData = data.slice(startIndex, endIndex);

            renderTickets(pageData, startIndex);
        }

        function updatePaginationControls() {
            var totalPages = Math.ceil(data.length / itemsPerPage);

            $('#firstPage').toggleClass('disabled', currentPage === 1);
            $('#prevPage').toggleClass('disabled', currentPage === 1);
            $('#nextPage').toggleClass('disabled', currentPage === totalPages);
            $('#lastPage').toggleClass('disabled', currentPage === totalPages);
        }

        function renderTickets(pageData, startIndex) {
            var html = '';
            $.each(pageData, function(index, group) {
                var totalTickets = 0;
                $.each(group.subgroups, function(idx, subgroup) {
                    totalTickets += subgroup.tickets.length;
                });

                var serialNumber = startIndex + index + 1;

                html += '<tr class="collapse-row" data-toggle="collapse" data-target="#group' + group.id + '">';
                html += '<td>' + serialNumber + '</td>';
                html += '<td><i class="fa fa-tag text-primary"></i> ' + group.groupName + '</td>';
                html += '<td class="col-subgroups-count">' + group.subgroups.length + '</td>';
                html += '<td class="col-total-tickets">' + totalTickets + '</td>';
                html += '</tr>';
                html += '<tr>';
                html += '<td class="p-0 empty-cell" colspan="4">'; // Add the empty-cell class here
                html += '<div id="group' + group.id + '" class="collapse">';
                html += '<table class="table mb-0">'; // Add margin-left to indent the subgroup

                $.each(group.subgroups, function(idx, subgroup) {
                    html += '<tr class="collapse-row subgroup-row" data-toggle="collapse" data-target="#subgroup' + subgroup.id + '">';
                    
                    html += '<td><i class="fa fa-tags text-warning"></i> ' + subgroup.subgroupName + '</td>';
                   
                    html += '<td class="col-total-tickets">' + subgroup.tickets.length + '</td>';
                    html += '</tr>';
                    html += '<tr>';
                    html += '<td class="p-0 empty-cell" colspan="4">'; // Add the empty-cell class here
                    html += '<div id="subgroup' + subgroup.id + '" class="collapse">';
                    html += '<table class="table mb-0">'; // Add more margin-left to indent the tickets

                    $.each(subgroup.tickets, function(i, ticket) {
                        html += '<tr class="ticket-row">';
                        html += '<td colspan="4"><i class="fa fa-ticket text-success"></i> ' + ticket.ticketName + '</td>';
                        html += '</tr>';
                    });

                    html += '</table>';
                    html += '</div>';
                    html += '</td>';
                    html += '</tr>';
                });

                html += '</table>';
                html += '</div>';
                html += '</td>';
                html += '</tr>';
            });

            $('#ticketsBody').html(html);
        }

        $('#firstPage').click(function() {
            if (currentPage > 1) {
                currentPage = 1;
                renderPage(currentPage);
                updatePaginationControls();
            }
        });

        $('#prevPage').click(function() {
            if (currentPage > 1) {
                currentPage--;
                renderPage(currentPage);
                updatePaginationControls();
            }
        });

        $('#nextPage').click(function() {
            var totalPages = Math.ceil(data.length / itemsPerPage);
            if (currentPage < totalPages) {
                currentPage++;
                renderPage(currentPage);
                updatePaginationControls();
            }
        });

        $('#lastPage').click(function() {
            var totalPages = Math.ceil(data.length / itemsPerPage);
            if (currentPage < totalPages) {
                currentPage = totalPages;
                renderPage(currentPage);
                updatePaginationControls();
            }
        });

        // Initial fetch and render
        fetchData();
    });
    </script>
</body>
</html>
