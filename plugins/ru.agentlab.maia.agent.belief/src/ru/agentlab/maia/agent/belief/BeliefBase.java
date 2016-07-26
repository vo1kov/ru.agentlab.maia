/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.belief;

import java.util.Queue;
import java.util.Set;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyChangeListener;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.reasoner.structural.StructuralReasonerFactory;

import de.derivo.sparqldlapi.QueryEngine;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.agent.belief.event.BeliefAddedEvent;
import ru.agentlab.maia.agent.belief.event.BeliefRemovedEvent;

public class BeliefBase implements IBeliefBase {

	@Inject
	private OWLOntologyManager manager;

	@Inject
	private OWLDataFactory factory;

	@Inject
	private UUID uuid;

	private OWLOntology ontology;

	private QueryEngine engine;

	private OWLOntologyChangeListener listener;

	@PostConstruct
	public void init(Queue<IEvent<?>> eventQueue) throws OWLOntologyCreationException {
		ontology = manager.createOntology(IRI.create(uuid.toString()));
		engine = QueryEngine.create(manager, (new StructuralReasonerFactory()).createReasoner(ontology), true);
		if (listener != null) {
			manager.removeOntologyChangeListener(listener);
		}
		listener = changes -> {
			changes.forEach(change -> {
				if (change.getOntology() == ontology) {
					OWLAxiom axiom = change.getAxiom();
					if (change.isAddAxiom()) {
						eventQueue.offer(new BeliefAddedEvent(axiom));
					} else if (change.isRemoveAxiom()) {
						eventQueue.offer(new BeliefRemovedEvent(axiom));
					}
				}
			});
		};
		manager.addOntologyChangeListener(listener);
	}

	@Override
	public void addBelief(OWLAxiom axiom) {
		manager.addAxiom(ontology, axiom);
	}
	
	@Override
	public void addBeliefs(Set<OWLAxiom> axioms) {
		manager.addAxioms(ontology, axioms);
	}

	@Override
	public void removeBelief(OWLAxiom axiom) {
		manager.removeAxiom(ontology, axiom);
	}
	
	@Override
	public void removeBeliefs(Set<OWLAxiom> axioms) {
		manager.removeAxioms(ontology, axioms);
	}

	@Override
	public boolean containsBelief(OWLAxiom axiom) {
		return ontology.containsAxiom(axiom);
	}

	@Override
	public QueryEngine getQueryEngine() {
		return engine;
	}

	@Override
	public OWLOntologyManager getManager() {
		return manager;
	}

	@Override
	public OWLDataFactory getFactory() {
		return factory;
	}

	@Override
	public OWLOntology getOntology() {
		return ontology;
	}

}
