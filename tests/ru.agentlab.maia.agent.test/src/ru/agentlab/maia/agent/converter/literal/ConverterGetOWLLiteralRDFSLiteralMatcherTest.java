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
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasIRI;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isTypedLiteral;

import java.util.Arrays;
import java.util.Collection;

import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import ru.agentlab.maia.agent.converter.AbstractGetOWLLiteralMatcherTest;
import ru.agentlab.maia.belief.annotation.converter.LiteralIllelgalLanguageTagException;
import ru.agentlab.maia.belief.annotation.converter.LiteralWrongBuildInDatatypeException;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterGetOWLLiteralRDFSLiteralMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	@Parameters
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
			// @formatter:off
			/* -----------------------------------------------------------------------------------------------------------------------------------------
			 *| ##   | Input Parameter                       | Result Literal                                          | Comment                        |
			  -----------------------------------------------------------------------------------------------------------------------------------------*/
			// rdfs:Literal
			/*  0 */ { "^^rdfs:Literal",                     isTypedLiteral(equalTo(""), hasIRI(RDFS, LITERAL)) },            // test empty string
			/*  1 */ { "test^^rdfs:Literal",                 isTypedLiteral(equalTo("test"), hasIRI(RDFS, LITERAL)) },        // test non-empty string
			/*  2 */ { "test string^^rdfs:Literal",          isTypedLiteral(equalTo("test string"), hasIRI(RDFS, LITERAL)) }, // test value with whitespace
			/*  3 */ { "test string^^<" + RDFS + "Literal>", isTypedLiteral(equalTo("test string"), hasIRI(RDFS, LITERAL)) }, // test type full name
			/*  4 */ { "?var^^rdfs:Literal",                 isTypedLiteral(equalTo("var"), hasIRI(RDFS, LITERAL)) },         // test variable value
			/*  5 */ { "?var@?lang^^rdfs:Literal",           LiteralIllelgalLanguageTagException.class },              // test variable value and lang
			/*  6 */ { "test string^^rdf:Literal",           LiteralWrongBuildInDatatypeException.class },             // wrong namespace
			/*  7 */ { "test string^^<" + OWL + "Literal>",  LiteralWrongBuildInDatatypeException.class },             // wrong namespace
			// @formatter:on
		});
	}

}
