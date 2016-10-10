package ru.agentlab.maia.fipa;

import javax.inject.Inject;

import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.agent.IRoleBase;
import ru.agentlab.maia.agent.annotation.OnEvent;
import ru.agentlab.maia.agent.event.RoleRemovedEvent;
import ru.agentlab.maia.goal.event.GoalAddedEvent;

public class RoleManager {

	@Inject
	protected IRoleBase roleBase;

	@OnEvent(GoalAddedEvent.class)
	public void onRoleRemoveGoal(GoalAddedEvent event) {
		Object removeRole = event.getPayload();
		if (removeRole instanceof RoleRemovedEvent) {
			IRole role = ((RoleRemovedEvent) removeRole).getPayload();
			roleBase.remove(role);
		}
	}

}
