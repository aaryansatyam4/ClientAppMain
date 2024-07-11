



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.digicode.dao.LoginServiceImpl"%>
<%@ page import="com.digicode.model.EmployeeModel"%>
<%@ page import="javax.servlet.http.Cookie"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>


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

	<%
	// Initialize the username variable
	String username = "Guest";

	// Get the cookies from the request
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if ("username".equals(cookie.getName())) {
		username = cookie.getValue();
		break;
			}
		}
	}

	LoginServiceImpl loginService = new LoginServiceImpl();
	EmployeeModel user = loginService.getUserById(username);
	%>

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
								<img src="https://bootdey.com/img/Content/avatar/avatar7.png"
									alt="Admin" class="rounded-circle" width="150">
								<div class="mt-3">
									<h4><%=username%></h4>


									<button class="btn btn-info" id="passwordbtn">Change
										Password</button>
									<button class="btn btn-outline-primary">Message</button>
								</div>
							</div>
						</div>
						<div class="card-body">
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Employee Name</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=user != null ? user.getFirstName() + " " + user.getLastName() : "Guest"%></div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Position</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=user != null ? user.getPosition() : "Guest"%></div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Email</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=user != null ? user.getEmail() : "Guest"%></div>
							</div>

							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Mobile</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=user != null ? user.getContact_no() : "Guest"%></div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Address</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=user != null
		? user.getAddress() + ", " + user.getCity() + ", " + user.getState() + ", " + user.getCountry()
		: "Guest"%></div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Department</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=user != null ? user.getDepartment() : "Guest"%></div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Joining Date</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=user != null ? user.getJoining_date() : "Guest"%></div>
							</div>
							<hr>
						</div>
					</div>


					<!-- Edit Modal -->
					<!-- Edit Modal -->
					<div id="editModal" class="modal">
						<div class="modal-content">
							<span class="close">&times;</span>
							<h2>Edit Profile</h2>
							<form action="updateProfile" method="post">
								<input type="hidden" name="userId"
									value="<%=user != null ? user.getUserId() : ""%>">

								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="firstName">First Name:</label> <input type="text"
											class="form-control" id="firstName" name="firstName"
											value="<%=user != null ? user.getFirstName() : ""%>">
									</div>
									<div class="form-group col-md-6">
										<label for="lastName">Last Name:</label> <input type="text"
											class="form-control" id="lastName" name="lastName"
											value="<%=user != null ? user.getLastName() : ""%>">
									</div>
								</div>

								<div class="form-group">
									<label for="email">Email:</label> <input type="email"
										class="form-control" id="email" name="email"
										value="<%=user != null ? user.getEmail() : ""%>">
								</div>

								<div class="form-group">
									<label for="contact_no">Mobile:</label> <input type="text"
										class="form-control" id="contact_no" name="contact_no"
										value="<%=user != null ? user.getContact_no() : ""%>"
										required>
									<div class="invalid-feedback" id="phoneError"></div>
								</div>


								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="address">Address:</label> <input type="text"
											class="form-control" id="address" name="address"
											value="<%=user != null ? user.getAddress() : ""%>">
									</div>
									<div class="form-group col-md-3">
										<label for="city">City:</label> <input type="text"
											class="form-control" id="city" name="city"
											value="<%=user != null ? user.getCity() : ""%>">
									</div>

								</div>
								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="state">State:</label> <select class="form-control"
											id="state" name="state">

											<option value="Andhra Pradesh"
												<%="Andhra Pradesh".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Andhra
												Pradesh</option>
											<option value="Arunachal Pradesh"
												<%="Arunachal Pradesh".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Arunachal
												Pradesh</option>
											<option value="Assam"
												<%="Assam".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Assam</option>
											<option value="Bihar"
												<%="Bihar".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Bihar</option>
											<option value="Chhattisgarh"
												<%="Chhattisgarh".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Chhattisgarh</option>
											<option value="Goa"
												<%="Goa".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Goa</option>
											<option value="Gujarat"
												<%="Gujarat".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Gujarat</option>
											<option value="Haryana"
												<%="Haryana".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Haryana</option>
											<option value="Himachal Pradesh"
												<%="Himachal Pradesh".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Himachal
												Pradesh</option>
											<option value="Jharkhand"
												<%="Jharkhand".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Jharkhand</option>
											<option value="Karnataka"
												<%="Karnataka".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Karnataka</option>
											<option value="Kerala"
												<%="Kerala".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Kerala</option>
											<option value="Madhya Pradesh"
												<%="Madhya Pradesh".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Madhya
												Pradesh</option>
											<option value="Maharashtra"
												<%="Maharashtra".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Maharashtra</option>
											<option value="Manipur"
												<%="Manipur".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Manipur</option>
											<option value="Meghalaya"
												<%="Meghalaya".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Meghalaya</option>
											<option value="Mizoram"
												<%="Mizoram".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Mizoram</option>
											<option value="Nagaland"
												<%="Nagaland".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Nagaland</option>
											<option value="Odisha"
												<%="Odisha".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Odisha</option>
											<option value="Punjab"
												<%="Punjab".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Punjab</option>
											<option value="Rajasthan"
												<%="Rajasthan".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Rajasthan</option>
											<option value="Sikkim"
												<%="Sikkim".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Sikkim</option>
											<option value="Tamil Nadu"
												<%="Tamil Nadu".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Tamil
												Nadu</option>
											<option value="Telangana"
												<%="Telangana".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Telangana</option>
											<option value="Tripura"
												<%="Tripura".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Tripura</option>
											<option value="Uttar Pradesh"
												<%="Uttar Pradesh".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Uttar
												Pradesh</option>
											<option value="Uttarakhand"
												<%="Uttarakhand".equals(user != null ? user.getState() : "") ? "selected" : ""%>>Uttarakhand</option>
											<option value="West Bengal"
												<%="West Bengal".equals(user != null ? user.getState() : "") ? "selected" : ""%>>West
												Bengal</option>
										</select>

									</div>
									<div class="form-group col-md-6">
										<label for="country">Country:</label> <select
											class="form-control" id="country" name="country">
											<option value="India"
												<%="India".equals(user != null ? user.getCountry() : "") ? "selected" : ""%>>India</option>

											<!-- Add other options as needed -->
										</select>
									</div>
								</div>


								<button type="submit" class="btn btn-primary">Submit</button>
							</form>
						</div>
					</div>

					<div id="passwordModal" class="modal">
						<div class="modal-content">
							<span class="close">&times;</span>
							<h2>Change Password</h2>
							<form action="changePassword" method="post"
								id="changePasswordForm">
								<input type="hidden" name="userId"
									value="<%=user != null ? user.getUserId() : ""%>">

								<div class="form-group">
									<label for="currentPassword">Current Password:</label> <input
										type="password" class="form-control" id="currentPassword"
										name="currentPassword" required>
								</div>
								<div class="form-group">
									<label for="newPassword">New Password:</label> <input
										type="password" class="form-control" id="newPassword"
										name="newPassword" required>
									<div id="newPasswordError" class="error-message"></div>
								</div>
								<div class="form-group">
									<label for="confirmPassword">Confirm Password:</label> <input
										type="password" class="form-control" id="confirmPassword"
										name="confirmPassword" required>
									<div id="confirmPasswordError" class="error-message"></div>
								</div>

								<button type="submit" class="btn btn-primary">Submit</button>
							</form>
						</div>
					</div>







				</div>
			</div>
			
			
			
			
			<script>
			
			var url = "http://localhost:8080/v1";
			
			
			function getuserDetails() {
			    var userId = document.getElementById("userid").value; // Assuming "userid" is an input field where the user ID is entered
			    
			    $.ajax({
			        url: url + '/api/login/details',
			        method: 'GET',
			        data: { userId: userId },
			        success: function (response) {
			            $("#userId").text(response.id);
			            $("#firstName").text(response.firstName);
			            $(".check").show(); // Assuming you want to make the check div visible when data is fetched
			        },
			        error: function (xhr, status, error) {
			            console.error("Error fetching user details:", error);
			        }
			    });
			}

			
			
			
				document
						.getElementById("changePasswordForm")
						.addEventListener(
								"submit",
								function(event) {
									event.preventDefault(); // Prevent form submission

									var newPassword = document
											.getElementById("newPassword").value;
									var confirmPassword = document
											.getElementById("confirmPassword").value;

									if (newPassword !== confirmPassword) {
										document
												.getElementById("newPasswordError").textContent = "Passwords do not match.";
										document
												.getElementById("confirmPasswordError").textContent = "Passwords do not match.";
									} else {
										// Reset error messages if passwords match
										document
												.getElementById("newPasswordError").textContent = "";
										document
												.getElementById("confirmPasswordError").textContent = "";

										// Submit form
										this.submit();
									}
								});
			</script>
			<script>
				document
						.addEventListener(
								"DOMContentLoaded",
								function() {
									// Phone number validation
									var phoneInput = document
											.getElementById("contact_no");
									var form = document
											.getElementById("profileForm"); // Replace "profileForm" with your form ID

									phoneInput.addEventListener("input",
											function() {
												validatePhoneNumber();
											});

									phoneInput.addEventListener("blur",
											function() {
												validatePhoneNumber();
											});

									function validatePhoneNumber() {
										var phoneNumber = phoneInput.value
												.trim();
										var errorElement = document
												.getElementById("phoneError");

										if (!/^\d{10}$/.test(phoneNumber)) {
											errorElement.textContent = "Phone number must be 10 digits";
											phoneInput.classList
													.add("is-invalid");
										} else {
											errorElement.textContent = "";
											phoneInput.classList
													.remove("is-invalid");
										}
									}

									// Prevent form submission if phone number is invalid
									form.addEventListener("submit", function(
											event) {
										if (!isValidPhoneNumber()) {
											event.preventDefault(); // Prevent form submission
											validatePhoneNumber(); // Validate and show error message
										}
									});

									// Function to check if phone number is valid
									function isValidPhoneNumber() {
										var phoneNumber = phoneInput.value
												.trim();
										return /^\d{10}$/.test(phoneNumber);
									}
								});
			</script>


			<script src="./assets/js/app.js"></script>
			<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</body>
</html>



