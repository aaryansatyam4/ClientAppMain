<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.digicode.dao.LoginServiceImpl" %>
<%@ page import="com.digicode.model.EmployeeModel" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
<meta name="author" content="AdminKit">
<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="shortcut icon" href="./assets/img/icons/icon-48x48.png" />
<link rel="canonical" href="https://demo-basic.adminkit.io/" />
<title>Profile</title>
<link href="./assets/css/app.css" rel="stylesheet">
<link href="./assets/css/profile.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
<link href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css" rel="stylesheet">
<link href="https://cdn.datatables.net/buttons/3.0.2/css/buttons.dataTables.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<script>
document.addEventListener("DOMContentLoaded", function() {
    var editModal = document.getElementById("editModal");
    var editIcon = document.getElementById("editIcon");
    var editClose = editModal.querySelector(".close");

    editIcon.onclick = function() {
        editModal.style.display = "block";
    }

    editClose.onclick = function() {
        editModal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == editModal) {
            editModal.style.display = "none";
        }
    }

    var passwordModal = document.getElementById("passwordModal");
    var passwordBtn = document.getElementById("passwordbtn");
    var passwordClose = passwordModal.querySelector(".close");

    passwordBtn.onclick = function() {
        passwordModal.style.display = "block";
    }

    passwordClose.onclick = function() {
        passwordModal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == passwordModal) {
            passwordModal.style.display = "none";
        }
    }
});


</script>

</head>
<body>

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
        <div class="heading">
        <h1>Employee Dashboard</h1>
        <div class="edit-icon-container">
    <i class="fas fa-edit edit-icon" id="editIcon"></i>
</div>
        
    </div>
        
            <div class="row gutters-sm">
                <div class="col-md-4 mb-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex flex-column align-items-center text-center">
                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Admin" class="rounded-circle" width="150">
                                <div class="mt-3">
                                    <h4><%= username %></h4>
                                    <p class="text-secondary mb-1"><%= user != null ? user.getPosition() : "Guest" %></p>
                                    <p class="text-muted font-size-sm"><%= user != null ? user.getState() + ", " + user.getCountry() : "Guest" %></p>
                                    <button class="btn btn-info" id="passwordbtn">Change Password</button>
                                    <button class="btn btn-outline-primary">Message</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Full Name</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><%= user != null ? user.getFirstName() + " " + user.getLastName() : "Guest" %></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Email</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><%= user != null ? user.getEmail() : "Guest" %></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Position</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><%= user != null ? user.getPosition() : "Guest" %></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Mobile</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><%= user != null ? user.getContact_no() : "Guest" %></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Address</h6>
                                </div>
                                <div class="col-sm-9 text-secondary"><%= user != null ? user.getAddress() + ", " + user.getCity() + ", " + user.getState() + ", " + user.getCountry() : "Guest" %></div>
                            </div>
                            <hr>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <!-- Edit Modal -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Edit Profile</h2>
        <form action="updateProfile" method="post">
            <input type="hidden" name="userId" value="<%= user != null ? user.getUserId() : "" %>">

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="firstName">First Name:</label>
                    <input type="text" class="form-control" id="firstName" name="firstName" value="<%= user != null ? user.getFirstName() : "" %>">
                </div>
                <div class="form-group col-md-6">
                    <label for="lastName">Last Name:</label>
                    <input type="text" class="form-control" id="lastName" name="lastName" value="<%= user != null ? user.getLastName() : "" %>">
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= user != null ? user.getEmail() : "" %>">
            </div>

            <div class="form-group">
                <label for="contact_no">Mobile:</label>
                <input type="text" class="form-control" id="contact_no" name="contact_no" value="<%= user != null ? user.getContact_no() : "" %>">
            </div>

            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" class="form-control" id="address" name="address" value="<%= user != null ? user.getAddress() : "" %>">
            </div>

            <div class="form-row">
                <div class="form-group col-md-3">
                    <label for="city">City:</label>
                    <input type="text" class="form-control" id="city" name="city" value="<%= user != null ? user.getCity() : "" %>">
                </div>
                <div class="form-group col-md-3">
                    <label for="state">State:</label>
                    <input type="text" class="form-control" id="state" name="state" value="<%= user != null ? user.getState() : "" %>">
                </div>
                <div class="form-group col-md-2">
                    <label for="pin">Pin:</label>
                    <input type="text" class="form-control" id="pin" name="pin" value="<%= user != null ? user.getPin() : "" %>">
                </div>
                <div class="form-group col-md-4">
                    <label for="country">Country:</label>
                    <select class="form-control" id="country" name="country">
                        <option value="India" <%= "India".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>India</option>
                        <option value="USA" <%= "USA".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>USA</option>
                        <option value="Canada" <%= "Canada".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>Canada</option>
                        <option value="UK" <%= "UK".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>UK</option>
                        <option value="Australia" <%= "Australia".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>Australia</option>
                        <option value="Germany" <%= "Germany".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>Germany</option>
                        <option value="France" <%= "France".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>France</option>
                        <option value="Italy" <%= "Italy".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>Italy</option>
                        <option value="Spain" <%= "Spain".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>Spain</option>
                        <option value="Japan" <%= "Japan".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>Japan</option>
                        <option value="China" <%= "China".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>China</option>
                        <option value="Brazil" <%= "Brazil".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>Brazil</option>
                        <option value="Russia" <%= "Russia".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>Russia</option>
                        <option value="Mexico" <%= "Mexico".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>Mexico</option>
                        <option value="South Africa" <%= "South Africa".equals(user != null ? user.getCountry() : "") ? "selected" : "" %>>South Africa</option>
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
        <form action="changePassword" method="post">
            <input type="hidden" name="userId" value="<%= user != null ? user.getUserId() : "" %>">

            <div class="form-group">
                <label for="currentPassword">Current Password:</label>
                <input type="password" class="form-control" id="currentPassword" name="currentPassword">
            </div>

            <div class="form-group">
                <label for="newPassword">New Password:</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword">
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
            </div>

            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>

 
 
 
     
       

    </div>
</div>

<script src="./assets/js/app.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

</body>
</html>