package ru.agentlab.maia.event.osgi;

import org.osgi.service.event.Event;

import ru.agentlab.maia.event.IMaiaEvent;

public class OsgiEvent extends Event {

	private IMaiaEvent event;

	public OsgiEvent(final IMaiaEvent event) {
		super(event.getTopic(), event.getData());
		this.event = event;
	}

	public IMaiaEvent getEvent() {
		return this.event;
	}

	public void setEvent(final IMaiaEvent event) {
		this.event = event;
	}

}
