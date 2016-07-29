package ru.agentlab.maia.agent;

public class LocalAgentAddress extends AgentAddress {

	private IAgent reference;

	public LocalAgentAddress(IAgent reference) {
		this.reference = reference;
	}

	public IAgent getAgent() {
		return reference;
	}

}
