package ru.agentlab.maia.container.events;

import java.util.HashMap;
import java.util.Map;

import ru.agentlab.maia.container.IContainer;
import ru.agentlab.maia.event.IMaiaEvent;

public class MaiaContextFactoryCreateChildEvent implements IMaiaEvent {

	protected final static String KEY_PARENT_CONTEXT = "context.parent";

	protected final static String KEY_CONTEXT = "context";

	public final static String TOPIC = "ru/agentlab/maia/context/factory/CreateChild";

	private final HashMap<String, Object> data = new HashMap<String, Object>();

	public MaiaContextFactoryCreateChildEvent(final IContainer parentContext, final IContainer context) {
		this.data.put(MaiaContextFactoryCreateChildEvent.KEY_PARENT_CONTEXT, parentContext);
		this.data.put(MaiaContextFactoryCreateChildEvent.KEY_CONTEXT, context);
	}

	@Override
	public String getTopic() {
		return MaiaContextFactoryCreateChildEvent.TOPIC;
	}

	public IContainer getContext() {
		Object _get = this.data.get(MaiaContextFactoryCreateChildEvent.KEY_CONTEXT);
		return ((IContainer) _get);
	}

	public IContainer getParentContext() {
		Object _get = this.data.get(MaiaContextFactoryCreateChildEvent.KEY_PARENT_CONTEXT);
		return ((IContainer) _get);
	}

	public Map<String, Object> getData() {
		return this.data;
	}

}
