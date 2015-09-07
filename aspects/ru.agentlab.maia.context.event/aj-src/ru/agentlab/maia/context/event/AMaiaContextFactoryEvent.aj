package ru.agentlab.maia.context.event;

import ru.agentlab.maia.event.IMaiaEventBroker;
import ru.agentlab.maia.memory.IMaiaContext;
import ru.agentlab.maia.memory.IMaiaContextFactory;
import ru.agentlab.maia.memory.aj.AMaiaContextFactory;

public aspect AMaiaContextFactoryEvent extends AMaiaContextFactory {

	after(IMaiaContextFactory factory) returning (IMaiaContext result): 
		onCreateContext(factory) {
		IMaiaEventBroker broker = result.get(IMaiaEventBroker.class);
		broker.post(new MaiaContextFactoryCreateChildEvent(result.getParent(), result));
	}

	after() returning (IMaiaContext result): 
		onCreateContext(*) {
		IMaiaEventBroker broker = result.get(IMaiaEventBroker.class);
		broker.post(new MaiaContextFactoryCreateEvent(result));
	}
}