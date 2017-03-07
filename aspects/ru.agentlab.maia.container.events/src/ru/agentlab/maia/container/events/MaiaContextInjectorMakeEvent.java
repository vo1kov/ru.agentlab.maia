package ru.agentlab.maia.container.events;

import java.util.HashMap;
import java.util.Map;

import ru.agentlab.maia.service.event.IMaiaEvent;

public class MaiaContextInjectorMakeEvent implements IMaiaEvent {
	
	protected final static String KEY_CLASS = "class";

	protected final static String KEY_OBJECT = "object";

	public final static String TOPIC = "ru/agentlab/maia/context/injector/Make";

	private final HashMap<String, Object> data = new HashMap<String, Object>();

	public MaiaContextInjectorMakeEvent(final Class<?> clazz, final Object object) {
		this.data.put(MaiaContextInjectorMakeEvent.KEY_CLASS, clazz);
		this.data.put(MaiaContextInjectorMakeEvent.KEY_OBJECT, object);
	}

	@Override
	public String getTopic() {
		return MaiaContextInjectorMakeEvent.TOPIC;
	}

	public Object getObject() {
		return this.data.get(MaiaContextInjectorMakeEvent.KEY_OBJECT);
	}

	public Object getObjectClass() {
		return this.data.get(MaiaContextInjectorMakeEvent.KEY_CLASS);
	}

	public Map<String, Object> getData() {
		return this.data;
	}
	
}
