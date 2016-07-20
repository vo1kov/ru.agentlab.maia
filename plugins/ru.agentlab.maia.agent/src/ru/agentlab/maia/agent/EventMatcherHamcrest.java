package ru.agentlab.maia.agent;

import java.util.Map;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IEventMatcher;

public class EventMatcherHamcrest implements IEventMatcher {

	Matcher<?> matcher;

	public EventMatcherHamcrest(Matcher<?> matcher) {
		this.matcher = matcher;
	}

	@Override
	public boolean matches(Object event, Map<String, Object> values) {
		return matcher.matches(event);
	}

}
