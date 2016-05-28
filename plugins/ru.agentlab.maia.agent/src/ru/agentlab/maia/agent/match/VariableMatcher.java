package ru.agentlab.maia.agent.match;

import java.util.Map;

public class VariableMatcher implements IMatcher<Object> {

	private final String value;

	public VariableMatcher(String value) {
		this.value = value;
	}

	@Override
	public boolean match(Object object, Map<String, Object> map) {
		Object val = map.get(value);
		if (val != null) {
			// unifier contains value for variable, object should be the same
			return object.equals(val);
		} else {
			map.put(value, object);
			return true;
		}
	}

	@Override
	public String toString() {
		return "?" + value;
	}

	@Override
	public Class<Object> getType() {
		return Object.class;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof VariableMatcher) {
			VariableMatcher other = (VariableMatcher) obj;
			boolean result = value.equals(other.value);
			return result;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return value.hashCode();
	}

}
