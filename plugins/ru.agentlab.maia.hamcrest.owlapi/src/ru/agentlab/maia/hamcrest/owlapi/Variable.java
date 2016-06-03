package ru.agentlab.maia.hamcrest.owlapi;

import java.util.Map;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;

public class Variable extends BaseMatcher<Object> {

	private final String name;

	Map<String, Object> values;

	public Variable(String name, Map<String, Object> values) {
		this.name = name;
		this.values = values;
	}

	@Override
	public boolean matches(Object item) {
		Object val = values.get(name);
		if (val != null) {
			// unifier contains value for variable, object should be the same
			return item.equals(val);
		} else {
			values.put(name, item);
			return true;
		}
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("?" + name);

	}

}
