package ru.agentlab.maia.container.events;

import java.util.HashMap;
import java.util.Map;

import ru.agentlab.maia.container.IContainer;
import ru.agentlab.maia.event.IMaiaEvent;

public class MaiaContextFactoryCreateEvent implements IMaiaEvent {

	protected final static String KEY_CONTEXT = "context";

	public final static String TOPIC = "ru/agentlab/maia/context/factory/CreateContext";

	private final HashMap<String, Object> data = new HashMap<String, Object>();

	public MaiaContextFactoryCreateEvent(final IContainer context) {
		this.data.put(MaiaContextFactoryCreateEvent.KEY_CONTEXT, context);
	}

	@Override
	public String getTopic() {
		return MaiaContextFactoryCreateEvent.TOPIC;
	}

	public IContainer getContext() {
		Object _get = this.data.get(MaiaContextFactoryCreateEvent.KEY_CONTEXT);
		return ((IContainer) _get);
	}

	public Map<String, Object> getData() {
		return this.data;
	}

}
