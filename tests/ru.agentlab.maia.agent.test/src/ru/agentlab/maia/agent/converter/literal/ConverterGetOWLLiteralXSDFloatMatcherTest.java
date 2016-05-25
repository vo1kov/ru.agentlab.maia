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
import static ru.agentlab.maia.agent.converter.MatcherUtil.XSD;
import static ru.agentlab.maia.agent.converter.MatcherUtil._flo;
import static ru.agentlab.maia.agent.converter.MatcherUtil._var;
import static ru.agentlab.maia.agent.converter.MatcherUtil.floatMatcher;

import java.util.Arrays;
import java.util.Collection;

import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import ru.agentlab.maia.agent.converter.AbstractGetOWLLiteralMatcherTest;
import ru.agentlab.maia.agent.converter.LiteralIllelgalLanguageTagException;
import ru.agentlab.maia.agent.converter.LiteralNotInLexicalSpaceException;
import ru.agentlab.maia.agent.converter.LiteralWrongBuildInDatatypeException;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterGetOWLLiteralXSDFloatMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	// Name is not working because some of the test strings have \r\n symbols
	@Parameters // (name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
			// @formatter:off
			/* ---------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 						| Result Literal								| Comment						|
			  ----------------------------------------------------------------------------------------------------------------------------------*/
			// xsd:float
			/*  0 */ 	{ "^^xsd:float", 						LiteralNotInLexicalSpaceException.class },		// wrong empty value
			/*  1 */ 	{ "0^^xsd:float", 						floatMatcher(_flo(0)) },						// test 0 string
			/*  2 */ 	{ "-0^^xsd:float", 						floatMatcher(_flo(0)) },						// test 0 string
			/*  3 */ 	{ "+0^^xsd:float", 						floatMatcher(_flo(0)) },						// test 0 string
			/*  4 */ 	{ "1^^xsd:float", 						floatMatcher(_flo(1)) },						// test 1 string
			/*  5 */ 	{ "-1^^xsd:float", 						floatMatcher(_flo(-1)) },						// test 1 string
			/*  6 */ 	{ "+1^^xsd:float", 						floatMatcher(_flo(1)) },						// test 1 string
			/*  7 */ 	{ "12345^^<" + XSD + "float>",			floatMatcher(_flo(12345)) }, 					// test more numbers
			/*  8 */ 	{ "2.2E12^^<" + XSD + "float>",			floatMatcher(_flo(2.2e12f)) }, 						// test dot name
			/*  9 */ 	{ Float.MAX_VALUE+"^^xsd:float",		floatMatcher(_flo(Float.MAX_VALUE)) }, 			// test max value
			/* 10 */ 	{ "-"+Float.MAX_VALUE+"^^xsd:float",	floatMatcher(_flo(-Float.MAX_VALUE)) }, 		// test min value
			/* 11 */ 	{ Float.MAX_VALUE+"0^^xsd:float",		floatMatcher(_flo(Float.POSITIVE_INFINITY)) }, 	// test > +infinity
			/* 12 */ 	{ "INF^^xsd:float",						floatMatcher(_flo(Float.POSITIVE_INFINITY)) }, 	// test +infinity
			/* 13 */ 	{ "-"+Float.MAX_VALUE+"0^^xsd:float",	floatMatcher(_flo(Float.NEGATIVE_INFINITY)) }, 	// test < -infinity
			/* 14 */ 	{ "-INF^^xsd:float",					floatMatcher(_flo(Float.NEGATIVE_INFINITY)) }, 	// test +infinity
			/* 15 */ 	{ "NaN^^xsd:float",						floatMatcher(_flo(Float.NaN)) }, 				// test NaN
			/* 16 */ 	{ "-NaN^^xsd:float",					LiteralNotInLexicalSpaceException.class }, 		// test -NaN
			/* 17 */ 	{ "+-1^^xsd:float", 					LiteralNotInLexicalSpaceException.class },		// wrong value format
			/* 18 */ 	{ "-+1^^xsd:float", 					LiteralNotInLexicalSpaceException.class },		// wrong value format
			/* 19 */ 	{ "+0.3.3^^xsd:float", 					LiteralNotInLexicalSpaceException.class },		// wrong value format
			/* 20 */ 	{ "-0-^^xsd:float", 					LiteralNotInLexicalSpaceException.class },		// wrong value format
			/* 21 */ 	{ "test string^^xsd:float", 			LiteralNotInLexicalSpaceException.class },		// wrong value format
			/* 22 */ 	{ "2/4^^xsd:float", 					LiteralNotInLexicalSpaceException.class },		// wrong value format
			/* 23 */ 	{ "?var^^xsd:float", 					floatMatcher(_var("var")) }, 					// test variable value
			/* 24 */ 	{ "?var@?lang^^xsd:float", 				LiteralIllelgalLanguageTagException.class }, 	// test variable value and lang
			/* 25 */ 	{ "true^^rdf:float",					LiteralWrongBuildInDatatypeException.class }, 	// wrong namespace
			/* 26 */ 	{ "true^^<" + OWL + "float>",			LiteralWrongBuildInDatatypeException.class }, 	// wrong namespace
			// @formatter:on
		});
	}

}
