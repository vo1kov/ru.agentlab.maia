package ru.agentlab.maia.agent.match;

import java.util.Map;

public class JavaAnyMatcher implements IMatcher<Object> {

	static JavaAnyMatcher instance = new JavaAnyMatcher();

	public static JavaAnyMatcher getInstance() {
		return instance;
	}

	private JavaAnyMatcher() {
		super();
	}

	@Override
	public boolean match(Object string, Map<String, Object> map) {
		return true;
	}

	@Override
	public Class<Object> getType() {
		return Object.class;
	}

	@Override
	public String toString() {
		return "[any]";
	}

}
