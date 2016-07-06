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
import ru.agentlab.maia.role.converter.LiteralIllelgalLanguageTagException;
import ru.agentlab.maia.role.converter.LiteralWrongBuildInDatatypeException;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterGetOWLLiteralRDFXMLLiteralMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	@Parameters
	public static Collection<Object[]> data() {
		return Arrays
				.asList(new Object[][] {
			// @formatter:off
			/* -----------------------------------------------------------------------------------------------------------------------------------------------
			 *| ##   | Input Parameter                          | Result Literal                                             | Comment                        |
			  -----------------------------------------------------------------------------------------------------------------------------------------------*/
			// rdf:XMLLiteral
			/*  0 */ { "^^rdf:XMLLiteral",                      isTypedLiteral(equalTo(""), hasIRI(RDF, XML_LITERAL)) },            // test empty string
			/*  1 */ { "test^^rdf:XMLLiteral",                  isTypedLiteral(equalTo("test"), hasIRI(RDF, XML_LITERAL)) },        // test non-empty string
			/*  2 */ { "test string^^rdf:XMLLiteral",           isTypedLiteral(equalTo("test string"), hasIRI(RDF, XML_LITERAL)) }, // test value with whitespace
			/*  3 */ { "true^^rdf:XMLLiteral",                  isTypedLiteral(equalTo("true"), hasIRI(RDF, XML_LITERAL)) },        // test value with another type
			/*  4 */ { "2.3^^rdf:XMLLiteral",                   isTypedLiteral(equalTo("2.3"), hasIRI(RDF, XML_LITERAL)) },         // test value with another type
			/*  5 */ { "test string^^<" + RDF + "XMLLiteral>",  isTypedLiteral(equalTo("test string"), hasIRI(RDF, XML_LITERAL)) }, // test type full name
//			/*  6 */ { "?var^^rdf:XMLLiteral",                  isTyped(var("var"), hasIRI(RDF, XML_LITERAL)) },             // test variable value
			/*  7 */ { "?var@?lang^^rdf:XMLLiteral",            LiteralIllelgalLanguageTagException.class },                 // test variable value and lang
			/*  8 */ { "test string^^rdfs:XMLLiteral",          LiteralWrongBuildInDatatypeException.class },                // wrong namespace
			/*  9 */ { "test string^^<" + RDFS + "XMLLiteral>", LiteralWrongBuildInDatatypeException.class },                // wrong namespace
			// @formatter:on
		});
	}

}
