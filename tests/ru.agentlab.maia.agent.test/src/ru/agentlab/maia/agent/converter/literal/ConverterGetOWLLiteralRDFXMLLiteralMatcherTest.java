/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.converter.literal;

import static ru.agentlab.maia.agent.converter.MatcherUtil.RDF;
import static ru.agentlab.maia.agent.converter.MatcherUtil.RDFS;
import static ru.agentlab.maia.agent.converter.MatcherUtil.XML_LITERAL;
import static ru.agentlab.maia.agent.converter.MatcherUtil._str;
import static ru.agentlab.maia.agent.converter.MatcherUtil._typ;
import static ru.agentlab.maia.agent.converter.MatcherUtil._var;
import static ru.agentlab.maia.agent.converter.MatcherUtil.typedMatcher;

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
public class ConverterGetOWLLiteralRDFXMLLiteralMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	// Name is not working because some of the test strings have \r\n symbols
	@Parameters // (name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays
				.asList(new Object[][] {
			// @formatter:off
			/* -----------------------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 							| Result Literal												| Comment						|
			  -----------------------------------------------------------------------------------------------------------------------------------------------------*/
			// rdf:XMLLiteral
			/*  0 */ 	{ "^^rdf:XMLLiteral", 						typedMatcher(_str(""), 				_typ(RDF, XML_LITERAL)) },	// test empty string
			/*  1 */ 	{ "test^^rdf:XMLLiteral", 					typedMatcher(_str("test"),			_typ(RDF, XML_LITERAL)) },	// test non-empty string
			/*  2 */ 	{ "test string^^rdf:XMLLiteral", 			typedMatcher(_str("test string"),	_typ(RDF, XML_LITERAL)) },	// test value with whitespace
			/*  3 */ 	{ "true^^rdf:XMLLiteral", 					typedMatcher(_str("true"), 			_typ(RDF, XML_LITERAL)) },	// test value with another type
			/*  4 */ 	{ "2.3^^rdf:XMLLiteral", 					typedMatcher(_str("2.3"),			_typ(RDF, XML_LITERAL)) },	// test value with another type
			/*  5 */ 	{ "test string^^<" + RDF + "XMLLiteral>", 	typedMatcher(_str("test string"),	_typ(RDF, XML_LITERAL)) }, 	// test type full name
			/*  6 */ 	{ "?var^^rdf:XMLLiteral", 					typedMatcher(_var("var"),			_typ(RDF, XML_LITERAL)) }, 	// test variable value
			/*  7 */ 	{ "?var@?lang^^rdf:XMLLiteral", 			LiteralIllelgalLanguageTagException.class }, 					// test variable value and lang
			/*  8 */ 	{ "test string^^rdfs:XMLLiteral",			LiteralWrongBuildInDatatypeException.class }, 					// wrong namespace
			/*  9 */ 	{ "test string^^<" + RDFS + "XMLLiteral>",	LiteralWrongBuildInDatatypeException.class }, 					// wrong namespace
			// @formatter:on
		});
	}

}
