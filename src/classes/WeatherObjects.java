package classes;

public class WeatherObjects {
	int id;
	String name;
	String country;
	Coord coord;
	
	public int getID() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getCountry() {
		return country;
	}
	public Double getLat() {
		return coord.getLat();
	}
	public Double getLon() {
		return coord.getLon();
	}
}
