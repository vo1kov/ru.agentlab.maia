package ru.agentlab.maia.container.events;

import ru.agentlab.maia.container.events.MaiaContextChangeObjectEvent;
import ru.agentlab.maia.container.events.MaiaContextRemoveObjectEvent;
import ru.agentlab.maia.container.events.MaiaContextSetObjectEvent;
import ru.agentlab.maia.event.IMaiaEventBroker;
import ru.agentlab.maia.exception.ServiceNotFound;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.container.aspect.AContext;

public aspect AContextEvents extends AContext {

	void around(IContainer context, String id): onRemoveByString(context, id) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.get(IMaiaEventBroker.class);
			old = context.getLocal(id);
		} catch (ServiceNotFound e){
		}

		proceed(context, id);

		if (broker != null) {
			if (old != null) {
				broker.post(new MaiaContextRemoveObjectEvent(old));
			}
		}
	}

	void around(IContainer context, Class<?> id): onRemoveByClass(context, id) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.get(IMaiaEventBroker.class);
			old = context.getLocal(id);
		} catch (ServiceNotFound e){
		}

		proceed(context, id);

		if (broker != null) {
			if (old != null) {
				broker.post(new MaiaContextRemoveObjectEvent(old));
			}
		}
	}

	void around(IContainer context, String id, Object value): onSetByString(context, id, value) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.get(IMaiaEventBroker.class);
			old = context.getLocal(id);
		} catch (ServiceNotFound e){
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

	void around(IContainer context, Class<?> id, Object value): onSetByClass(context, id, value) {
		IMaiaEventBroker broker = null;
		Object old = null;
		try {
			broker = context.get(IMaiaEventBroker.class);
			old = context.getLocal(id);
		} catch (ServiceNotFound e){
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