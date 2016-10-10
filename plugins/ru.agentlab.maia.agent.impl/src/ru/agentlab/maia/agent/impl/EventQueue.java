package ru.agentlab.maia.agent.impl;

import java.util.concurrent.ConcurrentLinkedQueue;

import ru.agentlab.maia.agent.AgentState;

public class EventQueue<T> extends ConcurrentLinkedQueue<T> {

	private static final long serialVersionUID = 1L;
	
	private Agent agent;

	public EventQueue(Agent agent) {
		this.agent = agent;
	}

	@Override
	public boolean offer(T e) {

		boolean started = agent.state.compareAndSet(AgentState.WAITING, AgentState.ACTIVE);
		if (started) {
			agent.executor.submit(agent.new ExecuteAction());
		}
		return super.offer(e);
	}

}