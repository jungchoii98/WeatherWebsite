<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.google.gson.*" import="java.lang.Object, java.io.Reader, java.io.BufferedReader, java.io.InputStreamReader,
java.io.FileReader" import="com.google.gson.reflect.TypeToken"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="Results.css">
		<title>Results Page</title>
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
		<%@page import="java.util.ArrayList" %>
		<%@page import="classes.*" %>
		<%
			ArrayList<Weather> cities = (ArrayList<Weather>) session.getAttribute("selected");
			ArrayList<Weather> nameasc = (ArrayList<Weather>) session.getAttribute("nameasc");
			ArrayList<Weather> namedes = (ArrayList<Weather>) session.getAttribute("namedes");
			ArrayList<Weather> templowasc = (ArrayList<Weather>) session.getAttribute("templowasc");
			ArrayList<Weather> templowdes = (ArrayList<Weather>) session.getAttribute("templowdes");
			ArrayList<Weather> temphighasc = (ArrayList<Weather>) session.getAttribute("temphighasc");
			ArrayList<Weather> temphighdes = (ArrayList<Weather>) session.getAttribute("temphighdes");
			
		%>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
			} --%>
		</script>
	</head>
	<body>
		<div id="background"></div>
		<div id="header">
			<h1 id="wm" onclick="goHome()">WeatherMeister</h1>
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
			<h1 id="ac"><%= nameasc.get(0).getName()%></h1>
			<table id="nameasc" class="table">
				<tr>
					<th>City Name</th>
					<th>Temp. Low</th>
					<th>Temp. High</th>
				</tr>
				<%
					if(nameasc != null) {
						if(nameasc.size() != 0) {
							for(Weather w : nameasc) {
								out.println("<tr class='row' onclick='getDetails(\"" + w.getName() + "\")'>");
								out.println("<td>" + w.getName() + "</td>");
								out.println("<td>" + w.getTempMin() + "</td>");
								out.println("<td>" + w.getTempMax() + "</td>");
								out.println("</tr>");
							}
						}
					}
				%>
			</table>
			<table id="namedes" class="table" style="display:none">
				<tr>
					<th>City Name</th>
					<th>Temp. Low</th>
					<th>Temp. High</th>
				</tr>
				<%
					if(namedes != null){
						if(namedes.size() != 0){
							for(Weather w : namedes) {
								out.println("<tr class='row' onclick='getDetails(\"" + w.getName() + "\")'>");
								out.println("<td>" + w.getName() + "</td>");
								out.println("<td>" + w.getTempMin() + "</td>");
								out.println("<td>" + w.getTempMax() + "</td>");
								out.println("</tr>");
							}
						}
					}
				%>
			</table>
			<table id="templowasc" class="table" style="display:none">
				<tr>
					<th>City Name</th>
					<th>Temp. Low</th>
					<th>Temp. High</th>
				</tr>
				<%
					if(templowasc != null){
						if(templowasc.size() != 0){
							for(Weather w : templowasc) {
								out.println("<tr class='row' onclick='getDetails(\"" + w.getName() + "\")'>");
								out.println("<td>" + w.getName() + "</td>");
								out.println("<td>" + w.getTempMin() + "</td>");
								out.println("<td>" + w.getTempMax() + "</td>");
								out.println("</tr>");
							}
						}
					}
				%>
			</table>
			<table id="templowdes" class="table" style="display:none">
				<tr>
					<th>City Name</th>
					<th>Temp. Low</th>
					<th>Temp. High</th>
				</tr>
				<%
					if(templowdes != null){
						if(templowdes.size() != 0){
							for(Weather w : templowdes) {
								out.println("<tr class='row' onclick='getDetails(\"" + w.getName() + "\")'>");
								out.println("<td>" + w.getName() + "</td>");
								out.println("<td>" + w.getTempMin() + "</td>");
								out.println("<td>" + w.getTempMax() + "</td>");
								out.println("</tr>");
							}
						}
					}
				%>
			</table>
			<table id="temphighasc" class="table" style="display:none">
				<tr>
					<th>City Name</th>
					<th>Temp. Low</th>
					<th>Temp. High</th>
				</tr>
				<%
					if(temphighasc != null){
						if(temphighasc.size() != 0){
							for(Weather w : temphighasc) {
								out.println("<tr class='row' onclick='getDetails(\"" + w.getName() + "\")'>");
								out.println("<td>" + w.getName() + "</td>");
								out.println("<td>" + w.getTempMin() + "</td>");
								out.println("<td>" + w.getTempMax() + "</td>");
								out.println("</tr>");
							}
						}
					}
				%>
			</table>
			<table id="temphighdes" class="table" style="display:none">
				<tr>
					<th>City Name</th>
					<th>Temp. Low</th>
					<th>Temp. High</th>
				</tr>
				<%
					if(temphighdes != null){
						if(temphighdes.size() != 0){
							for(Weather w : temphighdes) {
								out.println("<tr class='row' onclick='getDetails(\"" + w.getName() + "\")'>");
								out.println("<td>" + w.getName() + "</td>");
								out.println("<td>" + w.getTempMin() + "</td>");
								out.println("<td>" + w.getTempMax() + "</td>");
								out.println("</tr>");
							}
						}
					}
				%>
			</table>
			<div id="sortList">
				<% 
					if(cities.size() > 1){
						out.println("<h1>Sort By:</h1>");
						out.println("<form>");
						out.println("<select id=\"sort\" onchange='displayTable()'>");
						out.println("<option value=\"nameasc\" selected>City Name A-Z</option>");
						out.println("<option value=\"namedes\">City Name Z-A</option>");
						out.println("<option value=\"templowasc\">Temp. Low ASC</option>");
						out.println("<option value=\"templowdes\">Temp. Low DESC</option>");
						out.println("<option value=\"temphighasc\">Temp. High ASC</option>");
						out.println("<option value=\"temphighdes\">Temp. High DESC</option>");
						out.println("</select>");
						out.println("</form>");
					}
				%>
			</div>
		</div>
	</body>
	 <script async defer
		 src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSAHZsn3Cn6JAnUviblFxAleEGf8nzuWk&callback=initMap">
	</script>
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
	
		function getDetails(cityName) {
			$.ajax({
				url: "GetDetailsServlet",
				data: {
					"city": cityName
				},
				success: function(result){
					window.location.href = "Details.jsp";
				}
			});
		}
		
		function displayTable() {
			var selectBox = document.getElementById("sort");
			var selectedValue = "#" + selectBox.options[selectBox.selectedIndex].value;
			
			$(".table").hide();
			$(selectedValue).show();
		}
		
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
		
		$(document).ready(function(){
			var rows = $('#nameasc tr').length;
			
			if(rows < 2){
				alert("No such city exists!");
			}
		});
	</script>
</html>