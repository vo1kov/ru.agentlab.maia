package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.UUID;

public class JavaUUIDMatcher implements IMatcher<UUID> {

	UUID value;

	public JavaUUIDMatcher(UUID clazz) {
		this.value = clazz;
	}

	@Override
	public boolean match(UUID string, Map<String, Object> map) {
		return string.equals(value);
	}

	@Override
	public Class<?> getType() {
		return UUID.class;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof JavaUUIDMatcher) {
			JavaUUIDMatcher other = (JavaUUIDMatcher) obj;
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

	@Override
	public String toString() {
		return "JavaStringMatcher(" + value + ")";
	}

}
