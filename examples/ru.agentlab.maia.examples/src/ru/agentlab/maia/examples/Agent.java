/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.inject.Named;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyManager;

import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.annotation.BeliefDataPropertyAdded;
import ru.agentlab.maia.annotation.HaveBelief;
import ru.agentlab.maia.annotation.MessageAdded;
import ru.agentlab.maia.annotation.Optional;
import ru.agentlab.maia.annotation.Prefix;
import ru.agentlab.maia.annotation.RoleAdded;
import ru.agentlab.maia.messaging.IMessageDeliveryService;

@Prefix(name = "rdf", namespace = "http://www.w3.org/1999/02/22-rdf-syntax-ns")
public class Agent {

	@Inject
	OWLOntologyManager manager = OWLManager.createOWLOntologyManager();

	OWLDataFactory factory = manager.getOWLDataFactory();

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
	@Optional
	@Named("http://www.w3.org/2001/vcard-rdf/3.0")
	OWLOntology ontology;

	@Inject
	IMessageDeliveryService messaging;

	@PostConstruct
	public void setup() {
		beliefBase.addClassAssertion("test", "SDfsdf");
		OWLClass clazz = factory.getOWLClass(IRI.create(""));
		OWLIndividual individual = factory.getOWLNamedIndividual(IRI.create(""));
		desireBase.addGoalClassAsertion(factory.getOWLClassAssertionAxiom(clazz, individual));
	}

	@BeliefDataPropertyAdded("?classified rdf:type ?classifier")
	@HaveBelief("?classifier ?b ?c")
	public void onSomeClassified() {

	}

	@BeliefDataPropertyAdded("?classified rdf:type ?classifier")
	@HaveBelief("?classifier ?b ?c")
	public void onSomeClassifiedw() {

	}

	@MessageAdded(performative = "INFO")
	public void sdf() {

	}

	@RoleAdded(HelloWorld.class)
	public void onHelloWorldAdded() {
	}

}
