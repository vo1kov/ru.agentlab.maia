package ru.agentlab.maia.context.event;

import ru.agentlab.maia.context.IMaiaContext;
import ru.agentlab.maia.context.aj.AMaiaContextFactory;
import ru.agentlab.maia.event.IMaiaEventBroker;

public aspect AMaiaContextFactoryEvent extends AMaiaContextFactory {

	after(IMaiaContext parent) returning (IMaiaContext result): 
		onCreateChildContext(*, parent, *) {
		IMaiaEventBroker broker = result.get(IMaiaEventBroker.class);
		broker.post(new MaiaContextFactoryCreateChildEvent(parent, result));
	}

	after() returning (IMaiaContext result): 
		onCreateContext(*, *) {
		IMaiaEventBroker broker = result.get(IMaiaEventBroker.class);
		broker.post(new MaiaContextFactoryCreateEvent(result));
	}
}