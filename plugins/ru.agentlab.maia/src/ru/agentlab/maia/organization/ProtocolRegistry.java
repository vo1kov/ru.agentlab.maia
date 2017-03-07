package ru.agentlab.maia.organization;

import java.util.ArrayList;

public class ProtocolRegistry {

	private final ArrayList<IProtocol> protocols = new ArrayList<IProtocol>();

	public ArrayList<IProtocol> getProtocols() {
		return this.protocols;
	}

}
