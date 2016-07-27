package ru.agentlab.maia.agent;

import java.util.Map;

public class Option {
	
	IPlanBody planBody;
	
	Map<String, Object> values;

	public Option(IPlanBody plan, Map<String, Object> values) {
		super();
		this.planBody = plan;
		this.values = values;
	}

	public IPlanBody getPlanBody() {
		return planBody;
	}

	public Map<String, Object> getValues() {
		return values;
	}

}
