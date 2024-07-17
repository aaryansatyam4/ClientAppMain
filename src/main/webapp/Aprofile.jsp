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

<title>profile</title>

<link href="./assets/css/app.css" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap"
	rel="stylesheet">

<link
	href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css"
	rel="stylesheet">

<link
	href="https://cdn.datatables.net/buttons/3.0.2/css/buttons.dataTables.css"
	rel="stylesheet">


<style type="text/css">
body {
	margin-top: 20px;
	color: #1a202c;
	text-align: left;
	background-color: #e2e8f0;
}

.main-body {
	padding: 15px;
}

.card {
	box-shadow: 0 1px 3px 0 rgba(0, 0, 0, .1), 0 1px 2px 0
		rgba(0, 0, 0, .06);
}

.card {
	position: relative;
	display: flex;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-color: #fff;
	background-clip: border-box;
	border: 0 solid rgba(0, 0, 0, .125);
	border-radius: .25rem;
}

.card-body {
	flex: 1 1 auto;
	min-height: 1px;
	padding: 1rem;
}

.gutters-sm {
	margin-right: -8px;
	margin-left: -8px;
}

.gutters-sm>.col, .gutters-sm>[class*=col-] {
	padding-right: 8px;
	padding-left: 8px;
}

.mb-3, .my-3 {
	margin-bottom: 1rem !important;
}

.bg-gray-300 {
	background-color: #e2e8f0;
}

.h-100 {
	height: 100% !important;
}

.shadow-none {
	box-shadow: none !important;
}
</style>

<script>
label {
    font-weight: 600;
    color: #666;
}
body {
  background: #f1f1f1;
}
.box8{
  box-shadow: 0px 0px 5px 1px #999;
}
.mx-t3{
  margin-top: -3rem;
}
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
            if ("user".equals(cookie.getName())) {
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

			<!-- main container start -->

			<div class="main-body">

				<div class="row gutters-sm">
					<div class="col-md-4 mb-3">
						<div class="card">
							<div class="card-body">
								<div class="d-flex flex-column align-items-center text-center">
									<img src="https://bootdey.com/img/Content/avatar/avatar7.png"
										alt="Admin" class="rounded-circle" width="150">
									<div class="mt-3">
										<h4><%=username %></h4>
										<p class="text-secondary mb-1"><%= user != null ? user.getPosition() : "Guest" %></p>
										<p class="text-muted font-size-sm"><%= user != null ? user.getState()+ ", " + user.getCountry() : "Guest" %></p>
										<button class="btn btn-primary">Contact</button>
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
										<h6 class="mb-0">Phone</h6>
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
									<div class="col-sm-9 text-secondary"><%= user != null ? user.getAddress()+ ", " + user.getCity()+ ", " + user.getState()+ ", " + user.getCountry() : "Guest" %></div>
								</div>
								<hr>
								<div class="row">
									<div class="col-sm-12">
										<a class="btn btn-info " href="#">Edit</a>
									</div>
								</div>
							</div>
						</div>

						

					</div>
				</div>

			</div>
			<!-- main container end -->

			<%-- <jsp:include page="footer.jsp"></jsp:include> --%>
		</div>
	</div>

	<script src="./assets/js/app.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

</body>

</html>