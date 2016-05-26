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
import static ru.agentlab.maia.agent.converter.MatcherUtil.REAL;
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
public class ConverterGetOWLLiteralOWLRealMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	// Name is not working because some of the test strings have \r\n symbols
	@Parameters // (name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays
				.asList(new Object[][] {
			// @formatter:off
			/* -------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 					| Result Literal										| Comment						|
			  --------------------------------------------------------------------------------------------------------------------------------------*/
			// owl:real
			/*  0 */ 	{ "^^owl:real", 					typedMatcher(_str(""), 				_typ(OWL, REAL)) },	// test empty string
			/*  1 */ 	{ "test^^owl:real",					typedMatcher(_str("test"), 			_typ(OWL, REAL)) },	// test non-empty string
			/*  2 */ 	{ "test string^^owl:real",			typedMatcher(_str("test string"), 	_typ(OWL, REAL)) },	// test value with whitespace
			/*  3 */ 	{ "test string^^<" + OWL + "real>", typedMatcher(_str("test string"), 	_typ(OWL, REAL)) }, // test full name
			/*  4 */ 	{ "?var^^owl:real", 				typedMatcher(_var("var"),			_typ(OWL, REAL)) }, // test variable value
			/*  5 */ 	{ "?var@?lang^^owl:real", 			LiteralIllelgalLanguageTagException.class }, 			// test variable value and lang
			/*  6 */ 	{ "test string^^rdfs:real", 		LiteralWrongBuildInDatatypeException.class }, 			// wrong namespace
			/*  7 */ 	{ "test string^^<" + RDF + "real>", LiteralWrongBuildInDatatypeException.class }, 			// wrong namespace
			// @formatter:on
		});
	}

}
