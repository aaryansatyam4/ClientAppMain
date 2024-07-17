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
                                    <form id="groupFrm">
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
                                            <label for="tickets">Tickets</label>
                                            <textarea class="form-control" name="tickets" id="tickets" rows="4" placeholder="Enter tickets: one per line or separated by comma(,) or empty space... " required></textarea>
                                        </div>

                                        <div class="form-group text-right">
                                            <button type="submit" class="btn btn-primary" id="submitForm">Create</button>
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
        // Fetch existing groups for dropdown
        $.ajax({
            url: 'listTicketGroups',
            type: 'GET',
            dataType: 'json',
            success: function(groups) {
                var groupDropdown = $('#group-dropdown');
                groupDropdown.empty(); // Clear existing options
                groupDropdown.append($('<option></option>').attr('value', '').text('Select Existing or Custom Group Name'));
                groupDropdown.append($('<option></option>').attr('value', 'Custom').text('Custom')); // Add 'Custom' option
                $.each(groups, function(index, group) {
                    groupDropdown.append($('<option></option>').attr('value', group.groupName).text(group.groupName));
                });

                // Trigger change event after populating groups to fetch subgroups for the first group
                if (groups.length > 0) {
                    groupDropdown.trigger('change');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching groups: ' + error);
            }
        });

        // Handle subgroup dropdown based on selected group
        $('#group-dropdown').change(function() {
            var selectedGroupId = $(this).val();
            var subgroupDropdown = $('#subgroup-dropdown');
            var subgroupInput = $('#subgroup-input');

            subgroupDropdown.empty(); // Clear previous options
            subgroupInput.hide(); // Hide subgroup input field by default

            if (selectedGroupId === 'Custom') {
                // Show input field for custom group name
                $('#group-input').show();
                // Set subgroup dropdown to 'Custom' and show subgroup input field
                subgroupDropdown.append($('<option></option>').attr('value', 'Custom').text('Custom'));
                subgroupDropdown.val('Custom');
                subgroupInput.show();
            } else if (selectedGroupId) {
            	$('#group-input').hide();
                // Fetch subgroups for the selected group
                $.ajax({
                    url: 'listTicketGroups',
                    type: 'GET',
                    dataType: 'json',
                    success: function(groups) {
                        var selectedGroup = groups.find(group => group.groupName == selectedGroupId);
                        subgroupDropdown.append($('<option></option>').attr('value', '').text('Select Existing or Custom Subgroup Name'));
                        subgroupDropdown.append($('<option></option>').attr('value', 'Custom').text('Custom'));
                        if (selectedGroup) {
                            $.each(selectedGroup.subgroups, function(index, subgroup) {
                                subgroupDropdown.append($('<option></option>').attr('value', subgroup.subgroupName).text(subgroup.subgroupName));
                            });
                        }
                        
                    },
                    error: function(xhr, status, error) {
                        console.error('Error fetching subgroups: ' + error);
                    }
                });
            } else {
                subgroupDropdown.append($('<option></option>').attr('value', '').text('Select Existing or Custom Subgroup Name'));
            }
        });
        $('#subgroup-dropdown').change(function() {
        	var subgroupDropdown = $('#subgroup-dropdown');
        	if (subgroupDropdown.val() === 'Custom') {
        		var subgroupInput = $('#subgroup-input');
                subgroupInput.show();
        	}
        });

        // Submit form via Ajax
        $('#submitForm').click(function(event) {
            event.preventDefault();
			
            $('#group-input').hide();
            $('#subgroup-input').hide();
            
            var formData;

            if ($('#group-dropdown').val() === 'Custom') {
                // Use custom group name from input field
                formData = {
                    groupName: $('#group-input').val(),
                    subgroupName: $('#subgroup-input').val(),
                    tickets: $('#tickets').val()
                };
            } 
            else if ($('#subgroup-dropdown').val() === 'Custom') {
                // Use custom group name from input field
                formData = {
                    groupName: $('#group-dropdown').val(),
                    subgroupName: $('#subgroup-input').val(),
                    tickets: $('#tickets').val()
                };
            }
            
            else {
                // Serialize form data if not custom group
                formData = $('#groupFrm').serialize();
            }

            // Submit form via AJAX
            $.ajax({
                type: 'POST',
                url: 'CreateGroupServlet',
                data: formData,
                success: function(response) {
                    alert('Data submitted successfully!');
                    $('#groupFrm')[0].reset(); // Reset form
                },
                error: function(xhr, status, error) {
                	if (xhr.status === 400) {
                        alert(xhr.responseText); // Display the error message from the server
                    } else {
                        alert('Error occurred while submitting data.');
                    }
                }
            });
        });
    });


    </script>
</body>
</html>
