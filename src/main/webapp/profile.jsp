<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description"
	content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
<meta name="author" content="AdminKit">
<meta name="keywords"
	content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="shortcut icon" href="./assets/img/icons/icon-48x48.png" />
<link rel="canonical" href="https://demo-basic.adminkit.io/" />
<title>Profile</title>
<link href="./assets/css/app.css" rel="stylesheet">
<link href="./assets/css/profile1.css" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css"
	rel="stylesheet">
<link
	href="https://cdn.datatables.net/buttons/3.0.2/css/buttons.dataTables.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
 <script>
        $(document).ready(function() {
            
        	fetchUserProfile();
            // Call fetchUserProfile function on document ready
            fetchUserProfile();
        });
        
        
        function fetchUserProfile() {
            $.ajax({
                url: 'http://localhost:8080/v1/api/e/d',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                	
                	debugger;
                	
                    console.log("Response from server:", response);
                    
                    $("#value").text(response.data.userId);
                    $("#employeeName").text(response.data.firstName + " " + response.data.lastName);
                    $("#position").text(response.data.position);
                    $("#email").text(response.data.email);
                    $("#mobile").text(response.data.contact_no);
                    $("#address").text(response.data.address);
                    $("#department").text(response.data.department);
                    $("#joiningDate").text(response.data.joining_date);
                    $("#password").text(response.data.password);
                    
                    $("#editFirstName").val(response.data.firstName);
                    $("#editLastName").val(response.data.lastName);
                    $("#editEmail").val(response.data.email);
                    $("#editContact_no").val(response.data.contact_no);
                    $("#editAddress").val(response.data.address);
                    $("#editCity").val(response.data.city);
                    $("#editState").val(response.data.state);
                   
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching profile data:", status, error);
                    // Update specific elements or provide feedback
                    $("#value").text("Error loading data");
                    $("#employeeName").text("");
                    // Handle other fields similarly
                }
            });
        }
    </script>
<script>
	document
			.addEventListener(
					"DOMContentLoaded",
					function() {
						// Edit Modal
						var editModal = document.getElementById("editModal");
						var editIcon = document.getElementById("editIcon");
						var editClose = editModal.querySelector(".close");

						editIcon.onclick = function() {
							editModal.style.display = "block";
						}

						editClose.onclick = function() {
							editModal.style.display = "none";
						}

						// Password Modal
						var passwordModal = document
								.getElementById("passwordModal");
						var passwordBtn = document
								.getElementById("passwordbtn");
						var passwordClose = passwordModal
								.querySelector(".close");

						passwordBtn.onclick = function() {
							passwordModal.style.display = "block";
						}

						passwordClose.onclick = function() {
							passwordModal.style.display = "none";
						}

						// Close modals when clicking outside
						window.onclick = function(event) {
							if (event.target == editModal) {
								editModal.style.display = "none";
							}
							if (event.target == passwordModal) {
								passwordModal.style.display = "none";
							}
						}

						// Phone number validation
						var phoneNumberInput = document
								.getElementById("contact_no");
						phoneNumberInput
								.addEventListener(
										"input",
										function() {
											var phoneNumber = phoneNumberInput.value
													.trim();
											var isValid = /^\d{10}$/
													.test(phoneNumber); // Regex for 10 digits only

											if (!isValid) {
												phoneNumberInput.classList
														.add("is-invalid");
												document
														.getElementById("phoneError").textContent = "Enter a valid 10-digit phone number.";
											} else {
												phoneNumberInput.classList
														.remove("is-invalid");
												document
														.getElementById("phoneError").textContent = "";
											}
										});
					});
</script>


  
<Style>

/* Global reset and base styles */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Inter', sans-serif;
	font-size: 16px;
	line-height: 1.6;
	background-color: #f8f9fa;
	color: #343a40;
}

.wrapper {
	display: flex;
	width: 100%;
	height: 100vh;
}

/
.main {
	flex: 1;
	padding: 20px;
}

.main-body {
	padding: 20px;
}

.heading {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 20px;
}

.heading h1 {
	font-size: 24px;
	font-weight: bold;
}

.edit-icon-container {
	position: relative;
}

.edit-icon {
	font-size: 24px;
	color: #007bff;
	cursor: pointer;
}

/* Card styles */
.card {
	border: none;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.card-img-top {
	width: 150px;
	height: 150px;
	object-fit: cover;
	border-radius: 50%;
}

.card-title {
	margin-top: 10px;
	font-size: 24px;
	font-weight: bold;
}

.card-text {
	color: #777;
	margin-bottom: 20px;
}

.btn {
	margin-top: 10px;
}

/* Profile details styles */
.row {
	margin-bottom: 20px;
}

.row h6 {
	font-weight: bold;
}

.text-secondary {
	color: #777;
}

.hr {
	margin-top: 10px;
	margin-bottom: 10px;
	border: none;
	border-top: 1px solid #ddd;
}

/* Modal styles */
.modal {
	display: none; /* Hidden by default */
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%; /* Adjust width as needed */
	max-width: 600px; /* Maximum width */
	border-radius: 10px; /* Rounded corners */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	/* Optional: Add shadow for a better look */
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
}

/* Form styles */
.form-row {
	margin-bottom: 15px;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	font-weight: bold;
}

.form-control {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
}

.select-container {
	width: 100%;
	margin-bottom: 15px;
}

.select-container label {
	display: block;
	font-weight: bold;
}

.select-container select {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
}

/* Button styles */
.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
	color: #fff;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
}

.btn-primary:hover {
	background-color: #0069d9;
	border-color: #0062cc;
}

.btn-outline-primary {
	color: #007bff;
	border-color: #007bff;
	padding: 8px 20px;
	border-radius: 5px;
	cursor: pointer;
}

.btn-outline-primary:hover {
	background-color: #007bff;
	color: #fff;
}

/* Responsive adjustments */
@media ( max-width : 992px) {
	.sidebar {
		display: none;
	}
	.main {
		width: 100%;
	}
}

@media ( max-width : 768px) {
	.modal-content {
		width: 95%;
	}
}
</Style>
<Style>
/* Edit modal specific styles */
#editModal .modal-content {
	background-color: #fefefe;
	margin: 7% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%; /* Adjust width as needed */
	max-width: 600px; /* Maximum width */
	border-radius: 10px; /* Rounded corners */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	/* Optional: Add shadow for a better look */
}

#editModal .close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

#editModal .close:hover, #editModal .close:focus {
	color: #000;
	text-decoration: none;
}

#editModal .form-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
}

#editModal .form-row .form-group {
	width: 48%; /* Adjust width to fit both inputs on one line */
}

#editModal .form-group label {
	font-weight: bold;
}

#editModal .form-control {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
}

#editModal .select-container {
	width: 100%;
	margin-bottom: 15px;
}

#editModal .select-container label {
	display: block;
	font-weight: bold;
}

#editModal .select-container select {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
}

#editModal .btn-primary {
	background-color: #007bff;
	border-color: #007bff;
	color: #fff;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
}

#editModal .btn-primary:hover {
	background-color: #0069d9;
	border-color: #0062cc;
}

#editModal .btn-outline-primary {
	color: #007bff;
	border-color: #007bff;
	padding: 8px 20px;
	border-radius: 5px;
	cursor: pointer;
}

#editModal .btn-outline-primary:hover {
	background-color: #007bff;
	color: #fff;
}
</Style>


</head>


<body>
 <div class="wrapper">
        <jsp:include page="sidebar.jsp"></jsp:include>
        <div class="main">
            <jsp:include page="nav.jsp"></jsp:include>
            <div class="main-body">
                <div class="row gutters-sm">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="edit-icon-container">
                                <i class="fas fa-edit edit-icon" id="editIcon"></i>
                            </div>
                            <div class="d-flex flex-column align-items-center text-center">
                                <img id="profilePicture" src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Admin" class="rounded-circle" width="150">
                                <div class="mt-3">
                                    <h4><span id="userId"></span></h4>
                                    <button class="btn btn-info" id="passwordbtn">Change Password</button>
                                    <button class="btn btn-outline-primary">Message</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Employee Name</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><span id="employeeName"></span></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Position</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><span id="position"></span></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Email</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><span id="email"></span></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Mobile</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><span id="mobile"></span></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Address</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><span id="address"></span></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Department</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><span id="department"></span></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Joining Date</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><span id="joiningDate"></span></div>
                            </div>
                            <hr>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<div id="editModal" class="modal">
    <div class="modal-content">
      <span class="close">&times;</span>
        <h2>Edit Profile</h2>
        <form id="editProfileForm">
            <input type="hidden" id="userId" name="userId" value="">
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="editFirstName">First Name:</label>
                    <input type="text" class="form-control" id="editFirstName" name="firstName" value="">
                </div>
                <div class="form-group col-md-6">
                    <label for="editLastName">Last Name:</label>
                    <input type="text" class="form-control" id="editLastName" name="lastName" value="">
                </div>
            </div>
            <div class="form-group">
                <label for="editEmail">Email:</label>
                <input type="email" class="form-control" id="editEmail" name="email" value="" required>
            </div>
            <div class="form-group">
                <label for="editContact_no">Mobile:</label>
                <input type="text" class="form-control" id="editContact_no" name="contact_no" value="" required>
                <div class="invalid-feedback" id="editPhoneError"></div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="editAddress">Address:</label>
                    <input type="text" class="form-control" id="editAddress" name="address" value="">
                </div>
                <div class="form-group col-md-3">
                    <label for="editCity">City:</label>
                    <input type="text" class="form-control" id="editCity" name="city" value="">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="editState">State:</label>
                    <input type="text" class="form-control" id="editState" name="state">
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    var editModal = $("#editModal");
    var editClose = editModal.find(".close");
    var editIcon = $("#editIcon"); // Assuming editIcon is the element triggering modal open

    // Add event listener to close the edit modal
    editClose.click(function() {
        editModal.hide();
    });

    // Close edit modal when clicking outside
    $(window).click(function(event) {
        if (event.target === editModal[0]) {
            editModal.hide();
        }
    });

    // Function to open the edit modal with employee data
    function openEditModal(employeeData) {
        $('#userId').val(employeeData.userId);
        $('#editFirstName').val(employeeData.firstName);
        $('#editLastName').val(employeeData.lastName);
        $('#editEmail').val(employeeData.email);
        $('#editContact_no').val(employeeData.contact_no);
        $('#editAddress').val(employeeData.address);
        $('#editCity').val(employeeData.city);
        $('#editState').val(employeeData.state);
        editModal.show();
    }

    // Open edit modal when edit icon is clicked
    editIcon.click(function() {
        editModal.show();
    });

    // Form submission handling
    $('#editProfileForm').submit(function(event) {
        event.preventDefault();

        var formData = {
            userId: $('#userId').val(),
            firstName: $('#editFirstName').val(),
            lastName: $('#editLastName').val(),
            email: $('#editEmail').val(),
            contact_no: $('#editContact_no').val(),
            address: $('#editAddress').val(),
            city: $('#editCity').val(),
            state: $('#editState').val()
        };

        $.ajax({
            url: 'http://localhost:8080/v1/updateProfile',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                alert('Profile updated successfully!');
                editModal.hide(); // Close modal on successful update
            },
            error: function(xhr, status, error) {
                alert('Error updating profile: ' + xhr.responseText);
            }
        });
    });
});
</script>



<script>
<script>
$(document).ready(function() {


    // Password Modal
    var passwordModal = document.getElementById("passwordModal");
    var passwordBtn = document.getElementById("passwordbtn");
    var passwordClose = passwordModal.querySelector(".close");

    passwordBtn.onclick = function() {
        passwordModal.style.display = "block";
    }

    passwordClose.onclick = function() {
        passwordModal.style.display = "none";
    }

    // Close modals when clicking outside
    window.onclick = function(event) {
        if (event.target == editModal) {
            editModal.style.display = "none";
        }
        if (event.target == passwordModal) {
            passwordModal.style.display = "none";
        }
    }

    // Phone number validation
    var phoneNumberInput = document.getElementById("editContact_no");
    phoneNumberInput.addEventListener("input", function() {
        var phoneNumber = phoneNumberInput.value.trim();
        var isValid = /^\d{10}$/.test(phoneNumber); // Regex for 10 digits only

        if (!isValid) {
            phoneNumberInput.classList.add("is-invalid");
            document.getElementById("editPhoneError").textContent = "Enter a valid 10-digit phone number.";
        } else {
            phoneNumberInput.classList.remove("is-invalid");
            document.getElementById("editPhoneError").textContent = "";
        }
    });
});
</script>




					<div id="passwordModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Change Password</h2>
        <form action="changePassword" method="post" id="changePasswordForm">
            <input type="hidden" name="userId" id="passwordUserId" value="">

            <div class="form-group">
                <label for="currentPassword">Current Password:</label>
                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
            </div>
            <div class="form-group">
                <label for="newPassword">New Password:</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                <div id="newPasswordError" class="error-message"></div>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                <div id="confirmPasswordError" class="error-message"></div>
            </div>

            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // Get the modal element
    var modal = document.getElementById("passwordModal");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }
  
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    // Function to open the password modal and set userId
    function openPasswordModal() {
        var userId = getCookie("userId");
        $('#passwordUserId').val(userId);
        modal.style.display = "block";
    }

    // Utility function to get a cookie value by name
    function getCookie(name) {
        var value = "; " + document.cookie;
        var parts = value.split("; " + name + "=");
        if (parts.length == 2) return parts.pop().split(";").shift();
    }

    // Example usage
    // openPasswordModal(); // Call this function when you want to open the modal
});
</script>
					
			
			<script>
			
			
			<!-- Include jQuery library -->
			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

			<script>
			$(document).ready(function() {
			    // Open modal function
			    function openModal(user) {
			        $('#editModal').show();
			        $('#userId').val(user.userId);
			        $('#editFirstName').val(user.firstName);
			        $('#editLastName').val(user.lastName);
			        $('#editEmail').val(user.email);
			        $('#editContact_no').val(user.contact_no);
			        $('#editAddress').val(user.address);
			        $('#editCity').val(user.city);
			        $('#editState').val(user.state);
			    }

			</script>

				
			
	

			<script src="./assets/js/app.js"></script>
			
			<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
			 
                
</body>
</html>



