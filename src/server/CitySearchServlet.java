package server;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

import classes.CityNameAscendingComparator;
import classes.CityNameDescendingComparator;
import classes.TempHighAscendingComparator;
import classes.TempHighDescendingComparator;
import classes.TempLowAscendingComparator;
import classes.TempLowDescendingComparator;
import classes.Weather;
import classes.WeatherObjects;
import classes.parsedJson;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@WebServlet("/CitySearchServlet")
public class CitySearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String city = request.getParameter("city");
    	String lat = request.getParameter("latitude");
    	String lon = request.getParameter("longitude");
    	
    	ArrayList<Integer> ids = new ArrayList<Integer>();
    	ArrayList<Weather> selected = new ArrayList<Weather>();
    	Weather temp = new Weather();
    	HttpSession session = request.getSession();
    	
    	//parse the json only once
    	if(parsedJson.wobs == null){
			//retreive the parsed json
			parsedJson.parse();
			System.out.println(parsedJson.wobs.size());
		}
    	if(city != "") {
    		//get all the cities with the same name
        	if(parsedJson.wobs == null) {
        		System.out.println("wobs is null");
        	}
        	else {
        		for(int i=0; i<parsedJson.wobs.size(); i++){
            		if(parsedJson.wobs.get(i).getName() != null && parsedJson.wobs.get(i).getName().equals(city)) {
            			ids.add(parsedJson.wobs.get(i).getID());
            		}
            	}
        	}
        	//integer magic to create the url of all the ids and then call API
        	try {
        		for(int j=0; j<ids.size(); j++) {
            		String url = "http://api.openweathermap.org/data/2.5/weather?id=";
            		url += Integer.toString(ids.get(j));
            		url += API_KEY;
            		url += "&units=imperial";
            		//Use gson to parse the json
            		//System.out.println(url);
//            		String paramValue = url;
//            		url =  java.net.URLEncoder.encode(paramValue, "UTF-8");
//            		java.net.URL finalURL = new java.net.URL(url);
            		
            		URL api = new URL(url);
            		BufferedReader br = new BufferedReader(new InputStreamReader(api.openStream()));
            	
            		
            		Gson gson = new Gson();
            		//TypeToken<ArrayList<Weather>> token = new TypeToken<ArrayList<Weather>>() {};
            		temp = gson.fromJson(br, Weather.class);
            		selected.add(temp);
            	}
        	}catch(FileNotFoundException fnfe) {
        		System.out.println("file could not be found");
        	}catch(IOException ioe) {
        		System.out.println("ioe: " + ioe.getMessage());
        	}
    	}
    	//get the city with the same latitude and longitude
    	else if(lat != "" && lon != "") {
    		System.out.println("IM HERE");
    		//create url to call API
    		try {
    			String url = "http://api.openweathermap.org/data/2.5/weather?lat=";
    			url += lat;
    			url += "&lon=";
    			url += lon;
    			url += "&appid=59e26831249faf32782afec19a070f85";
    			url += "&units=imperial";
    			
    			URL api = new URL(url);
    			BufferedReader br = new BufferedReader(new InputStreamReader(api.openStream()));
    			
    			Gson gson = new Gson();
    			temp = gson.fromJson(br, Weather.class);
    			selected.add(temp);
    		}catch(FileNotFoundException fnfe) {
    			System.out.println("file could not be found");
    		}catch(IOException ioe) {
    			System.out.println("ioe: " + ioe.getMessage());
    		}
    	}
    	
    	//variables for accessing database
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		
		System.out.println("this is signed in session variable." + session.getAttribute("signedin"));
		boolean signedin = (boolean)session.getAttribute("signedin");
    	if(signedin) {
    		System.out.println("getting in here");
    		int currUser = (int) session.getAttribute("currentUser");
    		try {
        		Class.forName("com.mysql.cj.jdbc.Driver");
        		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HW3Database?user=root&password=youtube1");
        		if(city != "") {
        			String query = " insert into UserHistory (userInput, userID)" + " values (?, ?)";
        			ps = conn.prepareStatement(query);
        			ps.setString(1, city);
        			ps.setInt(2,  currUser);
        			ps.execute();
        		}
        		else if(lat != "" && lon != "") {
        			String query = " insert into UserHistory (userInput, userID)" + " values (?, ?)";
        			ps = conn.prepareStatement(query);
        			ps.setString(1, "(" + lat + ", " + lon + ")");
        			ps.setInt(2,  currUser);
        			ps.execute();
        		}
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
    			}catch (SQLException sqle) {
    				System.out.println("sqle closing stuff: " + sqle.getMessage());
    			}
    		}
    	}
    	
    	
    	session.setAttribute("selected", selected);
    	
    	ArrayList<Weather> nameasc = new ArrayList<Weather>();
    	ArrayList<Weather> namedes = new ArrayList<Weather>();
    	ArrayList<Weather> templowasc = new ArrayList<Weather>();
    	ArrayList<Weather> templowdes = new ArrayList<Weather>();
    	ArrayList<Weather> temphighasc = new ArrayList<Weather>();
    	ArrayList<Weather> temphighdes = new ArrayList<Weather>();
    	
    	Collections.sort(selected, new CityNameAscendingComparator());
    	for(Weather w : selected) {
    		nameasc.add(w.clone());
    	}
    	Collections.sort(selected, new CityNameDescendingComparator());
    	for(Weather w : selected) {
    		namedes.add(w.clone());
    	}
    	Collections.sort(selected, new TempLowAscendingComparator());
    	for(Weather w : selected) {
    		templowasc.add(w.clone());
    	}
    	Collections.sort(selected, new TempLowDescendingComparator());
    	for(Weather w : selected) {
    		templowdes.add(w.clone());
    	}
    	Collections.sort(selected, new TempHighAscendingComparator());
    	for(Weather w : selected) {
    		temphighasc.add(w.clone());
    	}
    	Collections.sort(selected, new TempHighDescendingComparator());
    	for(Weather w : selected) {
    		temphighdes.add(w.clone());
    	}
    	
    	session.setAttribute("nameasc", nameasc);
    	session.setAttribute("namedes", namedes);
    	session.setAttribute("templowasc", templowasc);
    	session.setAttribute("templowdes", templowdes);
    	session.setAttribute("temphighasc", temphighasc);
    	session.setAttribute("temphighdes", temphighdes);
    	
    	RequestDispatcher rd = request.getRequestDispatcher("/Results.jsp");
    	rd.forward(request, response);
    }
}
