package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

public class JavaIntegerMatcher implements IMatcher<Integer> {

	int value;

	public JavaIntegerMatcher(int value) {
		this.value = value;
	}

	@Override
	public boolean match(Integer value, Map<String, Object> map) {
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
		if (obj instanceof JavaIntegerMatcher) {
			JavaIntegerMatcher other = (JavaIntegerMatcher) obj;
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
		return "JavaIntegerMatcher(" + value + ")";
	}

}
