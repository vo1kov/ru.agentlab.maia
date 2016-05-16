package ru.agentlab.maia.agent;

import java.util.Queue;

public interface IEventQueue extends Queue<IEvent<?>> {
	
	void allow(EventType type);
	
	void disallow(EventType type);

}
