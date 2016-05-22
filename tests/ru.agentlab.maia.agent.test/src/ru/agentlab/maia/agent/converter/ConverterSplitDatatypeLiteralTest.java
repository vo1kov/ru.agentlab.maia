/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.converter;

import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Stream;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;
import org.semanticweb.owlapi.vocab.Namespaces;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterSplitDatatypeLiteralTest {

	final static String RDF = Namespaces.RDF.toString();
	final static String RDFS = Namespaces.RDFS.toString();
	final static String OWL = Namespaces.OWL.toString();
	final static String XSD = Namespaces.XSD.toString();

	// @formatter:off
	// Name is not working because some of the test strings have \r\n symbols
	@Parameters//(name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] { 
			/* --------------------------------------------------------------------------------------------------------------------------------------------
			 *| ##	| Input Parameter 						| Literal		| Language | Datatype						| Comment						|
			 *---------------------------------------------------------------------------------------------------------------------------------------------*/
			// Empty word
			/*  0 */ { "", 									"",				null, 		null },							// test empty string
			/*  0 */ { "^^rdf:XMLLiteral", 					"",				null, 		"rdf:XMLLiteral" },				// test only datatype
			/*  0 */ { "^^<" + RDF + "XMLLiteral>", 		"",				null, 		"<" + RDF + "XMLLiteral>" },	// test only full datatype
			/*  0 */ { "@ru", 								"",				"ru", 		null },							// test only language
			/*  0 */ { "@ru-RU", 							"",				"ru-RU", 	null },							// test only language
			/*  0 */ { "@en^^rdf:XMLLiteral", 				"",				"en", 		"rdf:XMLLiteral" },				// test language and datatype
			/*  0 */ { "@en^^<" + RDF + "XMLLiteral>", 		"",				"en", 		"<" + RDF + "XMLLiteral>" },	// test language and full datatype
			// Single word
			/*  0 */ { "some", 								"some",			null, 		null },							// test single word string
			/*  0 */ { "test^^rdf:XMLLiteral", 				"test",			null, 		"rdf:XMLLiteral" },				// test single word and datatype
			/*  0 */ { "test^^<" + RDF + "XMLLiteral>", 	"test",			null, 		"<" + RDF + "XMLLiteral>" },	// test single word and full datatype
			/*  0 */ { "тест@ru", 							"тест",			"ru", 		null },							// test single word and language
			/*  0 */ { "тест@ru-RU", 						"тест",			"ru-RU", 	null },							// test single word and language
			/*  0 */ { "test@en^^rdf:XMLLiteral", 			"test",			"en", 		"rdf:XMLLiteral" },				// test single word, language and datatype
			/*  0 */ { "test@en^^<" + RDF + "XMLLiteral>", 	"test",			"en", 		"<" + RDF + "XMLLiteral>" },	// test single word, language and full datatype
			// Multiple words
			/*  0 */ { "some more", 						"some more",	null, 		null },							// test multiple words string
			/*  0 */ { "test w 2^^rdf:XMLLiteral", 			"test w 2",		null, 		"rdf:XMLLiteral" },				// test multiple words and datatype
			/*  0 */ { "test^^<" + RDF + "XMLLiteral>", 	"test",			null, 		"<" + RDF + "XMLLiteral>" },	// test multiple words and full datatype
			/*  0 */ { "тест 2 3@ru", 						"тест 2 3",		"ru", 		null },							// test multiple words and language
			/*  0 */ { "тест qwe@ru-RU", 					"тест qwe",		"ru-RU", 	null },							// test multiple words and language
			/*  0 */ { "test@en^^rdf:XMLLiteral", 			"test",			"en", 		"rdf:XMLLiteral" },				// test multiple words, language and datatype
			/*  0 */ { "test@en^^<" + RDF + "XMLLiteral>", 	"test",			"en", 		"<" + RDF + "XMLLiteral>" },	// test multiple words, language and full datatype
			// Special characters
			/*  0 */ { "som\r\n\tmore", 					"som\r\n\tmore",null, 		null },							// test \r\n\t in literal
			/*  0 */ { "2^2^^owl:real", 					"2^2",			null, 		"owl:real" },					// test ^ in literal
			/*  0 */ { "email@dot.com@en^^xsd:real", 		"email@dot.com","en", 		"xsd:real" },					// test @ in literal
		});
	}
	// @formatter:on

	@Parameter(0)
	public String parameter;

	@Parameter(1)
	public String value;

	@Parameter(2)
	public String language;

	@Parameter(3)
	public String datatype;

	@Test
	public void anyEmptyLiteralShouldThrow() {
		System.out.println("[" + parameter + "]");
		String[] splitted = Converter.splitDatatypeLiteral(parameter);
		Stream.of(splitted).forEach(s -> System.out.println("	[" + s + "]"));
		Assert.assertEquals(3, splitted.length);
		Assert.assertEquals(value, splitted[0]);
		Assert.assertEquals(language, splitted[1]);
		Assert.assertEquals(datatype, splitted[2]);
	}

}
