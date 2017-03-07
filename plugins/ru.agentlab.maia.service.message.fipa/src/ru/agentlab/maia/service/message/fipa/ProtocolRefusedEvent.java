package ru.agentlab.maia.service.message.fipa;

import ru.agentlab.maia.Event;
import ru.agentlab.maia.IRole;

public class ProtocolRefusedEvent extends Event<IRole> {

	public ProtocolRefusedEvent(IRole payload) {
		super(payload);
	}

}
