package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.Event;

public class AddedExternalEvent extends Event<Object> {

	public AddedExternalEvent(Object payload) {
		super(payload);
	}

}
