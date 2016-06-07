package ru.agentlab.maia.agent;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBody;
import ru.agentlab.maia.IPlanFilter;

public class Plan implements IPlan {

	IPlanFilter planFilter;

	IPlanBody planBody;

	protected final Object role;

	public Plan(Object role, IPlanFilter planFilter, IPlanBody planBody) {
		this.role = role;
		this.planFilter = planFilter;
		this.planBody = planBody;
	}

	@Override
	public IPlanBody getPlanBody() {
		return planBody;
	}

	@Override
	public IPlanFilter getPlanFilter() {
		return planFilter;
	}

	@Override
	public Object getRole() {
		return role;
	}

}