package ru.agentlab.maia.service.event.osgi;

import org.osgi.service.event.Event;
import org.osgi.service.event.EventHandler;

import ru.agentlab.maia.service.event.IMaiaEvent;
import ru.agentlab.maia.service.event.IMaiaEventHandler;

public class OsgiEventHandler implements EventHandler {

	private IMaiaEventHandler handler;

	public OsgiEventHandler(final IMaiaEventHandler handler) {
		this.handler = handler;
	}

	@Override
	public void handleEvent(final Event event) {
		if ((event instanceof OsgiEvent)) {
			IMaiaEvent _event = ((OsgiEvent) event).getEvent();
			this.handler.handle(_event);
		} else {
			throw new IllegalStateException();
		}
	}

	public IMaiaEventHandler getHandler() {
		return this.handler;
	}

	public void setHandler(final IMaiaEventHandler handler) {
		this.handler = handler;
	}

}
