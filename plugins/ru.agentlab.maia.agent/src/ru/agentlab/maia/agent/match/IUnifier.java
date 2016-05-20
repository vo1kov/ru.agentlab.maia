package ru.agentlab.maia.agent.match;

public interface IUnifier {

	Object get(String key);

	Object put(String key, Object value);

	void remove(String value);

}
