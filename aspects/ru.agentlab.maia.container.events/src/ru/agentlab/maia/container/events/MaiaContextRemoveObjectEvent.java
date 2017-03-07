package ru.agentlab.maia.container.events;

import java.util.HashMap;
import java.util.Map;

import ru.agentlab.maia.service.event.IMaiaEvent;

public class MaiaContextRemoveObjectEvent implements IMaiaEvent {
	protected final static String KEY_OBJECT = "object";

	public final static String TOPIC = "ru/agentlab/maia/context/RemoveObject";

	private final HashMap<String, Object> data = new HashMap<String, Object>();

	public MaiaContextRemoveObjectEvent(final Object object) {
		this.data.put(MaiaContextRemoveObjectEvent.KEY_OBJECT, object);
	}

	@Override
	public String getTopic() {
		return MaiaContextRemoveObjectEvent.TOPIC;
	}

	public Object getObject() {
		return this.data.get(MaiaContextRemoveObjectEvent.KEY_OBJECT);
	}

	public Map<String, Object> getData() {
		return this.data;
	}
}
