package ru.agentlab.maia.agent;

import java.net.SocketAddress;

public class RemoteAgentAddress extends AgentAddress {

	private SocketAddress address;

	public RemoteAgentAddress(SocketAddress address) {
		this.address = address;
	}

	public SocketAddress getAddress() {
		return address;
	}

}
