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
 * Test method {@link Converter#splitClassAssertioin(String)} which split literal into 2 parts:
 * <ol>
 * <li>Individual template;
 * <li>Class template;
 * </ol>
 * <p>
 * Test cases:
 * <!-- @formatter:off -->
 * <table border="thin single black collapse">
 * 	<thead>
 * 		<tr><th rowspan="2">##  <th>Input     		<th>Output							<th rowspan="2">Comment
 * 		<tr>		<th>Parameter 					<th>Literal
 * 	<thead>
 * 	<tbody>
 *		<tr><td> 0 <td>"" 							<td>AssertionWrongFormatException	<td>test empty string
 *		<tr><td> 1 <td>"  " 						<td>AssertionWrongFormatException	<td>test empty string
 *		<tr><td colspan="4">
 *		<tr><td> 2 <td>"xxx" 						<td>AssertionWrongFormatException	<td>test 1 word
 *		<tr><td> 3 <td>" xxx" 						<td>AssertionWrongFormatException	<td>test 1 word with first space
 *		<tr><td> 4 <td>"^^rdf:XMLLiteral" 			<td>AssertionWrongFormatException	<td>test 1 word
 *		<tr><td> 5 <td>"&lt;RDF#XMLLiteral&gt;"		<td>AssertionWrongFormatException	<td>test 1 word
 *		<tr><td colspan="4">
 *		<tr><td> 6 <td>"xxx xxx" 					<td>AssertionWrongFormatException	<td>2 words with space
 *		<tr><td> 7 <td>"123 456" 					<td>AssertionWrongFormatException	<td>2 words with space
 *		<tr><td> 8 <td>"  123  456" 				<td>AssertionWrongFormatException	<td>2 words with first spaces
 *		<tr><td> 9 <td>"123  456  " 				<td>AssertionWrongFormatException	<td>2 words with last spaces
 *		<tr><td>10 <td>"  123  456    " 			<td>AssertionWrongFormatException	<td>2 words with surrounded by spaces
 *		<tr><td>11 <td>"123 456" 					<td>AssertionWrongFormatException	<td>2 words with space
 *		<tr><td>12 <td>"123\r\n456" 				<td>AssertionWrongFormatException	<td>2 words with caret return
 *		<tr><td>13 <td>"123\n456" 					<td>AssertionWrongFormatException	<td>2 words with new line
 *		<tr><td>14 <td>"\r\n123  456" 				<td>AssertionWrongFormatException	<td>2 words with first new line
 *		<tr><td>15 <td>"123  456\r\n" 				<td>AssertionWrongFormatException	<td>2 words with last new line
 *		<tr><td>16 <td>"\r\n123  456\r\n" 			<td>AssertionWrongFormatException	<td>2 words with surrounded by new lines
 *		<tr><td>17 <td>"123\t456" 					<td>AssertionWrongFormatException	<td>2 words with tabulation
 *		<tr><td>18 <td>"123	456" 					<td>AssertionWrongFormatException	<td>2 words with tabulation
 *		<tr><td>19 <td>"123\t\t\t456" 				<td>AssertionWrongFormatException	<td>2 words with multiple tabulations
 *		<tr><td>20 <td>"123			456" 			<td>AssertionWrongFormatException	<td>2 words with multiple tabulations
 *		<tr><td colspan="4">
 *		<tr><td>21 <td>"xxx xxx xxx" 				<td>{"xxx", "xxx", "xxx"}			<td>3 words with space
 *		<tr><td>22 <td>"123 456 789" 				<td>{"123", "456", "789"}			<td>3 words with space
 *		<tr><td>23 <td>"  123  456 789" 			<td>{"123", "456", "789"}			<td>3 words with first spaces
 *		<tr><td>24 <td>"123  456 789  " 			<td>{"123", "456", "789"}			<td>3 words with last spaces
 *		<tr><td>25 <td>"  123  456  789  " 			<td>{"123", "456", "789"}			<td>3 words with surrounded by spaces
 *		<tr><td>26 <td>"123 456 789" 				<td>{"123", "456", "789"}			<td>3 words with space
 *		<tr><td>27 <td>"123\r\n456\r\n789" 			<td>{"123", "456", "789"}			<td>3 words with caret return
 *		<tr><td>28 <td>"123\n456\n789" 				<td>{"123", "456", "789"}			<td>3 words with new line
 *		<tr><td>29 <td>"\r\n123  456 789" 			<td>{"123", "456", "789"}			<td>3 words with first new line
 *		<tr><td>30 <td>"123  456 789\r\n" 			<td>{"123", "456", "789"}			<td>3 words with last new line
 *		<tr><td>31 <td>"\r\n123  456 789\r\n" 		<td>{"123", "456", "789"}			<td>3 words with surrounded by new lines
 *		<tr><td>32 <td>"123\t456\t789" 				<td>{"123", "456", "789"}			<td>3 words with tabulation
 *		<tr><td>33 <td>"123	456	789" 				<td>{"123", "456", "789"}			<td>3 words with tabulation
 *		<tr><td>34 <td>"123\t\t\t456\t\t789" 		<td>{"123", "456", "789"}			<td>3 words with multiple tabulations
 *		<tr><td>35 <td>"123			456		789"	<td>{"123", "456", "789"}			<td>3 words with multiple tabulations
 *		<tr><td colspan="4">
 *		<tr><td>36 <td>"xxx xxx xxx xxx" 			<td>AssertionWrongFormatException	<td>4 words with space
 *		<tr><td>37 <td>"xxx\rxxx\rxxx\rxxx" 		<td>AssertionWrongFormatException	<td>4 words with caret return
 *		<tr><td>38 <td>"xxx\nxxx\nxxx\nxxx"			<td>AssertionWrongFormatException	<td>4 words with new line
 *		<tr><td>39 <td>"xxx\txxx\txxx\txxx"			<td>AssertionWrongFormatException	<td>4 words with new tabulation
 *		<tr><td>40 <td>"xxx	xxx	xxx	xxx"			<td>AssertionWrongFormatException	<td>4 words with new tabulation
 *		<tr><td>41 <td>"xxx\r\nxxx\txxx\txxx"		<td>AssertionWrongFormatException	<td>4 words with all
 *		<tr><td colspan="4">
 *		<tr><td>42 <td>"ns:some rdf:type owl:Class" <td>{"ns:some", "rdf:type", "owl:Class"}	<td>test : in literal
 *		<tr><td>43 <td>"xxx rdf:type &lt;OWL#Class&gt;" <td>{"xxx", "rdf:type", "&lt;OWL#Class&gt;"}<td>test < # > in literal
 *		<tr><td>44 <td>"&lt;htt://s@s:www.a#Class&gt; rdf:type xxx"<td>{"&lt;htt://s@s:www.a#Class&gt;", "rdf:type", "xxx"}<td>test @ in literal
 * 	</tbody>
 * </table>
 * <!-- @formatter:on -->
 * Used Namespaces:
 * <ul>
 * <li>RDF = http://www.w3.org/1999/02/22-rdf-syntax-ns#
 * <li>OWL = http://www.w3.org/2002/07/owl#
 * </ul>
 * 
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterSplitObjectPropertyAssertionTest {

	private final static String RDF = Namespaces.RDF.toString();
	private final static String OWL = Namespaces.OWL.toString();

	// @formatter:off
	// Name is not working because some of the test strings have \r\n symbols
	@Parameters//(name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] { 
			/* -------------------------------------------------------------------------------------------------------------
			 *| ##	| Input Parameter 				| Result								| Comment						|
			 *--------------------------------------------------------------------------------------------------------------*/
			// 0 words
			/*  0 */ { "", 							AssertionWrongFormatException.class },	// test empty string
			/*  1 */ { "  ", 						AssertionWrongFormatException.class },	// test empty string
			// 1 word
			/*  2 */ { "xxx", 						AssertionWrongFormatException.class },	// test 1 word
			/*  3 */ { " xxx", 						AssertionWrongFormatException.class },	// test 1 word with first space
			/*  4 */ { "^^rdf:XMLLiteral", 			AssertionWrongFormatException.class },	// test 1 word
			/*  5 */ { "<" + RDF + "XMLLiteral>", 	AssertionWrongFormatException.class },	// test 1 word
			// 2 words
			/*  6 */ { "xxx xxx", 					AssertionWrongFormatException.class },	// 2 words with space
			/*  7 */ { "123 456", 					AssertionWrongFormatException.class },	// 2 words with space
			/*  8 */ { "  123  456", 				AssertionWrongFormatException.class },	// 2 words with first spaces
			/*  9 */ { "123  456  ", 				AssertionWrongFormatException.class },	// 2 words with last spaces
			/* 10 */ { "  123  456    ", 			AssertionWrongFormatException.class },	// 2 words with surrounded by spaces
			/* 11 */ { "123 456", 					AssertionWrongFormatException.class },	// 2 words with space
			/* 12 */ { "123\r\n456", 				AssertionWrongFormatException.class },	// 2 words with caret return
			/* 13 */ { "123\n456", 					AssertionWrongFormatException.class },	// 2 words with new line
			/* 14 */ { "\r\n123  456", 				AssertionWrongFormatException.class },	// 2 words with first new line
			/* 15 */ { "123  456\r\n", 				AssertionWrongFormatException.class },	// 2 words with last new line
			/* 16 */ { "\r\n123  456\r\n", 			AssertionWrongFormatException.class },	// 2 words with surrounded by new lines
			/* 17 */ { "123\t456", 					AssertionWrongFormatException.class },	// 2 words with tabulation
			/* 18 */ { "123	456", 					AssertionWrongFormatException.class },	// 2 words with tabulation
			/* 19 */ { "123\t\t\t456", 				AssertionWrongFormatException.class },	// 2 words with multiple tabulations
			/* 20 */ { "123			456", 			AssertionWrongFormatException.class },	// 2 words with multiple tabulations
			// 3 words
			/* 21 */ { "xxx xxx xxx", 				new String[] {"xxx", "xxx", "xxx"} },		// 3 words with space
			/* 22 */ { "123 456 789", 				new String[] {"123", "456", "789"} },	// 3 words with space
			/* 23 */ { "  123  456 789", 			new String[] {"123", "456", "789"} },	// 3 words with first spaces
			/* 24 */ { "123  456 789  ", 			new String[] {"123", "456", "789"} },	// 3 words with last spaces
			/* 25 */ { "  123  456  789  ", 		new String[] {"123", "456", "789"} },	// 3 words with surrounded by spaces
			/* 26 */ { "123 456 789", 				new String[] {"123", "456", "789"} },	// 3 words with space
			/* 27 */ { "123\r\n456\r\n789", 		new String[] {"123", "456", "789"} },	// 3 words with caret return
			/* 28 */ { "123\n456\n789", 			new String[] {"123", "456", "789"} },	// 3 words with new line
			/* 29 */ { "\r\n123  456 789", 			new String[] {"123", "456", "789"} },	// 3 words with first new line
			/* 30 */ { "123  456 789\r\n", 			new String[] {"123", "456", "789"} },	// 3 words with last new line
			/* 31 */ { "\r\n123  456 789\r\n", 		new String[] {"123", "456", "789"} },	// 3 words with surrounded by new lines
			/* 32 */ { "123\t456\t789", 			new String[] {"123", "456", "789"} },	// 3 words with tabulation
			/* 33 */ { "123	456	789", 				new String[] {"123", "456", "789"} },	// 3 words with tabulation
			/* 34 */ { "123\t\t\t456\t\t789", 		new String[] {"123", "456", "789"} },	// 3 words with multiple tabulations
			/* 35 */ { "123			456		789",	new String[] {"123", "456", "789"} },	// 3 words with multiple tabulations
			// 4 words
			/* 36 */ { "xxx xxx xxx xxx", 			AssertionWrongFormatException.class },	// 4 words with space         
			/* 37 */ { "xxx\rxxx\rxxx\rxxx", 		AssertionWrongFormatException.class },	// 4 words with caret return  
			/* 38 */ { "xxx\nxxx\nxxx\nxxx", 		AssertionWrongFormatException.class },	// 4 words with new line      
			/* 39 */ { "xxx\txxx\txxx\txxx", 		AssertionWrongFormatException.class },	// 4 words with new tabulation
			/* 40 */ { "xxx	xxx	xxx	xxx", 			AssertionWrongFormatException.class },	// 4 words with new tabulation
			/* 41 */ { "xxx\r\nxxx\txxx\txxx", 		AssertionWrongFormatException.class },	// 4 words all
			// Special characters
			/* 42 */ { "ns:some rdf:type owl:Class", new String[] {"ns:some", "rdf:type", "owl:Class"} },// test : in literal
			/* 43 */ { "xxx rdf:type <" + OWL + "Class>", new String[] {"xxx", "rdf:type", "<" + OWL + "Class>"} },// test < # > in literal
			/* 44 */ { "<htt://s@s:www.a#Class> rdf:type  xxx",new String[] {"<htt://s@s:www.a#Class>", "rdf:type", "xxx"} },// test @ in literal
		});
	}
	// @formatter:on

	@Parameter(0)
	public String parameter;

	@Parameter(1)
	public Object result;

	Converter converter = new Converter();

	@Test
	public void anyEmptyLiteralShouldThrow() {
		System.out.println("[" + parameter + "]");
		try {
			String[] splitted = converter.splitObjectPropertyAssertioin(parameter);
			Stream.of(splitted).forEach(s -> System.out.println("	[" + s + "]"));
			if (result.getClass().isArray()) {
				String[] array = (String[]) result;
				Assert.assertEquals(3, splitted.length);
				Assert.assertArrayEquals(array, splitted);
			} else {
				Assert.fail("Expected [" + result + "]");
			}
		} catch (Exception e) {
			if (result instanceof Class<?>) {
				Class<?> clazz = (Class<?>) result;
				Assert.assertEquals(clazz, e.getClass());
			} else {
				Assert.fail("Expected [" + result + "], but was: [" + e.getMessage() + "]");
			}
		}
	}

}
