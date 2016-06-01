/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.converter.literal;

import static org.hamcrest.Matchers.equalTo;
import static ru.agentlab.maia.agent.match.Matchers.hasIRI;
import static ru.agentlab.maia.agent.match.Matchers.isTyped;

import java.util.Arrays;
import java.util.Collection;

import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import ru.agentlab.maia.agent.converter.AbstractGetOWLLiteralMatcherTest;
import ru.agentlab.maia.agent.converter.LiteralIllelgalLanguageTagException;
import ru.agentlab.maia.agent.converter.LiteralWrongBuildInDatatypeException;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterGetOWLLiteralOWLRealMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	@Parameters
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
			// @formatter:off
			/* ---------------------------------------------------------------------------------------------------------------------------------
			 *| ##   | Input Parameter                   | Result Literal                                      | Comment                        |
			  ---------------------------------------------------------------------------------------------------------------------------------*/
			// owl:real
			/*  0 */ { "^^owl:real",                     isTyped(equalTo(""), hasIRI(OWL, REAL)) },            // test empty string
			/*  1 */ { "test^^owl:real",                 isTyped(equalTo("test"), hasIRI(OWL, REAL)) },        // test non-empty string
			/*  2 */ { "test string^^owl:real",          isTyped(equalTo("test string"), hasIRI(OWL, REAL)) }, // test value with whitespace
			/*  3 */ { "test string^^<" + OWL + "real>", isTyped(equalTo("test string"), hasIRI(OWL, REAL)) }, // test full name
//			/*  4 */ { "?var^^owl:real",                 isTyped(var("var"), hasIRI(OWL, REAL)) },             // test variable value
			/*  5 */ { "?var@?lang^^owl:real",           LiteralIllelgalLanguageTagException.class },          // test variable value and lang
			/*  6 */ { "test string^^rdfs:real",         LiteralWrongBuildInDatatypeException.class },         // wrong namespace
			/*  7 */ { "test string^^<" + RDF + "real>", LiteralWrongBuildInDatatypeException.class },         // wrong namespace
			// @formatter:on
		});
	}

}
