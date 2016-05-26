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

public interface IGoalBase {

	void addAxiom(OWLAxiom axiom);

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
	
	IGoal addGoal(String string);

	boolean removeGoal(String property);

}
