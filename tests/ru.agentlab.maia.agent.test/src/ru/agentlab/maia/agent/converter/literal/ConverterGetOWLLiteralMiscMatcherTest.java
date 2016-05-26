/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.converter.literal;

import static ru.agentlab.maia.agent.converter.MatcherUtil.LITERAL;
import static ru.agentlab.maia.agent.converter.MatcherUtil.OWL;
import static ru.agentlab.maia.agent.converter.MatcherUtil.RDF;
import static ru.agentlab.maia.agent.converter.MatcherUtil.RDFS;
import static ru.agentlab.maia.agent.converter.MatcherUtil.REAL;
import static ru.agentlab.maia.agent.converter.MatcherUtil.XML_LITERAL;
import static ru.agentlab.maia.agent.converter.MatcherUtil._any;
import static ru.agentlab.maia.agent.converter.MatcherUtil._str;
import static ru.agentlab.maia.agent.converter.MatcherUtil._typ;
import static ru.agentlab.maia.agent.converter.MatcherUtil._var;
import static ru.agentlab.maia.agent.converter.MatcherUtil.plainMatcher;
import static ru.agentlab.maia.agent.converter.MatcherUtil.typedMatcher;

import java.util.Arrays;
import java.util.Collection;

import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import ru.agentlab.maia.agent.converter.AbstractGetOWLLiteralMatcherTest;
import ru.agentlab.maia.agent.converter.LiteralNotInLexicalSpaceException;
import ru.agentlab.maia.agent.converter.LiteralUnknownPrefixException;
import ru.agentlab.maia.agent.converter.LiteralWrongFormatException;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterGetOWLLiteralMiscMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	// Name is not working because some of the test strings have \r\n symbols
	@Parameters // (name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
			// @formatter:off
			/* -------------------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 					| Result Literal													| Comment						|
			  --------------------------------------------------------------------------------------------------------------------------------------------------*/
			// Misc
			/*  0 */ 	{ "test string^rdf:XMLLiteral", 	plainMatcher(_str("test string^rdf:XMLLiteral"),_any()) }, 			// wrong separator, should be ^^
			/*  1 */ 	{ "test string^rdf:Literal", 		plainMatcher(_str("test string^rdf:Literal"),_any()) }, 			// wrong separator, should be ^^
			/*  2 */ 	{ "test string^rdf:real", 			plainMatcher(_str("test string^rdf:real"),_any()) }, 				// wrong separator, should be ^^
			/*  3 */ 	{ "true^xsd:boolean", 				plainMatcher(_str("true^xsd:boolean"),_any()) }, 					// wrong separator, should be ^^
			/*  4 */ 	{ "test string^^^rdf:XMLLiteral", 	typedMatcher(_str("test string^"),	_typ(RDF, XML_LITERAL)) }, 		// wrong separator, should be ^^
			/*  5 */ 	{ "test string^^^rdfs:Literal", 	typedMatcher(_str("test string^"),	_typ(RDFS, LITERAL)) }, 		// wrong separator, should be ^^
			/*  6 */ 	{ "test string^^^owl:real", 		typedMatcher(_str("test string^"),	_typ(OWL, REAL)) }, 			// wrong separator, should be ^^
			/*  7 */ 	{ "?var^^?type", 					typedMatcher(_var("var"),			_var("type")) }, 				// test variable value and type
			/*  8 */ 	{ "false^^^xsd:boolean", 			LiteralNotInLexicalSpaceException.class }, 							// wrong value [true^] format
			/*  9 */ 	{ "false^^some:type", 				LiteralUnknownPrefixException.class }, 								// unknown prefix
			/* 10 */ 	{ "false^^xsd : b o o lean:boolean",LiteralWrongFormatException.class }, 								// wrong format
			/* 11 */ 	{ "?v ar^^?t; pe", 					LiteralWrongFormatException.class }, 								// test variable value and type
//			/* 12 */ 	{ "?var@?lang^^?type", 				plainMatcher(_var("var"),			_var("lang"), 	_var("type")) },// test variable value, lang and type
			// @formatter:on
		});
	}

}
