<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="signedin.css">
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    	<style>
    		#container{
    			display: none;
    			height: 100%;
    			width: 100%;
    			position: fixed;
    			z-index: 1000;
    		}
	     	 /* Always set the map height explicitly to define the size of the div
	     	  * element that contains the map. */
	     	 #map {
	        	height: 60%;
	        	width: 70%;
	        	z-index: 10000;
	        	margin-left: 15%;
	        	margin-top: 5%;
	      	}
	     	 /* Optional: Makes the sample page fill the window. */
	     	 html, body {
	        	height: 100%;
	        	margin: 0;
	        	padding: 0;
	     	 }
     	 </style>
		<title>Signed In</title>
	</head>
	<body>
		<div id="background"></div>
		<div id="header">
			<h1 id="wm" onclick="goHome()">Weather Meister</h1>
			<h1 id="register" onclick="goSignOut()">Sign Out</h1>
			<h1 id="login" onclick="goProfile()">Profile</h1>
		</div>
		<div id="container">
			<div id="overlay">
				<img src="Black Vignette.png" height="100%" width="100%" style= position:fixed onclick="hideMap()">
			</div>
			<div id="map">
				
			</div>
		</div>
		<div id="content">
			<img id="logo" src="logo.png">
			<div id="form">
				<form action="CitySearchServlet" method="post">
					<div id="cityInput">
						<input style="width:100%" type="text" name="city" placeholder="Los Angeles">
						<input type="submit" value="">
					</div>
					<div id="locationInput" style="display:none">
						<input type="text" name="latitude" placeholder="Latitude">
						<input style="margin-left: 10px" type="text" name="longitude" placeholder="Longitude">
						<img id="mapicon" src="MapIcon.png" onclick="showMap()">
						<input type="submit" value="">
					</div>
					<div id="radio">
						<input type="radio" id="city" name="input" onclick="displayForm()" checked>City
						<input type="radio" id="location" name="input" onclick="displayForm()">Location (Lat./Long.)
						<% session.setAttribute("signedin", true); %>
					</div>
				</form>
			</div>
		</div>
		<script>
    		 // You can set control options to change the default position or style of many
    		 // of the map controls.
				function showMap(){
    			 document.getElementById('container').style.display = 'block';
    		 }
    		 function hideMap(){
    			 document.getElementById('container').style.display = 'none';
    		 }
   			  function initMap() {
		       var map = new google.maps.Map(document.getElementById('map'), {
		         zoom: 4,
		         center: {lat: -33, lng: 151},
		         mapTypeControl: true,
		         mapTypeControlOptions: {
		           style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
		           mapTypeIds: ['roadmap', 'terrain']
		         }
		       });
    		 }
	 	</script>
		 <script async defer
		 src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSAHZsn3Cn6JAnUviblFxAleEGf8nzuWk&callback=initMap">
		 </script>
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
			window.location.replace("signedin.jsp");
		}
		
		function goSignOut(){
			window.location.replace("Home.jsp");
		}
		function goProfile(){
			window.location.replace("profile.jsp");
		}
	</script>
</html>

