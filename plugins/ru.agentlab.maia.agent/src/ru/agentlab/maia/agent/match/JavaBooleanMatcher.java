package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

public class JavaBooleanMatcher implements IMatcher<Boolean> {

	boolean value;

	public JavaBooleanMatcher(boolean value) {
		this.value = value;
	}

	@Override
	public boolean match(Boolean value, Map<String, Object> map) {
		return this.value == value;
	}

	@Override
	public Class<Boolean> getType() {
		return Boolean.class;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof JavaBooleanMatcher) {
			JavaBooleanMatcher other = (JavaBooleanMatcher) obj;
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
		return "JavaBooleanMatcher(" + value + ")";
	}

}
