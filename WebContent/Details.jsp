<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="Details.css">
		<title>Details Page</title>
		<%@page import="classes.*" %>
		<%
			Weather weather = (Weather) request.getSession().getAttribute("city");
		%>
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	</head>
	<body>
		<div id="background"></div>
		<div id="header">
			<h1 onclick="goHome()">WeatherMeister</h1>
			<div id="form">
				<form action="CitySearchServlet" method="post">
					<div id="cityInput">
						<input type="text" name="city" placeholder="Los Angeles">
						<button type="submit">Submit</button>
					</div>
					<div id="locationInput" style="display:none">
						<input type="text" name="latitude" placeholder="Latitude">
						<input type="text" name="longitude" placeholder="Longitude">
						<img id="mapicon" src="MapIcon.png" onclick="showMap()">
						<button type="submit">Submit</button>
					</div>
					<div id="radio">
						<input type="radio" id="city" name="input" onclick="displayForm()" checked>City
						<input type="radio" id="location" name="input" onclick="displayForm()">Location (Lat./Long.)
					</div>
				</form>
			</div>
		</div>
		<div id="container">
			<div id="overlay">
				<img src="Black Vignette.png" height="100%" width="100%" style= position:fixed onclick="hideMap()">
			</div>
			<div id="map">
				
			</div>
		</div>
		<div class="content">
			<h1 id="title"><%=weather.getName()%></h1>
			<div id="components">
				<div id="row1">
					<div class="component" id="loc" onclick='switchDisplay("#loc")'>
						<img src="planet-earth.png">
						<% out.println("<p>" + weather.getSys().getCountry() + "</p>"); %>
						<h2>Location</h2>
					</div>
					<div class="component" id="templow" onclick='switchDisplay("#templow")'>
						<img src="snowflake.png">
						<% out.println("<p>" + weather.getTempMin() + " degrees Fahrenheit</p>"); %>
						<h2>Temp Low</h2>
					</div>
					<div class="component" id="temphigh" onclick='switchDisplay("#temphigh")'>
						<img src="sun.png">
						<% out.println("<p>" + weather.getTempMax() + " degrees Fahrenheit</p>"); %>
						<h2>Temp High</h2>
					</div>
					<div class="component" id="wind" onclick='switchDisplay("#wind")'>
						<img src="wind.png">
						<% out.println("<p>" + weather.getWindspeed() + " miles/hour</p>"); %>
						<h2>Wind</h2>
					</div>
				</div>
				<div id="row2">
					<div class="component" id="humidity" onclick='switchDisplay("#humidity")'>
						<img src="drop.png">
						<% out.println("<p>" + weather.getHumidity() + "%</p>"); %>
						<h2>Humidity</h2>
					</div>
					<div class="component" id="coordinates" onclick='switchDisplay("#coordinates")'>
						<img src="LocationIcon.png">
						<% out.println("<p>" + weather.getLatitude() + ", " + weather.getLongitude() + "</p>"); %>
						<h2>Coordinates</h2>
					</div>
					<div class="component" id="currenttemp" onclick='switchDisplay("#currenttemp")'>
						<img src="thermometer.png">
						<% out.println("<p>" + weather.getCurrentTemperature() + " degrees Fahrenheit</p>"); %>
						<h2>Current Temp</h2>
					</div>
					<div class="component" id="sunrise-set" onclick='switchDisplay("#sunrise-set")'>
						<img src="sunrise-icon.png">
						<% out.println("<p>" + weather.getSunrise() + ", " + weather.getSunset() + "</p>"); %>
						<h2>Sunrise/set</h2>
					</div>
				</div>
			</div>
		</div>
	</body>
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
	<script>
		function displayForm() {
			if(document.getElementById('city').checked){
				document.getElementById('cityInput').style.display = 'inline';
				document.getElementById('locationInput').style.display = 'none';
			}
			else{
				document.getElementById('cityInput').style.display = 'none';
				document.getElementById('locationInput').style.display = 'inline';
			}
		}
		
		function goHome(){
			<%
				if((boolean)session.getAttribute("signedin")){
					%>window.location.replace("signedin.jsp");<%
				}
				else{
					%>window.location.replace("Home.jsp");<%
				}
			%> 
			
		}
		
		function switchDisplay(div){
			$(div).find("img").toggle();
			$(div).find("p").toggle();
		}
		
		$(document).ready(function(){
			$("p").hide();
		});
	</script>
</html>