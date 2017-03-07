package ru.agentlab.maia.service.message.fipa;

import java.util.UUID;

public interface IAgentFilter {
	
	boolean match(UUID uuid);

}
