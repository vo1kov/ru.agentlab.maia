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
import static ru.agentlab.maia.agent.converter.MatcherUtil.RDFS;
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
public class ConverterGetOWLLiteralRDFSLiteralMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	// Name is not working because some of the test strings have \r\n symbols
	@Parameters // (name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
			// @formatter:off
			/* ---------------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 						| Result Literal											| Comment						|
			  ---------------------------------------------------------------------------------------------------------------------------------------------*/
			// rdfs:Literal
			/*  0 */ 	{ "^^rdfs:Literal", 					typedMatcher(_str(""), 				_typ(RDFS, LITERAL)) },	// test empty string
			/*  1 */ 	{ "test^^rdfs:Literal", 				typedMatcher(_str("test"), 			_typ(RDFS, LITERAL)) },	// test non-empty string
			/*  2 */ 	{ "test string^^rdfs:Literal",			typedMatcher(_str("test string"), 	_typ(RDFS, LITERAL)) },	// test value with whitespace
			/*  3 */ 	{ "test string^^<" + RDFS + "Literal>", typedMatcher(_str("test string"), 	_typ(RDFS, LITERAL)) }, // test type full name
			/*  4 */ 	{ "?var^^rdfs:Literal", 				typedMatcher(_var("var"),			_typ(RDFS, LITERAL)) }, // test variable value
			/*  5 */ 	{ "?var@?lang^^rdfs:Literal", 			LiteralIllelgalLanguageTagException.class }, 				// test variable value and lang
			/*  6 */ 	{ "test string^^rdf:Literal", 			LiteralWrongBuildInDatatypeException.class }, 				// wrong namespace
			/*  7 */ 	{ "test string^^<" + OWL + "Literal>", 	LiteralWrongBuildInDatatypeException.class }, 				// wrong namespace
			// @formatter:on
		});
	}

}
