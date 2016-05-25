package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

public class JavaDoubleMatcher implements IMatcher<Double> {

	double value;

	public JavaDoubleMatcher(double value) {
		this.value = value;
	}

	@Override
	public boolean match(Double value, Map<String, Object> map) {
		return this.value == value;
	}

	@Override
	public Class<?> getType() {
		return Integer.class;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof JavaDoubleMatcher) {
			JavaDoubleMatcher other = (JavaDoubleMatcher) obj;
			if (Double.isNaN(value) && Double.isNaN(other.value)) {
				return true;
			}
			return value == other.value;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(value);
	}

	@Override
	public String toString() {
		return "JavaDoubleMatcher(" + value + ")";
	}

}
