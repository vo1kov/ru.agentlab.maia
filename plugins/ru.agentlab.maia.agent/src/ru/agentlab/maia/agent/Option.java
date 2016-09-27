package ru.agentlab.maia.agent;

import java.util.Map;

public class Option {
	
	IPlan<?> plan;
	
	Map<String, Object> values;

	public Option(IPlan<?> plan, Map<String, Object> values) {
		super();
		this.plan = plan;
		this.values = values;
	}

	public IPlan<?> getPlan() {
		return plan;
	}

	public Map<String, Object> getValues() {
		return values;
	}

}
