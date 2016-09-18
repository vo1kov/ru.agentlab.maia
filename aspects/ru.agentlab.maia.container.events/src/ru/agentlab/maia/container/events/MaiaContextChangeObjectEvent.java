package ru.agentlab.maia.container.events;

import java.util.HashMap;
import java.util.Map;

import ru.agentlab.maia.event.IMaiaEvent;

public class MaiaContextChangeObjectEvent implements IMaiaEvent {

	protected final static String KEY_FROM_OBJECT = "from.object";

	protected final static String KEY_TO_OBJECT = "to.object";

	public final static String TOPIC = "ru/agentlab/maia/context/ChangeObject";

	private final HashMap<String, Object> data = new HashMap<String, Object>();

	public MaiaContextChangeObjectEvent(final Object fromObject, final Object toObject) {
		this.data.put(MaiaContextChangeObjectEvent.KEY_FROM_OBJECT, fromObject);
		this.data.put(MaiaContextChangeObjectEvent.KEY_TO_OBJECT, toObject);
	}

	@Override
	public String getTopic() {
		return MaiaContextChangeObjectEvent.TOPIC;
	}

	public Object getFromObject() {
		return this.data.get(MaiaContextChangeObjectEvent.KEY_FROM_OBJECT);
	}

	public Object getToObject() {
		return this.data.get(MaiaContextChangeObjectEvent.KEY_TO_OBJECT);
	}

	public Map<String, Object> getData() {
		return this.data;
	}

}
