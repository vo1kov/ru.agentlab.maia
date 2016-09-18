package ru.agentlab.maia.container.events;

import java.util.HashMap;
import java.util.Map;

import ru.agentlab.maia.container.IContainer;
import ru.agentlab.maia.event.IMaiaEvent;

public class MaiaContextSetObjectEvent implements IMaiaEvent {
	protected final static String KEY_CONTEXT = "context";

	protected final static String KEY_OBJECT = "object";

	public final static String TOPIC = "ru/agentlab/maia/context/SetObject";

	private final HashMap<String, Object> data = new HashMap<String, Object>();

	public MaiaContextSetObjectEvent(final IContainer context, final Object object) {
		this.data.put(MaiaContextSetObjectEvent.KEY_CONTEXT, context);
		this.data.put(MaiaContextSetObjectEvent.KEY_OBJECT, object);
	}

	@Override
	public String getTopic() {
		return MaiaContextSetObjectEvent.TOPIC;
	}

	public IContainer getContext() {
		Object _get = this.data.get(MaiaContextSetObjectEvent.KEY_CONTEXT);
		return ((IContainer) _get);
	}

	public Object getObject() {
		return this.data.get(MaiaContextSetObjectEvent.KEY_OBJECT);
	}

	public Map<String, Object> getData() {
		return this.data;
	}
}
