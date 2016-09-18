package ru.agentlab.maia.container.events;

import java.util.HashMap;
import java.util.Map;

import ru.agentlab.maia.event.IMaiaEvent;

public class MaiaContextInjectorInjectEvent implements IMaiaEvent {

	protected final static String KEY_OBJECT = "object";

	public final static String TOPIC = "ru/agentlab/maia/context/injector/Inject";

	private final HashMap<String, Object> data = new HashMap<String, Object>();

	public MaiaContextInjectorInjectEvent(final Object object) {
		this.data.put(MaiaContextInjectorInjectEvent.KEY_OBJECT, object);
	}

	@Override
	public String getTopic() {
		return MaiaContextInjectorInjectEvent.TOPIC;
	}

	public Object getObject() {
		return this.data.get(MaiaContextInjectorInjectEvent.KEY_OBJECT);
	}

	public Map<String, Object> getData() {
		return this.data;
	}

}
