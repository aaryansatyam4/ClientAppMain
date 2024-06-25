var baseURL = "http://localhost:8080/v1/"

function checkCredentials(event) {
//alert("checkCredientials");
event.preventDefault();
var userName = $("#username").val();
var password = $("#password").val();
if (userName == "") {
$("#username_msg").html("Username can't be empty")
//alert("Username can't be empty");
//location.href = baseURL;
return false;
}
if (password == "") {
$("#password_msg").html("password can't be empty")

php

	//location.href = baseURL;
	return false;
}

var url = baseURL + "api/login/check/credentials";
//alert(url);

$.ajax({
    url: url,
    type: "POST",
    data: {
        userName: userName,
        password: password
    },
    success: function(result) {
        result = JSON.parse(result);
        //alert("Result: "+ result.message());
        
		if (result.status === "success") {
						//alert("Success");
						if(result.role === "super_admin"){
		                	window.location.href = "index.jsp";
		                }
		                else if(result.role === "admin"){
							window.location.href = "index.jsp";
						}
						else{
							window.location.href = "employee_dashboard.jsp";
						}
		            } else {
		                //alert("Login failed: " + result.message);
		            }
		
		
		
    }
});
return false;

}



