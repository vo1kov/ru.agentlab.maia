package ru.agentlab.maia.agent.match;

public interface IMatcher<T> {

	boolean match(T object, IUnifier unifier);

}
