

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

<title>AdminKit Demo - Bootstrap 5 Admin Template</title>

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
	<div class="wrapper">

		<jsp:include page="sidebar.jsp"></jsp:include>

		<div class="main">

			<jsp:include page="nav.jsp"></jsp:include>

			<!-- main container start -->
			<main class="content">
				<div class="container-fluid p-0">

					<!-- <h1 class="h3 mb-3">Employees List</h1> -->


					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header"></div>
								<div class="card-body">

									<div class="container-fluid mt-3">
										<form>

											<div class="row  ">
												<div class="col-sm-12 mx-t3 mb-4">
													<h2 class="text-center text-info">New Employee Form</h2>
												</div>


												<div class="col-sm-6 form-group">
													<label for="name-f">First Name</label> <input type="text"
														class="form-control" name="fname" id="name-f"
														placeholder="Enter your first name." required><br>
												</div>

												<div class="col-sm-6 form-group">
													<label for="name-l">Last name</label> <input type="text"
														class="form-control" name="lname" id="name-l"
														placeholder="Enter your last name." required>
												</div>

												<div class="col-sm-6 form-group">
													<label for="Date">Date Of Birth</label> <input type="Date"
														name="dob" class="form-control" id="Date" placeholder=""
														required><br>
												</div>

												<div class="col-sm-6 form-group">
													<label for="sex">Gender</label> <select id="sex"
														class="form-control browser-default custom-select">
														<option value="male">Male</option>
														<option value="female">Female</option>
														<option value="unspesified">Unspecified</option>
													</select>
												</div>


												<div class="col-sm-6 form-group">
													<label for="tel">Phone</label> <input type="tel"
														name="phone" class="form-control" id="tel"
														placeholder="Enter Your Contact Number." required><br>
												</div>

												<div class="col-sm-6 form-group">
													<label for="tel">Email</label> <input type="tel"
														name="phone" class="form-control" id="tel"
														placeholder="Enter Your Contact Number." required>
												</div>

												<div class="col-sm-6 form-group">
													<label for="sex">Department</label> <select id="sex"
														class="form-control browser-default custom-select">
														<option value="male">Male</option>
														<option value="female">Female</option>
														<option value="unspesified">Unspecified</option>
													</select><br>
												</div>

												<div class="col-sm-6 form-group">
													<label for="sex">Role</label> <select id="sex"
														class="form-control browser-default custom-select">
														<option value="male">Male</option>
														<option value="female">Female</option>
														<option value="unspesified">Unspecified</option>
													</select>
												</div>

												<div class="col-sm-12 form-group">
													<label for="tel">Address</label> <input type="tel"
														name="phone" class="form-control" id="tel"
														placeholder="Enter Your Contact Number." required><br>
												</div>

												<div class="col-sm-6 form-group">
													<label for="sex">State</label> <select id="sex"
														class="form-control browser-default custom-select">
														<option value="male">Male</option>
														<option value="female">Female</option>
														<option value="unspesified">Unspecified</option>
													</select><br>
												</div>

												<div class="col-sm-4 form-group">
													<label for="sex">Country</label> <select id="sex"
														class="form-control browser-default custom-select">
														<option value="male">India</option>
													</select>
												</div>

												<div class="col-sm-2 form-group">
													<label for="sex">PIN </label> <input type="text"
														name="phone" class="form-control" id="tel"
														placeholder="Enter Your Contact Number." required><br>
												</div>


												<div class="col-sm-12 form-group mb-0">
													<button class="btn btn-primary float-right">Add
														Employee</button>
												</div>

											</div>
										</form>
									</div>

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

</body>

</html>