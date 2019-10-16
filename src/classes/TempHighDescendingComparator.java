package classes;

import java.util.Comparator;

public class TempHighDescendingComparator implements Comparator<Weather> {

	@Override
	public int compare(Weather w0, Weather w1) {
		return (int) (w1.getTempMax() - w0.getTempMax());
	}

}
