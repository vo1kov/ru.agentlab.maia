/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

public interface IGoalBase {

	boolean addGoalClassAsertion(OWLClassAssertionAxiom axiom);

	boolean addGoalDataPropertyAsertion(OWLDataPropertyAssertionAxiom axiom);

	boolean addGoalObjectPropertyAsertion(OWLObjectPropertyAssertionAxiom axiom);

	boolean removeGoalClassAsertion(OWLClassAssertionAxiom axiom);

	boolean removeGoalDataPropertyAsertion(OWLDataPropertyAssertionAxiom axiom);

	boolean removeObjectPropertyAsertion(OWLObjectPropertyAssertionAxiom axiom);

	default void addAxiom(OWLAxiom axiom) {
		if (axiom instanceof OWLClassAssertionAxiom) {
			addGoalClassAsertion((OWLClassAssertionAxiom) axiom);
		} else if (axiom instanceof OWLDataPropertyAssertionAxiom) {
			addGoalDataPropertyAsertion((OWLDataPropertyAssertionAxiom) axiom);
		} else if (axiom instanceof OWLObjectPropertyAssertionAxiom) {
			addGoalObjectPropertyAsertion((OWLObjectPropertyAssertionAxiom) axiom);
		} else {
			throw new RuntimeException();
		}
	}

	default void addAxioms(OWLAxiom... axioms) {
		for (OWLAxiom axiom : axioms) {
			addAxiom(axiom);
		}
	}

	default void addAxioms(Iterable<OWLAxiom> axioms) {
		for (OWLAxiom axiom : axioms) {
			addAxiom(axiom);
		}
	}

}
