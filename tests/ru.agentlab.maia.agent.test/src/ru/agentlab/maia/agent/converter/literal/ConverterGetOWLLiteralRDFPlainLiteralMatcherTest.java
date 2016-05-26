/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.converter.literal;

import static ru.agentlab.maia.agent.converter.MatcherUtil.OWL;
import static ru.agentlab.maia.agent.converter.MatcherUtil.RDF;
import static ru.agentlab.maia.agent.converter.MatcherUtil.STRING;
import static ru.agentlab.maia.agent.converter.MatcherUtil.XSD;
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
import ru.agentlab.maia.agent.converter.LiteralWrongBuildInDatatypeException;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterGetOWLLiteralRDFPlainLiteralMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	// Name is not working because some of the test strings have \r\n symbols
	@Parameters // (name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
			// @formatter:off
			/* ---------------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 							| Result Literal										| Comment						|
			  ----------------------------------------------------------------------------------------------------------------------------------------------*/
			// rdf:PlainLiteral
			/*  0 */ 	{ "", 										plainMatcher(_str(""), 				_any()) },			// test empty string
			/*  1 */ 	{ "^^rdf:PlainLiteral", 					plainMatcher(_str(""), 				_any()) },			// test empty string
			/*  2 */ 	{ "test^^rdf:PlainLiteral",					plainMatcher(_str("test"), 			_any()) },			// test non-empty string
			/*  3 */ 	{ "test string^^rdf:PlainLiteral",			plainMatcher(_str("test string"), 	_any()) },			// test value with whitespace
			/*  4 */ 	{ "test string^^<" + RDF + "PlainLiteral>",	plainMatcher(_str("test string"), 	_any()) },			// test full name
			/*  5 */ 	{ "Padredefamilia@es", 						plainMatcher(_str("Padredefamilia"),_str("es")) }, 		// test language tag
			/*  6 */ 	{ "Padredefamilia@es^^rdf:PlainLiteral",	plainMatcher(_str("Padredefamilia"),_str("es")) }, 		// test language tag
			/*  7 */ 	{ "Family Guy@", 							plainMatcher(_str("Family Guy"), 	_str("")) }, 		// test language tag
			/*  8 */ 	{ "Family Guy@en", 							plainMatcher(_str("Family Guy"),	_str("en")) }, 		// test language tag
			/*  9 */ 	{ "Тест строка@ru^^rdf:PlainLiteral",		plainMatcher(_str("Тест строка"),	_str("ru")) }, 		// test language tag
			/* 10 */ 	{ "Тест@строка@ru^^rdf:PlainLiteral",		plainMatcher(_str("Тест@строка"),	_str("ru")) }, 		// test language tag
			/* 11 */ 	{ "?var^^rdf:PlainLiteral", 				plainMatcher(_var("var"),			_any()) }, 			// test variable
			/* 12 */ 	{ "?var@?lang^^rdf:PlainLiteral", 			plainMatcher(_var("var"),			_var("lang")) }, 	// test variable value and lang
			/* 13 */ 	{ "?var@?lang", 							plainMatcher(_var("var"),			_var("lang")) }, 	// test variable value, lang and no type
			/* 14 */ 	{ "?var", 									plainMatcher(_var("var"),			_any()) }, 			// test variable value only
			/* 15 */ 	{ "Тест строка@ru^^xsd:string", 			typedMatcher(_str("Тест строка@ru"),_typ(XSD, STRING))},// test language tag
			/* 16 */ 	{ "Padre de familia@es^^owl:PlainLiteral",	LiteralWrongBuildInDatatypeException.class }, 			// wrong namespace
			/* 17 */ 	{ "test string^^<" + OWL + "PlainLiteral>",	LiteralWrongBuildInDatatypeException.class }, 			// wrong namespace
			// @formatter:on
		});
	}

}
