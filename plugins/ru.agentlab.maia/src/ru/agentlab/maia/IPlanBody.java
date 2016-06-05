package ru.agentlab.maia;

import java.util.Map;

public interface IPlanBody {

	void execute(IInjector injector, Map<String, Object> variables) throws Exception;

}
