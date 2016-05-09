/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDeclarationAxiom;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyChange;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.util.OWLEntityRemover;

import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IEventQueue;

public class BeliefBase implements IBeliefBase {

	@Inject
	OWLOntologyManager manager = OWLManager.createOWLOntologyManager();

	OWLDataFactory factory = manager.getOWLDataFactory();

	IEventQueue eventBase;

	boolean onAddIndividual = false;
	boolean onAddClass = false;
	boolean onRemoveIndividual = false;

	private final IRI ontologyIRI;

	OWLOntology ontology;

	public BeliefBase(String namespace) throws OWLOntologyCreationException {
		ontologyIRI = IRI.create(namespace);
		ontology = manager.createOntology(ontologyIRI);
		manager.addOntologyChangeListener(changes -> {
			changes.forEach(change -> {

			});
			// if (onAddIndividual) {
			// eventBase.offer(new Event(this,
			// EventType.AGENT_BELIEF_CLASS_ASSERTION_ADDED, classAssertion));
			// }
		}, (listener, changes) -> {
			List<? extends OWLOntologyChange> filtered = changes.stream()
					.filter(change -> change.getOntology() == ontology).collect(Collectors.toList());
			listener.ontologiesChanged(filtered);
		});
	}

	@Override
	public void addClassDeclaration(String object) {
		OWLClass clazz = factory.getOWLClass(IRI.create(object));
		OWLDeclarationAxiom declarationAxiom = factory.getOWLDeclarationAxiom(clazz);
		manager.addAxiom(ontology, declarationAxiom);
	}

	@Override
	public void addIndividualDeclaration(String object) {
		OWLNamedIndividual individual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLDeclarationAxiom declarationAxiom = factory.getOWLDeclarationAxiom(individual);
		manager.addAxiom(ontology, declarationAxiom);
	}

	@Override
	public void addClassAssertion(String object, String subject) {
		OWLNamedIndividual individual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLClass clazz = factory.getOWLClass(IRI.create(subject));
		OWLClassAssertionAxiom classAssertion = factory.getOWLClassAssertionAxiom(clazz, individual);
		manager.addAxiom(ontology, classAssertion);
	}

	@Override
	public void addObjectPropertyAssertion(String object, String predicate, String subject) {
		OWLNamedIndividual objectIndividual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLNamedIndividual subjectIndividual = factory.getOWLNamedIndividual(IRI.create(subject));
		OWLObjectProperty predicateProperty = factory.getOWLObjectProperty(IRI.create(predicate));
		OWLObjectPropertyAssertionAxiom propertyAssertion = factory
				.getOWLObjectPropertyAssertionAxiom(predicateProperty, objectIndividual, subjectIndividual);
		manager.addAxiom(ontology, propertyAssertion);
	}

	@Override
	public void addDataPropertyAssertion(String object, String predicate, String subject) {
		OWLNamedIndividual objectIndividual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLDataProperty predicateProperty = factory.getOWLDataProperty(IRI.create(predicate));
		OWLDataPropertyAssertionAxiom propertyAssertion = factory.getOWLDataPropertyAssertionAxiom(predicateProperty,
				objectIndividual, subject);
		manager.addAxiom(ontology, propertyAssertion);
	}

	@Override
	public void addDataPropertyAssertion(String object, String predicate, boolean subject) {
		OWLNamedIndividual objectIndividual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLDataProperty predicateProperty = factory.getOWLDataProperty(IRI.create(predicate));
		OWLDataPropertyAssertionAxiom propertyAssertion = factory.getOWLDataPropertyAssertionAxiom(predicateProperty,
				objectIndividual, subject);
		manager.addAxiom(ontology, propertyAssertion);
	}

	@Override
	public void addDataPropertyAssertion(String object, String predicate, double subject) {
		OWLNamedIndividual objectIndividual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLDataProperty predicateProperty = factory.getOWLDataProperty(IRI.create(predicate));
		OWLDataPropertyAssertionAxiom propertyAssertion = factory.getOWLDataPropertyAssertionAxiom(predicateProperty,
				objectIndividual, subject);
		manager.addAxiom(ontology, propertyAssertion);
	}

	@Override
	public void addDataPropertyAssertion(String object, String predicate, float subject) {
		OWLNamedIndividual objectIndividual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLDataProperty predicateProperty = factory.getOWLDataProperty(IRI.create(predicate));
		OWLDataPropertyAssertionAxiom propertyAssertion = factory.getOWLDataPropertyAssertionAxiom(predicateProperty,
				objectIndividual, subject);
		manager.addAxiom(ontology, propertyAssertion);
	}

	@Override
	public void addDataPropertyAssertion(String object, String predicate, int subject) {
		OWLNamedIndividual objectIndividual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLDataProperty predicateProperty = factory.getOWLDataProperty(IRI.create(predicate));
		OWLDataPropertyAssertionAxiom propertyAssertion = factory.getOWLDataPropertyAssertionAxiom(predicateProperty,
				objectIndividual, subject);
		manager.addAxiom(ontology, propertyAssertion);
	}

	@Override
	public void removeClassDeclaration(String object) {
		OWLClass clazz = factory.getOWLClass(IRI.create(object));
		Set<OWLOntology> ontologies = new HashSet<>();
		ontologies.add(ontology);
		OWLEntityRemover remover = new OWLEntityRemover(ontologies);
		clazz.accept(remover);
		manager.applyChanges(remover.getChanges());
		remover.reset();
	}

	@Override
	public void removeIndividualDeclaration(String object) {
		OWLNamedIndividual individual = factory.getOWLNamedIndividual(IRI.create(object));
		Set<OWLOntology> ontologies = new HashSet<>();
		ontologies.add(ontology);
		OWLEntityRemover remover = new OWLEntityRemover(ontologies);
		individual.accept(remover);
		manager.applyChanges(remover.getChanges());
		remover.reset();
	}

	@Override
	public void removeClassAssertion(String object, String subject) {
		OWLNamedIndividual individual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLClass clazz = factory.getOWLClass(IRI.create(subject));
		OWLClassAssertionAxiom classAssertion = factory.getOWLClassAssertionAxiom(clazz, individual);
		manager.removeAxiom(ontology, classAssertion);

	}

	@Override
	public void removeObjectPropertyAssertion(String object, String predicate, String subject) {
		// TODO Auto-generated method stub

	}

	@Override
	public void removeDataPropertyAssertion(String object, String predicate, String subject) {
		// TODO Auto-generated method stub

	}

	@Override
	public void removeDataPropertyAssertion(String object, String predicate, boolean subject) {
		// TODO Auto-generated method stub

	}

	@Override
	public void removeDataPropertyAssertion(String object, String predicate, int subject) {
		// TODO Auto-generated method stub

	}

	@Override
	public void removeDataPropertyAssertion(String object, String predicate, float subject) {
		// TODO Auto-generated method stub

	}

	@Override
	public void removeDataPropertyAssertion(String object, String predicate, double subject) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean containsClassDeclaration(String object) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean containsIndividualDeclaration(String object) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean containsClassAssertion(String object, String subject) {
		OWLNamedIndividual individual = factory.getOWLNamedIndividual(IRI.create(object));
		OWLClass clazz = factory.getOWLClass(IRI.create(subject));
		OWLClassAssertionAxiom classAssertion = factory.getOWLClassAssertionAxiom(clazz, individual);
		return ontology.containsAxiom(classAssertion);
	}

	@Override
	public boolean containsObjectPropertyAssertion(String object, String predicate, String subject) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean containsDataPropertyAssertion(String object, String predicate, String subject) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean containsDataPropertyAssertion(String object, String predicate, boolean subject) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean containsDataPropertyAssertion(String object, String predicate, int subject) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean containsDataPropertyAssertion(String object, String predicate, float subject) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean containsDataPropertyAssertion(String object, String predicate, double subject) {
		// TODO Auto-generated method stub
		return false;
	}

	// private IRI getLocalIRI(String object) {
	// return IRI.create(ontologyIRI + SEPARATOR + object);
	// }

	// @Override
	// public void addClass(String name) {
	// // OWLClass individual = factory.getOWLClass(getLocalIRI(name));
	// // ...
	// if (onAddClass) {
	// // eventBase.offer(new Event(this,
	// // EventType.AGENT_BELIEF_CLASS_ADDED, individual));
	// }
	// }

	// void subscribe(Class<? extends AbstractBeliefBaseEvent> type) {
	// switch (type) {
	// case ADD: {
	// onAdd = true;
	// break;
	// }
	// case REMOVE: {
	// onRemove = true;
	// break;
	// }
	// default: {
	// throw new IllegalArgumentException();
	// }
	// }
	// }

}
