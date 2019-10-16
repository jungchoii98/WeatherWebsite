package classes;

import java.util.Comparator;

public class CityNameAscendingComparator implements Comparator<Weather> {

	@Override
	public int compare(Weather w0, Weather w1) {
		return w0.getName().compareTo(w1.getName());
	}

}
