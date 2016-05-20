package ru.agentlab.maia.agent.match;

public class JavaClassMatcher implements IMatcher<Class<?>> {

	Class<?> value;

	public JavaClassMatcher(Class<?> clazz) {
		this.value = clazz;
	}

	@Override
	public boolean match(Class<?> clazz, IUnifier unifier) {
		return clazz == value;
	}

}
