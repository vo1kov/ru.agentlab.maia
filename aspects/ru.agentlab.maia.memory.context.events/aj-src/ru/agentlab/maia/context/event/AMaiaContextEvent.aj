package ru.agentlab.maia.context.event;

import ru.agentlab.maia.event.IMaiaEventBroker;
import ru.agentlab.maia.memory.IMaiaContext;
import ru.agentlab.maia.memory.aj.AMaiaContext;
import ru.agentlab.maia.memory.exception.MaiaContextKeyNotFound;

public aspect AMaiaContextEvent extends AMaiaContext {

	void around(IMaiaContext context, String id): onRemoveByString(context, id) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.getService(IMaiaEventBroker.class);
			old = context.getServiceLocal(id);
		} catch (IllegalArgumentException | ClassCastException | MaiaContextKeyNotFound e) {
		}

		proceed(context, id);

		if (broker != null) {
			if (old != null) {
				broker.post(new MaiaContextRemoveObjectEvent(old));
			}
		}
	}

	void around(IMaiaContext context, Class<?> id): onRemoveByClass(context, id) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.getService(IMaiaEventBroker.class);
			old = context.getServiceLocal(id);
		} catch (IllegalArgumentException | ClassCastException | MaiaContextKeyNotFound e) {
		}

		proceed(context, id);

		if (broker != null) {
			if (old != null) {
				broker.post(new MaiaContextRemoveObjectEvent(old));
			}
		}
	}

	void around(IMaiaContext context, String id, Object value): onSetByString(context, id, value) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.getService(IMaiaEventBroker.class);
			old = context.getServiceLocal(id);
		} catch (IllegalArgumentException | ClassCastException | MaiaContextKeyNotFound e) {
		}

		proceed(context, id, value);

		if (broker != null) {
			if (old == null) {
				broker.post(new MaiaContextSetObjectEvent(context, value));
			} else {
				broker.post(new MaiaContextChangeObjectEvent(context, value));
			}
		}
	}

	void around(IMaiaContext context, Class<?> id, Object value): onSetByClass(context, id, value) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.getService(IMaiaEventBroker.class);
			old = context.getServiceLocal(id);
		} catch (IllegalArgumentException | ClassCastException | MaiaContextKeyNotFound e) {
		}

		proceed(context, id, value);

		if (broker != null) {
			if (old == null) {
				broker.post(new MaiaContextSetObjectEvent(context, value));
			} else {
				broker.post(new MaiaContextChangeObjectEvent(context, value));
			}
		}
	}
}