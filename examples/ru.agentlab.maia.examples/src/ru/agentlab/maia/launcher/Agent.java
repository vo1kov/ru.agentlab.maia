/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.launcher;

import static ru.agentlab.maia.CheckType.AGENT_HAVE_BELIEF;
import static ru.agentlab.maia.CheckType.MESSAGE_HAVE_PERFORMATIVE;
import static ru.agentlab.maia.EventType.AGENT_BELIEF_ADDED;
import static ru.agentlab.maia.EventType.AGENT_MESSAGE_ADDED;
import static ru.agentlab.maia.EventType.CONTAINER_SERVICE_ADDED;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.inject.Named;

import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.annotation.Filter;
import ru.agentlab.maia.annotation.Prefix;
import ru.agentlab.maia.annotation.Trigger;
import ru.agentlab.maia.messaging.IMessageDeliveryService;

@Prefix(name="rdf", namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns")
public class Agent {

	@Inject
	IInjector container;

	@Inject
	IBeliefBase beliefBase;

	@Inject
	IGoalBase desireBase;

	@Inject
	@Named("Namespace")
	String namespace;

	@Inject
	@Named("http://www.w3.org/2001/vcard-rdf/3.0")
	OWLOntology ontology;

	@Inject
	IMessageDeliveryService messaging;

	@PostConstruct
	public void setup() {
		beliefBase.addClassAssertion("test", "SDfsdf");
		desireBase.addGoal("init");
	}

	@Trigger(type = AGENT_BELIEF_ADDED, template = "?classified rdf:type ?classifier")
	@Filter(type = AGENT_HAVE_BELIEF, template = "?classified rdf:type ?classifier")
	@Filter(type = AGENT_HAVE_BELIEF, template = "?classifier ?b ?c")
	@Filter(type = AGENT_HAVE_BELIEF, template = "?classifier ?b ?c")
	public void onSomeClassified() {

	}
	
	@Trigger(type = AGENT_BELIEF_ADDED, template = "?classified rdf:type ?classifier")
	@Filter(type = AGENT_HAVE_BELIEF, template = "?classified rdf:type ?classifier")
	@Filter(type = AGENT_HAVE_BELIEF, template = "?classifier ?b ?c")
	public void onSomeClassifiedw() {

	}

	@Trigger(type = AGENT_MESSAGE_ADDED)
	@Filter(type = MESSAGE_HAVE_PERFORMATIVE, template = "INFO")
	public void sdf() {

	}

	@Trigger(type = CONTAINER_SERVICE_ADDED, template = "ru.agentlab.maia.messaging.IMessageDeliveryService")
	@Filter(type = AGENT_HAVE_BELIEF, template = "?classifier ?b ?c")
	@Filter(type = AGENT_HAVE_BELIEF, template = "?classifier ?b ?c")
	public void destroy() {
		// messaging.send("Good Buy");
	}

}
