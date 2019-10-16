<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="register.css">
		<meta charset="UTF-8">
		<title>Register</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
			function passwordMatches1() {
				$.ajax({
					url: "RegisterUserServlet",
					data: {
						username: document.myform.username.value,
						confirmPassword: document.myform.confirmPassword.value,
						password: document.myform.password.value
					},
					success: function(result) {
						console.log("Result is: " + result);
						if(result === "The passwords do not match."){
							document.getElementById("registerError").innerHTML = "The passwords do not match.";
							console.log("now");
						}
						else if(result === "This username is already taken."){
							document.getElementById("registerError").innerHTML = "This username is already taken.";
						}
						else{
							document.getElementById("registerError").innerHTML = "Successfully created a new account!";
							console.log("here");
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
		<div id="registericon">
			<img id="image" src="new-account-icon-256x256.png">
		</div>
		<div id="content">
			<div id="form">
				<form id="myform" name="myform" action="RegisterUserServlet" method="post">
					<div id="signupInput">
						<h1 id="usernameText" class="format">Username</h1>
						<input type="text" name="username" class="format">
						<h1 id="passwordText" class="format">Password</h1>
						<input type="text" name="password" class="format">
						<h1 id="confirmPasswordText" class="format">Confirm Password</h1>
						<input type="text" name="confirmPassword" class="format">
						<div id="registerError"></div>
						<button id="button" type="button" value="" onClick="passwordMatches1()">Register</button>
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
	
</html>

