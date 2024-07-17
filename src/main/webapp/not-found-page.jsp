<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>ERROR 404!!</title>

<!-- BOOTSTRAP LINKS -->
<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- BOOTSTRAP LINKS ENDS-->

<script src="${pageContext.request.contextPath}/assets/js/global.js"
	type="text/javascript"></script>

<script>
	function createDynamicURL() {
		//alert("1111")
		var url = baseURL + "api/login";
		//alert("url:" + url);
		return url;
	}
	function RedirectURL() {
		//alert("2222")
		window.location = createDynamicURL();
	}
</script>

<style>
body, * {
	height: 100%;
	margin: 0;
	padding: 0;
}

h4, p {
	margin: 0;
	padding: 0;
}

#content {
	height: 100%;
}

#content div {
	height: max-content;
}

.button4 {
	border-radius: 12px;
}

.tryAgainLink {
	color: #117a8b;
	font-weight: 700;
	text-decoration: underline;
}
</style>


<link rel="apple-touch-icon" sizes="57x57"
	href="images/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60"
	href="images/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72"
	href="images/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76"
	href="images/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="images/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120"
	href="images/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144"
	href="images/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152"
	href="images/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180"
	href="images/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"
	href="images/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="images/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="images/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="images/favicon-16x16.png">

<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage"
	content="images/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
</head>

<body class="text-center">

	<div class="container mt-3">

		<div id="content"
			class="row d-flex align-items-center justify-content-center">
			<div class="col-6">

				<div class="p-2">
					<h1>Not Found</h1>
					<br>
					<h2>Error 404</h2>
				</div>
				<div class="p-2"></div>
				<div class="p-2"></div>
				<div class="px-2 pb-2 pt-0">

					<a href="#" onclick="RedirectURL();return false;"></a>

				</div>


			</div>


		</div>
	</div>

</body>

</html>
