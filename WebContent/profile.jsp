<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList" import="java.sql.*"%>
    
<!DOCTYPE html>
<%
	int currUser = (int) session.getAttribute("currentUser");
	String username = "";
	ArrayList<String> history = new ArrayList<String>();
	//variables for accessing database
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	PreparedStatement ps2 = null;
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HW3Database?user=root&password=youtube1");
		String query = "SELECT * FROM UserHistory WHERE userID=?";
		ps = conn.prepareStatement(query);
		ps.setInt(1, currUser);
		rs = ps.executeQuery();
		while(rs.next()){
			history.add(rs.getString("userInput"));
		}
		
		query = "SELECT * FROM UserInfo WHERE userID=?";
		ps2 = conn.prepareStatement(query);
		ps2.setInt(1, currUser);
		rs = ps2.executeQuery();
		rs.next();
		username = rs.getString("username");
	}catch(SQLException sqle) {
		System.out.println("sqle: " + sqle.getMessage());
	}catch(ClassNotFoundException cnfe) {
		System.out.println("cnfe: " + cnfe.getMessage());
	}finally {
		try {
			if(rs != null) {
				rs.close();
			}
			if(ps != null) {
				ps.close();
			}
			if(conn != null) {
				conn.close();
			}
			if(ps2 != null){
				ps2.close();
			}
		}catch (SQLException sqle) {
			System.out.println("sqle closing stuff: " + sqle.getMessage());
		}
	}
	System.out.println(history.size() + "this is history size");
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="profile.css">
		<meta charset="UTF-8">
		<title>Profile</title>
	</head>
	<body>
		<div id="background"></div>
		<div id="header">
			<h1 id="wm" onclick="goHome()">Weather Meister</h1>
		</div>
		<div>
			<h1 id="ac"><%= username %>'s Search History</h1>
			<table class="table">
				<%for(int i=history.size()-1; i>=0; i--) {
					out.println("<tr class='row'>");
					out.println("<td style='color:white'>" + history.get(i) + "</td>");
				}
				%>
			</table>
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
			window.location.replace("signedin.jsp");
		}
	</script>
</html>

