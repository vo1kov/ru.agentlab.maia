package ru.agentlab.maia.context.event;

import ru.agentlab.maia.context.IMaiaContext;
import ru.agentlab.maia.context.aj.AMaiaContext;
import ru.agentlab.maia.event.IMaiaEventBroker;

public aspect AMaiaContextEvent extends AMaiaContext {

	void around(IMaiaContext context, String id): onRemoveByString(context, id) {
		IMaiaEventBroker broker = context.get(IMaiaEventBroker.class);
		Object old = context.getLocal(id);
		proceed(context, id);
		if (old != null) {
			broker.post(new MaiaContextRemoveObjectEvent(old));
		}
	}

	void around(IMaiaContext context, Class<?> id): onRemoveByClass(context, id) {
		IMaiaEventBroker broker = context.get(IMaiaEventBroker.class);
		Object old = context.getLocal(id);
		proceed(context, id);
		if (old != null) {
			broker.post(new MaiaContextRemoveObjectEvent(old));
		}
	}

	void around(IMaiaContext context, String id, Object value): onSetByString(context, id, value) {
		IMaiaEventBroker broker = context.get(IMaiaEventBroker.class);
		Object old = context.getLocal(id);
		proceed(context, id, value);
		if (old == null) {
			broker.post(new MaiaContextSetObjectEvent(context, value));
		} else {
			broker.post(new MaiaContextChangeObjectEvent(context, value));
		}
	}

	void around(IMaiaContext context, Class<?> id, Object value): onSetByClass(context, id, value) {
		IMaiaEventBroker broker = context.get(IMaiaEventBroker.class);
		Object old = context.getLocal(id);
		proceed(context, id, value);
		if (old == null) {
			broker.post(new MaiaContextSetObjectEvent(context, value));
		} else {
			broker.post(new MaiaContextChangeObjectEvent(context, value));
		}
	}
}