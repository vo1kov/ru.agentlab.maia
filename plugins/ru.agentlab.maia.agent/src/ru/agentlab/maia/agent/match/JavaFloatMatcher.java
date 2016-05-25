package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

public class JavaFloatMatcher implements IMatcher<Float> {

	float value;

	public JavaFloatMatcher(float value) {
		this.value = value;
	}

	@Override
	public boolean match(Float value, Map<String, Object> map) {
		return this.value == value;
	}

	@Override
	public Class<?> getType() {
		return Float.class;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof JavaFloatMatcher) {
			JavaFloatMatcher other = (JavaFloatMatcher) obj;
			if (Float.isNaN(value) && Float.isNaN(other.value)) {
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
		return "JavaFloatMatcher(" + value + ")";
	}

}
