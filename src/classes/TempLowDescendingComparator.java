package classes;

import java.util.Comparator;

public class TempLowDescendingComparator implements Comparator<Weather> {

	@Override
	public int compare(Weather w0, Weather w1) {
		return (int) (w1.getTempMin() - w0.getTempMin());
	}
	
}
