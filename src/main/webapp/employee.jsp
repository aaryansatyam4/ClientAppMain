<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.digicode.model.EmployeeModel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.digicode.dao.LoginServiceImpl"%>



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
div.dt-button-collection {
    width: 400px;
}
 
div.dt-button-collection button.dt-button {
    display: inline-block;
    width: 32%;
}
div.dt-button-collection button.buttons-colvis {
    display: inline-block;
    width: 49%;
}
div.dt-button-collection h3 {
    margin-top: 5px;
    margin-bottom: 5px;
    font-weight: 100;
    border-bottom: 1px solid rgba(150, 150, 150, 0.5);
    font-size: 1em;
    padding: 0 1em;
}
div.dt-button-collection h3.not-top-heading {
    margin-top: 10px;
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
								<div class="card-header">
									<Strong class="h3 mb-3">Employees List</Strong>
									<button type="button"
										class="btn btn-link float-end newEmployee">Add New
										Employee</button>
								</div>


								<div class="card-body">

									<div class="">
										<table id="example" class="display" style="width: 100%">
											<thead>
												<tr>
													<th>ID</th>
													<th>Name</th>
													<th>DOB</th>
													<th>Position</th>
													<th>Start date</th>
													
													<th>Address</th>
												</tr>
											</thead>
											<tbody>
												<%
												LoginServiceImpl loginServiceImpl = new LoginServiceImpl();
																						List<EmployeeModel> empList = new ArrayList<EmployeeModel>();
																						empList = loginServiceImpl.listAllEmplyee();
																						if (!empList.isEmpty()) {
																							for (EmployeeModel emp : empList) {
												%>
												<tr>
													<td><%=emp.getUserId()%></td>
													<td><%=emp.getFirstName()%> <%=emp.getLastName()%></td>
													<td><fmt:formatDate pattern="dd-MM-yyyy"
															value="<%=emp.getDob()%>" /></td>
													<td><%=emp.getPosition()%></td>
													
													<td><fmt:formatDate pattern="dd-MM-yyyy"
															value="<%=emp.getJoining_date()%>" /></td>
													<td><%=emp.getAddress()%>, <%=emp.getState()%> (<%=emp.getCountry()%>)
													</td>
												</tr>
												<%
												}
												}
												%>
											</tbody>

										</table>
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
	<script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
	<script
		src="https://cdn.datatables.net/buttons/3.0.2/js/dataTables.buttons.js"></script>
	<script
		src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.dataTables.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
	<script
		src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.html5.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
	<script
		src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.colVis.min.js"></script>



	<script>		
		new DataTable(
				'#example',
				{
					layout : {
						topStart : {
							buttons : [ {
								extend : 'collection',
								className : 'custom-html-collection',
								buttons : [
										'<h3>Export</h3>',
										'pdf',
										'csv',
										'excel',
										'<h3 class="not-top-heading">Column Visibility</h3>',
										'columnsToggle' ]
							} ]
						}
					}
				});
		
		$(document).ready(function(){
			
			$('.newEmployee').click(function(){
				location.href= "newEmployee.jsp";
			});
			
		});
	</script>

</body>

</html>