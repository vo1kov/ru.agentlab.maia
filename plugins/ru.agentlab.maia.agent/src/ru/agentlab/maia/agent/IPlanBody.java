package ru.agentlab.maia.agent;

import java.util.Map;

import ru.agentlab.maia.container.IInjector;

@FunctionalInterface
public interface IPlanBody {

	void execute(IInjector injector, Map<String, Object> variables) throws Exception;

}
