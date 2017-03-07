package ru.agentlab.maia.organization;

import java.util.Collection;

public class Protocol implements IProtocol {
	private IRole initiator;

	private Collection<IProtocolParticipant> participants;

	private String ontology;

	private String language;

	private String label;

	public IRole getInitiator() {
		return this.initiator;
	}

	public void setInitiator(final IRole initiator) {
		this.initiator = initiator;
	}

	public Collection<IProtocolParticipant> getParticipants() {
		return this.participants;
	}

	public void setParticipants(final Collection<IProtocolParticipant> participants) {
		this.participants = participants;
	}

	public String getOntology() {
		return this.ontology;
	}

	public void setOntology(final String ontology) {
		this.ontology = ontology;
	}

	public String getLanguage() {
		return this.language;
	}

	public void setLanguage(final String language) {
		this.language = language;
	}

	public String getLabel() {
		return this.label;
	}

	public void setLabel(final String label) {
		this.label = label;
	}
}
