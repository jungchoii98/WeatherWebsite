package server;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.CityNameAscendingComparator;
import classes.CityNameDescendingComparator;
import classes.TempHighAscendingComparator;
import classes.TempHighDescendingComparator;
import classes.TempLowAscendingComparator;
import classes.TempLowDescendingComparator;
import classes.Weather;

@WebServlet("/LatLongSearchServlet")
public class LatLongSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String latitude = request.getParameter("latitude");
    	String longitude = request.getParameter("longitude");
    	
    	ArrayList<Weather> selected = new ArrayList<Weather>();
    	HttpSession session = request.getSession();
    	
    	ArrayList<Weather> cities = (ArrayList<Weather>) session.getAttribute("cities");
    	
    	for(Weather w : cities) {
    		if(w.getLongitude() == Double.parseDouble(longitude) && w.getLatitude() == Double.parseDouble(latitude)) {
    			selected.add(w);
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
