<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="login.css">
		<meta charset="UTF-8">
		<title>Login</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script>
			function correctLogin() {
				$.ajax({
					url: "LoginUserServlet",
					data: {
						username: document.myform.username.value,
						password: document.myform.password.value
					},
					success: function(result) {
						console.log("Result is: " + result);
						if(result === "This user does not exist."){
							document.getElementById("loginError").innerHTML = "This user does not exist.";
							console.log("number 1");
						}
						else if(result === "Incorrect Password."){
							document.getElementById("loginError").innerHTML = "Incorrect Password";
							console.log("number 2");
						}
						else{
							document.getElementById("loginError").style.color = "blue";
							document.getElementById("loginError").innerHTML = "Successful login!";
							window.location.replace("signedin.jsp");
						}
						
					}
				})
			}
		</script>
	</head>
	<body>
		<div id="background"></div>
		<div id="header">
			<h1 id="wm" onclick="goHome()">Weather Meister</h1>
			<h1 id="register" onclick="goRegister()">Register</h1>
			<h1 id="login" onclick="goLogin()">Login</h1>
		</div>
		<div id="loginicon">
			<img id="image" src="Keychain_Locked@2x.png">
		</div>
		<div id="content">
			<div id="form">
				<form name="myform" action="LoginUserServlet" method="post">
					<div id="loginInput">
						<h1 id="usernameText">Username</h1>
						<input type="text" name="username">
						<h1 id="passwordText">Password</h1>
						<input type="text" name="password">
						<div id="loginError"></div>
						<button id="button" type="button" value="" onClick="correctLogin()">Login</button>
					</div>
					<!-- <div id="cityInput">
						<input style="width:100%" type="text" name="city" placeholder="Los Angeles">
						<input type="submit" value="">
					</div>
					<div id="locationInput" style="display:none">
						<input type="text" name="latitude" placeholder="Latitude">
						<input style="margin-left: 10px" type="text" name="longitude" placeholder="Longitude">
						<input type="submit" value="">
					</div>
					<div id="radio">
						<input type="radio" id="city" name="input" onclick="displayForm()" checked>City
						<input type="radio" id="location" name="input" onclick="displayForm()">Location (Lat./Long.)
					</div> -->
				</form>
			</div>
		</div>
	</body>
	
	<script>
		function displayForm() {
			if(document.getElementById('city').checked){
				document.getElementById('cityInput').style.display = 'block';
				document.getElementById('locationInput').style.display = 'none';
			}
			else{
				document.getElementById('cityInput').style.display = 'none';
				document.getElementById('locationInput').style.display = 'block';
			}
		}
		
		function goHome(){
			window.location.replace("Home.jsp");
		}
		function goLogin(){
			window.location.replace("login.jsp");
		}
		function goRegister(){
			window.location.replace("register.jsp");
		}
	</script>
</html>

