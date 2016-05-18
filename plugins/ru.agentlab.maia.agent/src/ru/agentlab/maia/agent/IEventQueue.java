package ru.agentlab.maia.agent;

import java.util.Queue;

import ru.agentlab.maia.IEvent;

public interface IEventQueue extends Queue<IEvent<?>> {
	
	void allow(Class<? extends IEvent<?>> type);
	
	void disallow(Class<? extends IEvent<?>> type);

}
