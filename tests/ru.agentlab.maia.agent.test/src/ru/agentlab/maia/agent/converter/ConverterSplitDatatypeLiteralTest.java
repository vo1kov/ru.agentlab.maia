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
 * Test method {@link Converter#splitDatatypeLiteral(String)} which split literal into 3 parts:
 * <ol>
 * <li>Literal value;
 * <li>Literal language;
 * <li>Literal datatype;
 * </ol>
 * <p>
 * Test cases:
 * <!-- @formatter:off -->
 * <table border="thin single black collapse">
 * 	<thead>
 * 		<tr><th rowspan="2">##  <th>Input     			<th colspan="3">Output										<th rowspan="2">Comment
 * 		<tr>					<th>Parameter 			<th>Literal 		<th>Language<th>Datatype
 * 	<thead>
 * 	<tbody>
 * 		<tr><td> 0 <td>"" 								<td>""				<td>null 	<td>null					<td>test empty string
 * 		<tr><td> 1 <td>"^^rdf:XMLLiteral" 				<td>""				<td>null 	<td>"rdf:XMLLiteral"		<td>test only datatype
 * 		<tr><td> 2 <td>"^^&lt;RDF#XMLLiteral&gt;" 		<td>""				<td>null 	<td>"&lt;RDF#XMLLiteral&gt;"<td>test only full datatype
 * 		<tr><td> 3 <td>"@ru" 							<td>""				<td>"ru" 	<td>null					<td>test only language
 * 		<tr><td> 4 <td>"@ru-RU" 						<td>""				<td>"ru-RU" <td>null					<td>test only language
 * 		<tr><td> 5 <td>"@en^^rdf:XMLLiteral" 			<td>""				<td>"en" 	<td>"rdf:XMLLiteral"		<td>test language and datatype
 * 		<tr><td> 6 <td>"@en^^&lt;RDFS#Literal&gt;" 		<td>""				<td>"en" 	<td>"&lt;RDFS#Literal&gt;"	<td>test language and full datatype
 * 		<tr><td colspan="6">
 * 		<tr><td> 7 <td>"some" 							<td>"some"			<td>null 	<td>null					<td>test single word string
 * 		<tr><td> 8 <td>"test^^rdf:XMLLiteral" 			<td>"test"			<td>null 	<td>"rdf:XMLLiteral"		<td>test single word and datatype
 * 		<tr><td> 9 <td>"test^^&lt;RDF#XMLLiteral&gt;"	<td>"test"			<td>null 	<td>"&lt;RDF#XMLLiteral>"	<td>test single word and full datatype
 * 		<tr><td>10 <td>"тест@ru" 						<td>"тест"			<td>"ru" 	<td>null					<td>test single word and language
 * 		<tr><td>11 <td>"тест@ru-RU" 					<td>"тест"			<td>"ru-RU" <td>null					<td>test single word and language
 * 		<tr><td>12 <td>"test@en^^rdf:XMLLiteral" 		<td>"test"			<td>"en" 	<td>"rdf:XMLLiteral"		<td>test single word language and datatype
 * 		<tr><td>13 <td>"test@en^^&lt;RDF#XMLLiteral&gt;"<td>"test"			<td>"en" 	<td>"&lt;RDF#XMLLiteral&gt;"<td>test single word language and full datatype
 * 		<tr><td colspan="6">
 * 		<tr><td>14 <td>"some more" 						<td>"some more"		<td>null 	<td>null					<td>test multiple words string
 * 		<tr><td>15 <td>"test w 2^^rdf:XMLLiteral" 		<td>"test w 2"		<td>null 	<td>"rdf:XMLLiteral"		<td>test multiple words and datatype
 * 		<tr><td>16 <td>"test^^&lt;OWL#XMLLiteral&gt;" 	<td>"test"			<td>null 	<td>"&lt;OWL#XMLLiteral&gt;"<td>test multiple words and full datatype
 * 		<tr><td>17 <td>"тест 2 3@ru" 					<td>"тест 2 3"		<td>"ru" 	<td>null					<td>test multiple words and language
 * 		<tr><td>18 <td>"тест qwe@ru-RU" 				<td>"тест qwe"		<td>"ru-RU" <td>null					<td>test multiple words and language
 * 		<tr><td>19 <td>"test@en^^rdf:XMLLiteral" 		<td>"test"			<td>"en" 	<td>"rdf:XMLLiteral"		<td>test multiple words language and datatype
 * 		<tr><td>20 <td>"test@en^^&lt;XSD#XMLLiteral&gt;"<td>"test"			<td>"en" 	<td>"&lt;XSD#XMLLiteral&gt;"<td>test multiple words language and full datatype
 * 		<tr><td colspan="6">
 * 		<tr><td>21 <td>"som\r\n\tmore" 					<td>"som\r\n\tmore"	<td>null 	<td>null					<td>test \r\n\t in literal
 * 		<tr><td>22 <td>"2^2^^owl:real" 					<td>"2^2"			<td>null 	<td>"owl:real"				<td>test ^ in literal
 * 		<tr><td>23 <td>"2^^2^^owl:real" 				<td>"2^^2"			<td>null 	<td>"owl:real"				<td>test ^^ in literal
 * 		<tr><td>24 <td>"2^^2@^^owl:real" 				<td>"2^^2"			<td>"" 		<td>"owl:real"				<td>test ^^ and @ in literal
 * 		<tr><td>25 <td>"email@dot.com@en^^xsd:real" 	<td>"email@dot.com"	<td>"en" 	<td>"xsd:real"				<td>test @ in literal
 * 	</tbody>
 * </table>
 * <!-- @formatter:on -->
 * Used Namespaces:
 * <ul>
 * <li>RDF = http://www.w3.org/1999/02/22-rdf-syntax-ns#
 * <li>RDFS = http://www.w3.org/2000/01/rdf-schema#
 * <li>OWL = http://www.w3.org/2002/07/owl#
 * <li>XSD = http://www.w3.org/2001/XMLSchema#
 * </ul>
 * 
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterSplitDatatypeLiteralTest {

	private final static String RDF = Namespaces.RDF.toString();
	private final static String RDFS = Namespaces.RDFS.toString();
	private final static String OWL = Namespaces.OWL.toString();
	private final static String XSD = Namespaces.XSD.toString();

	// @formatter:off
	// Name is not working because some of the test strings have \r\n symbols
	@Parameters//(name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] { 
			/* -------------------------------------------------------------------------------------------------------------------------------------
			 *| ##	| Input Parameter 						| Literal		| Language | Datatype					| Comment						|
			 *--------------------------------------------------------------------------------------------------------------------------------------*/
			// Empty word
			/*  0 */ { "", 									"",				null, 		null },						// test empty string
			/*  1 */ { "^^rdf:XMLLiteral", 					"",				null, 		"rdf:XMLLiteral" },			// test only datatype
			/*  2 */ { "^^<" + RDF + "XMLLiteral>", 		"",				null, 		"<" + RDF + "XMLLiteral>" },// test only full datatype
			/*  3 */ { "@ru", 								"",				"ru", 		null },						// test only language
			/*  4 */ { "@ru-RU", 							"",				"ru-RU", 	null },						// test only language
			/*  5 */ { "@en^^rdf:XMLLiteral", 				"",				"en", 		"rdf:XMLLiteral" },			// test language and datatype
			/*  6 */ { "@en^^<" + RDFS + "Literal>", 		"",				"en", 		"<" + RDFS + "Literal>" },	// test language and full datatype
			// Single word
			/*  7 */ { "some", 								"some",			null, 		null },						// test single word string
			/*  8 */ { "test^^rdf:XMLLiteral", 				"test",			null, 		"rdf:XMLLiteral" },			// test single word and datatype
			/*  9 */ { "test^^<" + RDF + "XMLLiteral>", 	"test",			null, 		"<" + RDF + "XMLLiteral>" },// test single word and full datatype
			/* 10 */ { "тест@ru", 							"тест",			"ru", 		null },						// test single word and language
			/* 11 */ { "тест@ru-RU", 						"тест",			"ru-RU", 	null },						// test single word and language
			/* 12 */ { "test@en^^rdf:XMLLiteral", 			"test",			"en", 		"rdf:XMLLiteral" },			// test single word, language and datatype
			/* 13 */ { "test@en^^<" + RDF + "XMLLiteral>", 	"test",			"en", 		"<" + RDF + "XMLLiteral>" },// test single word, language and full datatype
			// Multiple words
			/* 14 */ { "some more", 						"some more",	null, 		null },						// test multiple words string
			/* 15 */ { "test w 2^^rdf:XMLLiteral", 			"test w 2",		null, 		"rdf:XMLLiteral" },			// test multiple words and datatype
			/* 16 */ { "test^^<" + OWL + "XMLLiteral>", 	"test",			null, 		"<" + OWL + "XMLLiteral>" },// test multiple words and full datatype
			/* 17 */ { "тест 2 3@ru", 						"тест 2 3",		"ru", 		null },						// test multiple words and language
			/* 18 */ { "тест qwe@ru-RU", 					"тест qwe",		"ru-RU", 	null },						// test multiple words and language
			/* 19 */ { "test@en^^rdf:XMLLiteral", 			"test",			"en", 		"rdf:XMLLiteral" },			// test multiple words, language and datatype
			/* 20 */ { "test@en^^<" + XSD + "XMLLiteral>", 	"test",			"en", 		"<" + XSD + "XMLLiteral>" },// test multiple words, language and full datatype
			// Special characters
			/* 21 */ { "som\r\n\tmore", 					"som\r\n\tmore",null, 		null },						// test \r\n\t in literal
			/* 22 */ { "2^2^^owl:real", 					"2^2",			null, 		"owl:real" },				// test ^ in literal
			/* 23 */ { "2^^2^^owl:real", 					"2^^2",			null, 		"owl:real" },				// test ^^ in literal
			/* 24 */ { "2^^2@^^owl:real", 					"2^^2",			"", 		"owl:real" },				// test ^^ and @ in literal
			/* 25 */ { "email@dot.com@en^^xsd:real", 		"email@dot.com","en", 		"xsd:real" },				// test @ in literal
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

	private static int i = 0;

	Converter converter = new Converter();

	@Test
	public void anyEmptyLiteralShouldThrow() {
		System.out.println("--------------------------- Test Case [" + i++ + "] ---------------------------");
		System.out.println("Input parameter: [" + parameter + "]");
		System.out.println("Expected result: [" + Arrays.toString(new String[] { value, language, datatype }) + "]");
		String[] splitted = converter.splitDatatypeLiteral(parameter);
		Stream.of(splitted).forEach(s -> System.out.println("	[" + s + "]"));
		Assert.assertEquals(3, splitted.length);
		Assert.assertEquals(value, splitted[0]);
		Assert.assertEquals(language, splitted[1]);
		Assert.assertEquals(datatype, splitted[2]);
	}

}
