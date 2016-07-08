/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyManager;

import de.derivo.sparqldlapi.QueryEngine;

public interface IBeliefBase {

	void addBelief(OWLAxiom axiom);

	void removeBelief(OWLAxiom axiom);

	boolean containsBelief(OWLAxiom axiom);

	default void addBeliefs(OWLAxiom... axioms) {
		for (OWLAxiom axiom : axioms) {
			addBelief(axiom);
		}
	}

	default void addBeliefs(Iterable<OWLAxiom> axioms) {
		for (OWLAxiom axiom : axioms) {
			addBelief(axiom);
		}
	}

	default void removeBeliefs(OWLAxiom... axioms) {
		for (OWLAxiom axiom : axioms) {
			removeBelief(axiom);
		}
	}

	default void removeBeliefs(Iterable<OWLAxiom> axioms) {
		for (OWLAxiom axiom : axioms) {
			removeBelief(axiom);
		}
	}

	default boolean containsBeliefs(OWLAxiom... axioms) {
		for (OWLAxiom axiom : axioms) {
			if (!containsBelief(axiom)) {
				return false;
			}
		}
		return true;
	}

	default boolean containsBeliefs(Iterable<OWLAxiom> axioms) {
		for (OWLAxiom axiom : axioms) {
			if (!containsBelief(axiom)) {
				return false;
			}
		}
		return true;
	}

	OWLOntology getOntology();

	IRI getOntologyIRI();

	OWLDataFactory getFactory();

	OWLOntologyManager getManager();

	QueryEngine getQueryEngine();

}
