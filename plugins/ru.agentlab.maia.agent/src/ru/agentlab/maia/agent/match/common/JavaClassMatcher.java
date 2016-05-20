package ru.agentlab.maia.agent.match.common;

import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.Match;

public class JavaClassMatcher implements IMatcher<Class<?>> {

	Class<?> value;

	public JavaClassMatcher(Class<?> clazz) {
		this.value = clazz;
	}

	public IMatch match(Class<?> clazz) {
		if (clazz == value) {
			return new Match();
		} else {
			return null;
		}
	}

}
