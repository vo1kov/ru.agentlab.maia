package ru.agentlab.maia.service.message.fipa;

import java.util.UUID;

public class AllowAllAgentFilter implements IAgentFilter {

	@Override
	public boolean match(UUID uuid) {
		return true;
	}

}
