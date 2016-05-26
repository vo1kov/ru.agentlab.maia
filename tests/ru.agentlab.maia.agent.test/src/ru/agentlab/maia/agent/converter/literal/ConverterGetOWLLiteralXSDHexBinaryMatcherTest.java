/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.converter.literal;

import static ru.agentlab.maia.agent.converter.MatcherUtil.HEX_BINARY;
import static ru.agentlab.maia.agent.converter.MatcherUtil.OWL;
import static ru.agentlab.maia.agent.converter.MatcherUtil.XSD;
import static ru.agentlab.maia.agent.converter.MatcherUtil._str;
import static ru.agentlab.maia.agent.converter.MatcherUtil._typ;
import static ru.agentlab.maia.agent.converter.MatcherUtil.typedMatcher;

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
public class ConverterGetOWLLiteralXSDHexBinaryMatcherTest extends AbstractGetOWLLiteralMatcherTest {

	// Name is not working because some of the test strings have \r\n symbols
	@Parameters // (name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
			// @formatter:off
			/* -------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 				| Result Literal											| Comment						|
			  -------------------------------------------------------------------------------------------------------------------------------------*/
			// xsd:hexBinary
			/*  0 */ 	{ "^^xsd:hexBinary", 			typedMatcher(_str(""), 			_typ(XSD, HEX_BINARY)) },	// test empty string
			/*  1 */ 	{ "a1^^xsd:hexBinary", 			typedMatcher(_str("a1"), 		_typ(XSD, HEX_BINARY)) },	// test non-empty string
			/*  2 */ 	{ "a1e2ff^^xsd:hexBinary", 		typedMatcher(_str("a1e2ff"), 	_typ(XSD, HEX_BINARY)) },	// test non-empty string
			/*  3 */ 	{ "?var@?lang^^xsd:hexBinary", 	LiteralIllelgalLanguageTagException.class }, 				// test variable value and lang
			/*  4 */ 	{ "qwe^^xsd:hexBinary", 		LiteralNotInLexicalSpaceException.class },					// wrong value format
			/*  5 */ 	{ "f^^xsd:hexBinary", 			LiteralNotInLexicalSpaceException.class },					// wrong value format
			/*  6 */ 	{ "a1e2f^^xsd:hexBinary", 		LiteralNotInLexicalSpaceException.class },					// wrong value format
			/*  7 */ 	{ "true^^rdf:hexBinary",		LiteralWrongBuildInDatatypeException.class }, 				// wrong namespace
			/*  8 */ 	{ "true^^<" + OWL + "boolean>",	LiteralWrongBuildInDatatypeException.class }, 				// wrong namespace
			// @formatter:on
		});
	}

}
