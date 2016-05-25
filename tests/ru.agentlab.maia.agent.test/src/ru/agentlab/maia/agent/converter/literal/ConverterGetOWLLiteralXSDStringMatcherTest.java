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
import static ru.agentlab.maia.agent.converter.MatcherUtil.STRING;
import static ru.agentlab.maia.agent.converter.MatcherUtil.XSD;
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
public class ConverterGetOWLLiteralXSDStringMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	// Name is not working because some of the test strings have \r\n symbols
	@Parameters // (name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays
				.asList(new Object[][] {
			// @formatter:off
			/* -----------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 						| Result Literal										| Comment						|
			  -----------------------------------------------------------------------------------------------------------------------------------------*/
			// xsd:string
			/*  0 */ 	{ "^^xsd:string", 						typedMatcher(_str(""), 				_typ(XSD, STRING))},// test empty string
			/*  1 */ 	{ "test^^xsd:string", 					typedMatcher(_str("test"), 			_typ(XSD, STRING))},// test non-empty string
			/*  2 */ 	{ "test string^^xsd:string", 			typedMatcher(_str("test string"), 	_typ(XSD, STRING))},// test value with whitespace
			/*  3 */ 	{ "test \rstring^^xsd:string", 			typedMatcher(_str("test \rstring"), _typ(XSD, STRING))},// test value with whitespace
			/*  4 */ 	{ "test \nstring^^xsd:string", 			typedMatcher(_str("test \nstring"), _typ(XSD, STRING))},// test value with whitespace
			/*  5 */ 	{ "test\tstring^^xsd:string", 			typedMatcher(_str("test\tstring"), 	_typ(XSD, STRING))},// test value with whitespace
			/*  6 */ 	{ "test string^^<" + XSD + "string>", 	typedMatcher(_str("test string"), 	_typ(XSD, STRING))},// test full name
			/*  7 */ 	{ "?var^^xsd:string", 					typedMatcher(_var("var"),			_typ(XSD, STRING))},// test variable value
			/*  8 */ 	{ "?var@?lang^^xsd:string", 			LiteralIllelgalLanguageTagException.class }, 			// test variable value and lang
			/*  9 */ 	{ "test string^^rdfs:string", 			LiteralWrongBuildInDatatypeException.class }, 			// wrong namespace
			/* 10 */ 	{ "test string^^<" + RDF + "string>", 	LiteralWrongBuildInDatatypeException.class }, 			// wrong namespace
			// @formatter:on
		});
	}

}
