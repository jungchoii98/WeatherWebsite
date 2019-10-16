package classes;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class parsedJson {
	public static ArrayList<WeatherObjects> wobs;
	
	public static void parse() throws FileNotFoundException {
		//Use gson to parse the json
		BufferedReader br = new BufferedReader(new FileReader("/Users/jungchoi/Desktop/csci201/city.list.json"));
		Gson gson = new Gson();
		TypeToken<ArrayList<WeatherObjects>> token = new TypeToken<ArrayList<WeatherObjects>>() {};
		wobs = gson.fromJson(br, token.getType());
	}
}
