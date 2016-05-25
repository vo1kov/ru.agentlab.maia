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
import static ru.agentlab.maia.agent.converter.MatcherUtil.RATIONAL;
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
import ru.agentlab.maia.agent.converter.LiteralNotInLexicalSpaceException;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterGetOWLLiteralOWLRationalMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	// Name is not working because some of the test strings have \r\n symbols
	@Parameters // (name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
			// @formatter:off
			/* -----------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 					| Result Literal											| Comment						|
			  ------------------------------------------------------------------------------------------------------------------------------------------*/
			// owl:rational
			/*  0 */ 	{ "^^owl:rational", 				LiteralNotInLexicalSpaceException.class },					// test empty string
			/*  1 */ 	{ "2/3^^owl:rational",				typedMatcher(_str("2/3"), 			_typ(OWL, RATIONAL)) },	// test non-empty string
			/*  2 */ 	{ "2 / 3^^owl:rational",			typedMatcher(_str("2 / 3"), 		_typ(OWL, RATIONAL)) },	// test non-empty string
			/*  3 */ 	{ "-2 /3^^owl:rational",			typedMatcher(_str("-2 /3"), 		_typ(OWL, RATIONAL)) },	// test non-empty string
			/*  4 */ 	{ "+2/ 3^^owl:rational",			typedMatcher(_str("+2/ 3"), 		_typ(OWL, RATIONAL)) },	// test non-empty string
			/*  5 */ 	{ "45/7^^<" + OWL + "rational>", 	typedMatcher(_str("45/7"), 			_typ(OWL, RATIONAL)) }, // test full name
			/*  6 */ 	{ "?var^^owl:rational", 			typedMatcher(_var("var"),			_typ(OWL, RATIONAL)) }, // test variable value
			/*  7 */ 	{ "?var@?lang^^owl:rational", 		LiteralIllelgalLanguageTagException.class }, 				// test variable value and lang
			/*  8 */ 	{ "2^^owl:rational",				LiteralNotInLexicalSpaceException.class },					// test wrong format
			/*  9 */ 	{ "2.5/3.21^^owl:rational",			LiteralNotInLexicalSpaceException.class },					// test wrong format
			// @formatter:on
		});
	}

}
