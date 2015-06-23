package ru.agentlab.maia.context.event;

import ru.agentlab.maia.context.IMaiaContext;
import ru.agentlab.maia.context.aj.AMaiaContext;
import ru.agentlab.maia.event.IMaiaEventBroker;

public aspect AMaiaContextEvent extends AMaiaContext {

	IMaiaEventBroker broker;

	void around(IMaiaContext context, String id): onRemoveByString(context, id) {
		Object old = context.getLocal(id);
		proceed(context, id);
		if (old != null) {
			broker.post(new MaiaContextRemoveObjectEvent(old));
		}
	}
	
	void  around(IMaiaContext context, Class<?> id): onRemoveByClass(context, id) {
		Object old = context.getLocal(id);
		proceed(context, id);
		if (old != null) {
			broker.post(new MaiaContextRemoveObjectEvent(old));
		}
	}

	// after(IMaiaContext parent) returning (IMaiaContext result):
	// onRemoveByString(*, parent, *) {
	// broker.post(new MaiaContextFactoryCreateChildEvent(parent, result));
	// }

//	after() returning (IMaiaContext result): 
//		onCreateContext(*, *) {
//		broker.post(new MaiaContextFactoryCreateEvent(result));
//	}
}