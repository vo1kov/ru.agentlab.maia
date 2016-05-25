package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

public class JavaBooleanStringMatcher implements IMatcher<String> {

	boolean value;

	public JavaBooleanStringMatcher(boolean value) {
		this.value = value;
	}

	@Override
	public boolean match(String string, Map<String, Object> map) {
		if (string.equalsIgnoreCase("true") || string.equals("1")) {
			return value == true;
		} else if (string.equalsIgnoreCase("false") || string.equals("0")) {
			return value == false;
		} else {
			return false;
		}
	}

	@Override
	public Class<?> getType() {
		return String.class;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof JavaBooleanStringMatcher) {
			JavaBooleanStringMatcher other = (JavaBooleanStringMatcher) obj;
			boolean result = value == other.value;
			return result;
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
		return "JavaStringMatcher(" + value + ")";
	}

}
