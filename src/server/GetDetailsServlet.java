package server;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import classes.Weather;

@WebServlet("/GetDetailsServlet")
public class GetDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String city = request.getParameter("city");
		String latitude = request.getParameter("latitude");
		String longitude = request.getParameter("longitude");
		
		HttpSession session = request.getSession();
		ArrayList<Weather> cities = (ArrayList<Weather>) session.getAttribute("selected");
		
		Weather w = null;
		
		if(city != null) {
			for(Weather weather: cities) {
				if(weather.getName().equals(city)) {
					w = weather;
				}
			}
		}
		if(latitude != null && longitude != null) {
			for(Weather weather: cities) {
				if(weather.getLatitude() == Double.parseDouble(latitude) && weather.getLongitude() == Double.parseDouble(longitude)) {
					w = weather;
				}
			}
		}
		
		session.setAttribute("city", w);
	}
}
