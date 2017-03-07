package ru.agentlab.maia;

public interface IAgentStateChangeListener {

	void changed(AgentState oldState, AgentState newState);

}
