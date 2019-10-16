package classes;

import java.util.Comparator;

public class TempHighAscendingComparator implements Comparator<Weather> {

	@Override
	public int compare(Weather w0, Weather w1) {
		return (int) (w0.getTempMax() - w1.getTempMax());
	}

}	
