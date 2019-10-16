
package classes;

import java.util.List;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
//import classes.Clouds;

public class Weather {

    @SerializedName("coord")
    @Expose
    private Coord coord;
    @SerializedName("sys")
    @Expose
    private Sys sys;
    @SerializedName("weather")
    @Expose
    private List<Weather_> weather = null;
    @SerializedName("base")
    @Expose
    private String base;
    @SerializedName("main")
    @Expose
    private Main main;
    @SerializedName("wind")
    @Expose
    private Wind wind;
    @SerializedName("clouds")
    @Expose
    private Clouds clouds;
    @SerializedName("dt")
    @Expose
    private Integer dt;
    @SerializedName("id")
    @Expose
    private Integer id;
    @SerializedName("name")
    @Expose
    private String name;
    @SerializedName("cod")
    @Expose
    private Integer cod;

    /**
     * No args constructor for use in serialization
     * 
     */
    public Weather() {
    }

    /**
     * 
     * @param id
     * @param dt
     * @param clouds
     * @param coord
     * @param wind
     * @param cod
     * @param sys
     * @param name
     * @param base
     * @param weather
     * @param main
     */
    public Weather(Coord coord, Sys sys, List<Weather_> weather, String base, Main main, Wind wind, Clouds clouds, Integer dt, Integer id, String name, Integer cod) {
        super();
        this.coord = coord;
        this.sys = sys;
        this.weather = weather;
        this.base = base;
        this.main = main;
        this.wind = wind;
        this.clouds = clouds;
        this.dt = dt;
        this.id = id;
        this.name = name;
        this.cod = cod;
    }
    
    public Weather clone() {
		Weather w = new Weather();
		w.coord = this.coord;
		w.sys = this.sys;
		w.weather = this.weather;
		w.base = this.base;
		w.main = this.main;
		w.wind = this.wind;
		w.clouds = this.clouds;
		w.dt = this.dt;
		w.id = this.id;
		w.name = this.name;
		w.cod = this.cod;

		return w;	
    }

    public Coord getCoord() {
        return coord;
    }
    public Double getLatitude() {
    	return coord.getLat();
    }
    public Double getLongitude() {
    	return coord.getLon();
    }

    public void setCoord(Coord coord) {
        this.coord = coord;
    }

    public Sys getSys() {
        return sys;
    }
    public Integer getSunrise() {
    	return sys.getSunrise();
    }
    public Integer getSunset() {
    	return sys.getSunset();
    }

    public void setSys(Sys sys) {
        this.sys = sys;
    }

    public List<Weather_> getWeather() {
        return weather;
    }

    public void setWeather(List<Weather_> weather) {
        this.weather = weather;
    }

    public String getBase() {
        return base;
    }

    public void setBase(String base) {
        this.base = base;
    }

    public Main getMain() {
        return main;
    }
    public Double getTempMin() {
    	return main.getTempMin();
    }
    public Double getTempMax() {
    	return main.getTempMax();
    }
    public Integer getHumidity() {
    	return main.getHumidity();
    }
    public Double getCurrentTemperature() {
    	return main.getTemp();
    }

    public void setMain(Main main) {
        this.main = main;
    }

    public Wind getWind() {
        return wind;
    }
    public Double getWindspeed() {
    	return wind.getSpeed();
    }

    public void setWind(Wind wind) {
        this.wind = wind;
    }

    public Clouds getClouds() {
        return clouds;
    }

    public void setClouds(Clouds clouds) {
        this.clouds = clouds;
    }

    public Integer getDt() {
        return dt;
    }

    public void setDt(Integer dt) {
        this.dt = dt;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCod() {
        return cod;
    }

    public void setCod(Integer cod) {
        this.cod = cod;
    }

}
