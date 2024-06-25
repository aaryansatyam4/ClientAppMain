<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Employee Form</title>
    <link href="./assets/css/app.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="wrapper">
        <jsp:include page="sidebar.jsp"></jsp:include>
        <div class="main">
            <jsp:include page="nav.jsp"></jsp:include>
            <main class="content">
                <div class="container-fluid p-0">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header"></div>
                                <div class="card-body">
                                    <div class="container-fluid mt-3">
                                        <form action="saveEmployee" method="post">
                                            <div class="row">
                                                <div class="col-sm-12 mx-t3 mb-4">
                                                    <h2 class="text-center text-info">New Employee Form</h2>
                                                </div>
                                                <div class="col-sm-6 form-group">
                                                    <label for="fname">First Name</label>
                                                    <input type="text" class="form-control" name="fname" id="fname" placeholder="Enter your first name." required><br>
                                                </div>
                                                <div class="col-sm-6 form-group">
                                                    <label for="lname">Last name</label>
                                                    <input type="text" class="form-control" name="lname" id="lname" placeholder="Enter your last name." required>
                                                </div>
                                                <div class="col-sm-6 form-group">
                                                    <label for="dob">Date Of Birth</label>
                                                    <input type="date" name="dob" class="form-control" id="dob" required><br>
                                                </div>
                                                <div class="col-sm-6 form-group">
                                                    <label for="gender">Gender</label>
                                                    <select id="gender" class="form-control" name="gender">
                                                        <option value="male">Male</option>
                                                        <option value="female">Female</option>
                                                        <option value="unspecified">Unspecified</option>
                                                    </select>
                                                </div>
                                                <!-- Add more form fields as needed -->
                                                <div class="col-sm-12 form-group mb-0">
                                                    <button type="submit" class="btn btn-primary float-right">Add Employee</button>
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
