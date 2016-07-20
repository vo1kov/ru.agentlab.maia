package ru.agentlab.maia.agent;

import static org.hamcrest.Matchers.anything;
import static ru.agentlab.maia.agent.EventMatchers.hamcrest;

import java.lang.reflect.Method;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IStateMatcher;

public class Plans {

	public static IPlan create(Object role, Runnable runnable, IEventMatcher eventMatcher, IStateMatcher stateMatcher) {
		return null;
	}

	public static IPlan create(Object role, Runnable runnable, IEventMatcher eventMatcher) {
		return null;
	}

	public static IPlan create(Object role, Runnable runnable) {
		return create(role, runnable, hamcrest(anything()));
	}

	public static IPlan create(Object role, Method method, IEventMatcher eventMatcher, IStateMatcher stateMatcher) {
		return null;
	}

	public static IPlan create(Object role, Method method, IEventMatcher eventMatcher) {
		return null;
	}

	public static IPlan create(Object role, Method method) {
		return create(role, method, hamcrest(anything()));
	}

}
