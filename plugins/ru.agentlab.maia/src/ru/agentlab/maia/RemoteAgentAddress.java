package ru.agentlab.maia;

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
