package ru.agentlab.maia.agent;

import java.util.Map;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;

public class Variable extends BaseMatcher<Object> {

	private final String name;

	private final Map<String, Object> values;

	public Variable(String name, Map<String, Object> values) {
		this.name = name;
		this.values = values;
	}

	@Override
	public boolean matches(Object item) {
		if (values.containsKey(name)) {
			if (values.get(name) == item) {
				return true;
			} else {
				return false;
			}
		} else {
			values.put(name, item);
			return true;
		}
	}

	@Override
	public void describeTo(Description description) {
		description.appendValue("?" + name);
	}

	public static Matcher<? super Object> var(String name, Map<String, Object> values) {
		return new Variable(name, values);
	}

}
