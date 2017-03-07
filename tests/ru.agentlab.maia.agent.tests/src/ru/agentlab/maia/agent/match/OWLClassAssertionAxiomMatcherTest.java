/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.match;

import static org.hamcrest.CoreMatchers.allOf;
import static org.hamcrest.Matchers.anything;
import static ru.agentlab.maia.agent.belief.filter.Matchers.hasClassExpression;
import static ru.agentlab.maia.agent.belief.filter.Matchers.hasIRI;
import static ru.agentlab.maia.agent.belief.filter.Matchers.hasIndividual;
import static ru.agentlab.maia.agent.belief.filter.Matchers.isNamed;
import static ru.agentlab.maia.agent.belief.filter.Matchers.isNamedClass;

import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLOntologyManager;

/**
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class OWLClassAssertionAxiomMatcherTest {

	private static OWLOntologyManager manager = OWLManager.createOWLOntologyManager();

	private static OWLDataFactory factory = manager.getOWLDataFactory();

	private static String NAMESPACE = "http://www.agentlab.ru/test/ontology#";

	private static IRI TEST1_IRI = IRI.create(NAMESPACE + "test1");
	private static IRI XXXXX_IRI = IRI.create(NAMESPACE + "xxxxx");
	private static IRI CLASS1_IRI = IRI.create(NAMESPACE + "class1");
	private static IRI XXXXXX_IRI = IRI.create(NAMESPACE + "xxxxxx");

	private static OWLNamedIndividual TEST1 = factory.getOWLNamedIndividual(TEST1_IRI);
	private static OWLNamedIndividual XXXXX = factory.getOWLNamedIndividual(XXXXX_IRI);
	private static OWLClass CLASS1 = factory.getOWLClass(CLASS1_IRI);
	private static OWLClass XXXXXX = factory.getOWLClass(XXXXXX_IRI);

	private static Map<String, Object> EMPTY = new HashMap<>();
	private static Map<String, Object> ONLY_TEST1 = new HashMap<>();
	private static Map<String, Object> ONLY_XXXXX = new HashMap<>();
	private static Map<String, Object> ONLY_CLASS1 = new HashMap<>();
	private static Map<String, Object> ONLY_XXXXXX = new HashMap<>();
	private static Map<String, Object> TEST1_CLASS1 = new HashMap<>();
	private static Map<String, Object> XXXXX_CLASS1 = new HashMap<>();
	private static Map<String, Object> TEST1_XXXXXX = new HashMap<>();
	private static Map<String, Object> XXXXX_XXXXXX = new HashMap<>();
	private static Map<String, Object> VALUES = new HashMap<>();

	private static final Matcher<?> INDIVIDUAL_CLASS = allOf(hasClassExpression(isNamedClass(hasIRI(CLASS1_IRI))),
			hasIndividual(isNamedIndividual(hasIRI(TEST1_IRI))));
	private static final Matcher<?> INDIVIDUAL_VAR = hasClassExpression(isNamedClass(hasIRI(CLASS1_IRI)));
	private static final Matcher<?> VAR_CLASS = hasIndividual(isNamedIndividual(hasIRI(TEST1_IRI)));
	private static final Matcher<?> VAR_VAR = anything();

	static {
		ONLY_TEST1.put("indiv", TEST1);
		ONLY_XXXXX.put("indiv", XXXXX);
		ONLY_CLASS1.put("class", CLASS1);
		ONLY_XXXXXX.put("class", XXXXXX);
		TEST1_CLASS1.put("indiv", TEST1);
		TEST1_CLASS1.put("class", CLASS1);
		XXXXX_CLASS1.put("indiv", XXXXX);
		XXXXX_CLASS1.put("class", CLASS1);
		TEST1_XXXXXX.put("indiv", TEST1);
		TEST1_XXXXXX.put("class", XXXXXX);
		XXXXX_XXXXXX.put("indiv", XXXXX);
		XXXXX_XXXXXX.put("class", XXXXXX);
	}

	@Parameters
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
			// @formatter:off
			/* ------------------------------------------------------------------
			 *| ##	| Matcher 			 | Axiom        | Result                 |
			 *------------------------------------------------------------------*/
			/*  0 */ { INDIVIDUAL_CLASS, TEST1, CLASS1, true,  EMPTY },
			/*  1 */ { INDIVIDUAL_CLASS, TEST1, XXXXXX, false, null },
			/*  2 */ { INDIVIDUAL_CLASS, XXXXX, CLASS1, false, null },
			/*  3 */ { INDIVIDUAL_CLASS, XXXXX, XXXXXX, false, null },
			                                            
			/*  4 */ { INDIVIDUAL_VAR,   TEST1, CLASS1, true,  ONLY_CLASS1 },
			/*  5 */ { INDIVIDUAL_VAR,   TEST1, XXXXXX, true,  ONLY_XXXXXX },
			/*  6 */ { INDIVIDUAL_VAR,   XXXXX, CLASS1, false, null },
			/*  7 */ { INDIVIDUAL_VAR,   XXXXX, XXXXXX, false, null },
			                                            
			/*  8 */ { VAR_CLASS,        TEST1, CLASS1, true,  ONLY_TEST1 },
			/*  9 */ { VAR_CLASS,        TEST1, XXXXXX, false, null },
			/* 10 */ { VAR_CLASS,        XXXXX, CLASS1, true,  ONLY_XXXXX },
			/* 11 */ { VAR_CLASS,        XXXXX, XXXXXX, false, null },
			                                            
			/* 12 */ { VAR_VAR,          TEST1, CLASS1, true,  TEST1_CLASS1 },
			/* 13 */ { VAR_VAR,          TEST1, XXXXXX, true,  TEST1_XXXXXX },
			/* 14 */ { VAR_VAR,          XXXXX, CLASS1, true,  XXXXX_CLASS1 },
			/* 15 */ { VAR_VAR,          XXXXX, XXXXXX, true,  XXXXX_XXXXXX },
			// @formatter:on
		});
	}

	@Parameter(0)
	public Matcher<?> matcher;

	@Parameter(1)
	public OWLNamedIndividual indivAxiom;

	@Parameter(2)
	public OWLClass classAxiom;

	@Parameter(3)
	public boolean result;

	@Parameter(4)
	public Map<String, Object> resultUnifier;

	@Test
	public void test() {
		// Given
		VALUES.clear();
		OWLClassAssertionAxiom axiom = factory.getOWLClassAssertionAxiom(classAxiom, indivAxiom);

		// When
		System.out.println("Match " + axiom + " by " + matcher);
		boolean match = matcher.matches(axiom);
		VALUES.forEach((k, v) -> {
			System.out.println("	" + k + "=" + v);
		});
		Description d = Description.NONE;
		matcher.describeMismatch(axiom, d);
		System.out.println(d.toString());
		// Then
		Assert.assertEquals(result, match);
		if (match) {
			Assert.assertEquals(resultUnifier.size(), VALUES.size());
			resultUnifier.forEach((k, v) -> {
				Assert.assertEquals(v, VALUES.get(k));
			});
		}
	}
}
