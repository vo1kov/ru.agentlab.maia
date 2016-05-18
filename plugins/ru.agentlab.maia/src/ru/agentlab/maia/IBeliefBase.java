/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

public interface IBeliefBase {

	void addClassDeclaration(String object);

	void addIndividualDeclaration(String object);

	void addClassAssertion(String object, String subject);

	void addObjectPropertyAssertion(String object, String predicate, String subject);

	void addDataPropertyAssertion(String object, String predicate, String subject);

	void addDataPropertyAssertion(String object, String predicate, boolean subject);

	void addDataPropertyAssertion(String object, String predicate, int subject);

	void addDataPropertyAssertion(String object, String predicate, float subject);

	void addDataPropertyAssertion(String object, String predicate, double subject);

	void removeClassDeclaration(String object);

	void removeIndividualDeclaration(String object);
	
	void removeClassAssertion(String object, String subject);

	void removeObjectPropertyAssertion(String object, String predicate, String subject);

	void removeDataPropertyAssertion(String object, String predicate, String subject);

	void removeDataPropertyAssertion(String object, String predicate, boolean subject);

	void removeDataPropertyAssertion(String object, String predicate, int subject);

	void removeDataPropertyAssertion(String object, String predicate, float subject);

	void removeDataPropertyAssertion(String object, String predicate, double subject);

	boolean containsClassDeclaration(String object);

	boolean containsIndividualDeclaration(String object);

	boolean containsClassAssertion(String object, String subject);

	boolean containsObjectPropertyAssertion(String object, String predicate, String subject);

	boolean containsDataPropertyAssertion(String object, String predicate, String subject);

	boolean containsDataPropertyAssertion(String object, String predicate, boolean subject);

	boolean containsDataPropertyAssertion(String object, String predicate, int subject);

	boolean containsDataPropertyAssertion(String object, String predicate, float subject);

	boolean containsDataPropertyAssertion(String object, String predicate, double subject);

}
