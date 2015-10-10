package ru.agentlab.maia.context.events;

import ru.agentlab.maia.context.IContext;
import ru.agentlab.maia.context.exception.MaiaContextKeyNotFound;
import ru.agentlab.maia.event.IMaiaEventBroker;

public aspect AContextEvents extends AContext {

	void around(IContext context, String id): onRemoveByString(context, id) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.getService(IMaiaEventBroker.class);
			old = context.getServiceLocal(id);
		} catch (MaiaContextKeyNotFound e) {
		}

		proceed(context, id);

		if (broker != null) {
			if (old != null) {
				broker.post(new MaiaContextRemoveObjectEvent(old));
			}
		}
	}

	void around(IContext context, Class<?> id): onRemoveByClass(context, id) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.getService(IMaiaEventBroker.class);
			old = context.getServiceLocal(id);
		} catch (MaiaContextKeyNotFound e) {
		}

		proceed(context, id);

		if (broker != null) {
			if (old != null) {
				broker.post(new MaiaContextRemoveObjectEvent(old));
			}
		}
	}

	void around(IContext context, String id, Object value): onSetByString(context, id, value) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.getService(IMaiaEventBroker.class);
			old = context.getServiceLocal(id);
		} catch (MaiaContextKeyNotFound e) {
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

	void around(IContext context, Class<?> id, Object value): onSetByClass(context, id, value) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.getService(IMaiaEventBroker.class);
			old = context.getServiceLocal(id);
		} catch (MaiaContextKeyNotFound e) {
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