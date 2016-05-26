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
 *		<tr><td> 6 <td>"xxx xxx" 					<td>{"xxx", "xxx"}					<td>2 words with space
 *		<tr><td> 7 <td>"123 456" 					<td>{"123", "456"}					<td>2 words with space
 *		<tr><td> 8 <td>"  123  456" 				<td>{"123", "456"}					<td>2 words with first spaces
 *		<tr><td> 9 <td>"123  456  " 				<td>{"123", "456"}					<td>2 words with last spaces
 *		<tr><td>10 <td>"  123  456    " 			<td>{"123", "456"}					<td>2 words with surrounded by spaces
 *		<tr><td>11 <td>"123 456" 					<td>{"123", "456"}					<td>2 words with space
 *		<tr><td>12 <td>"123\r\n456" 				<td>{"123", "456"}					<td>2 words with caret return
 *		<tr><td>13 <td>"123\n456" 					<td>{"123", "456"}					<td>2 words with new line
 *		<tr><td>14 <td>"\r\n123  456" 				<td>{"123", "456"}					<td>2 words with first new line
 *		<tr><td>15 <td>"123  456\r\n" 				<td>{"123", "456"}					<td>2 words with last new line
 *		<tr><td>16 <td>"\r\n123  456\r\n" 			<td>{"123", "456"}					<td>2 words with surrounded by new lines
 *		<tr><td>17 <td>"123\t456" 					<td>{"123", "456"}					<td>2 words with tabulation
 *		<tr><td>18 <td>"123	456" 					<td>{"123", "456"}					<td>2 words with tabulation
 *		<tr><td>19 <td>"123\t\t\t456" 				<td>{"123", "456"}					<td>2 words with multiple tabulations
 *		<tr><td>20 <td>"123			456" 			<td>{"123", "456"}					<td>2 words with multiple tabulations
 *		<tr><td colspan="4">
 *		<tr><td>21 <td>"xxx xxx xxx" 				<td>AssertionWrongFormatException	<td>3 words with space
 *		<tr><td>22 <td>"123 456 789" 				<td>AssertionWrongFormatException	<td>3 words with space
 *		<tr><td>23 <td>"  123  456 789" 			<td>AssertionWrongFormatException	<td>3 words with first spaces
 *		<tr><td>24 <td>"123  456 789  " 			<td>AssertionWrongFormatException	<td>3 words with last spaces
 *		<tr><td>25 <td>"  123  456  789  " 			<td>AssertionWrongFormatException	<td>3 words with surrounded by spaces
 *		<tr><td>26 <td>"123 456 789" 				<td>AssertionWrongFormatException	<td>3 words with space
 *		<tr><td>27 <td>"123\r\n456\r\n789" 			<td>AssertionWrongFormatException	<td>3 words with caret return
 *		<tr><td>28 <td>"123\n456\n789" 				<td>AssertionWrongFormatException	<td>3 words with new line
 *		<tr><td>29 <td>"\r\n123  456 789" 			<td>AssertionWrongFormatException	<td>3 words with first new line
 *		<tr><td>30 <td>"123  456 789\r\n" 			<td>AssertionWrongFormatException	<td>3 words with last new line
 *		<tr><td>31 <td>"\r\n123  456 789\r\n" 		<td>AssertionWrongFormatException	<td>3 words with surrounded by new lines
 *		<tr><td>32 <td>"123\t456\t789" 				<td>AssertionWrongFormatException	<td>3 words with tabulation
 *		<tr><td>33 <td>"123	456	789" 				<td>AssertionWrongFormatException	<td>3 words with tabulation
 *		<tr><td>34 <td>"123\t\t\t456\t\t789" 		<td>AssertionWrongFormatException	<td>3 words with multiple tabulations
 *		<tr><td>35 <td>"123			456		789"	<td>AssertionWrongFormatException	<td>3 words with multiple tabulations
 *		<tr><td colspan="4">
 *		<tr><td>36 <td>"ns:some owl:Class" 			<td>{"ns:some", "owl:Class"}		<td>test : in literal
 *		<tr><td>37 <td>"xxx &lt;OWL#Class&gt;" 		<td>{"xxx", "&lt;OWL#Class&gt;"}	<td>test < # > in literal
 *		<tr><td>38 <td>"&lt;htt://s@s:www.a#Class&gt; xxx"<td>{"&lt;htt://s@s:www.a#Class&gt;", "xxx"}<td>test @ in literal
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
public class ConverterSplitClassAssertionTest {

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
			/*  6 */ { "xxx xxx", 					new String[] {"xxx", "xxx"} },			// 2 words with space
			/*  7 */ { "123 456", 					new String[] {"123", "456"} },			// 2 words with space
			/*  8 */ { "  123  456", 				new String[] {"123", "456"} },			// 2 words with first spaces
			/*  9 */ { "123  456  ", 				new String[] {"123", "456"} },			// 2 words with last spaces
			/* 10 */ { "  123  456    ", 			new String[] {"123", "456"} },			// 2 words with surrounded by spaces
			/* 11 */ { "123 456", 					new String[] {"123", "456"} },			// 2 words with space
			/* 12 */ { "123\r\n456", 				new String[] {"123", "456"} },			// 2 words with caret return
			/* 13 */ { "123\n456", 					new String[] {"123", "456"} },			// 2 words with new line
			/* 14 */ { "\r\n123  456", 				new String[] {"123", "456"} },			// 2 words with first new line
			/* 15 */ { "123  456\r\n", 				new String[] {"123", "456"} },			// 2 words with last new line
			/* 16 */ { "\r\n123  456\r\n", 			new String[] {"123", "456"} },			// 2 words with surrounded by new lines
			/* 17 */ { "123\t456", 					new String[] {"123", "456"} },			// 2 words with tabulation
			/* 18 */ { "123	456", 					new String[] {"123", "456"} },			// 2 words with tabulation
			/* 19 */ { "123\t\t\t456", 				new String[] {"123", "456"} },			// 2 words with multiple tabulations
			/* 20 */ { "123			456", 			new String[] {"123", "456"} },			// 2 words with multiple tabulations
			// 3 words
			/* 21 */ { "xxx xxx xxx", 				AssertionWrongFormatException.class },	// 3 words with space
			/* 22 */ { "123 456 789", 				AssertionWrongFormatException.class },	// 3 words with space
			/* 23 */ { "  123  456 789", 			AssertionWrongFormatException.class },	// 3 words with first spaces
			/* 24 */ { "123  456 789  ", 			AssertionWrongFormatException.class },	// 3 words with last spaces
			/* 25 */ { "  123  456  789  ", 		AssertionWrongFormatException.class },	// 3 words with surrounded by spaces
			/* 26 */ { "123 456 789", 				AssertionWrongFormatException.class },	// 3 words with space
			/* 27 */ { "123\r\n456\r\n789", 		AssertionWrongFormatException.class },	// 3 words with caret return
			/* 28 */ { "123\n456\n789", 			AssertionWrongFormatException.class },	// 3 words with new line
			/* 29 */ { "\r\n123  456 789", 			AssertionWrongFormatException.class },	// 3 words with first new line
			/* 30 */ { "123  456 789\r\n", 			AssertionWrongFormatException.class },	// 3 words with last new line
			/* 31 */ { "\r\n123  456 789\r\n", 		AssertionWrongFormatException.class },	// 3 words with surrounded by new lines
			/* 32 */ { "123\t456\t789", 			AssertionWrongFormatException.class },	// 3 words with tabulation
			/* 33 */ { "123	456	789", 				AssertionWrongFormatException.class },	// 3 words with tabulation
			/* 34 */ { "123\t\t\t456\t\t789", 		AssertionWrongFormatException.class },	// 3 words with multiple tabulations
			/* 35 */ { "123			456		789",	AssertionWrongFormatException.class },	// 3 words with multiple tabulations
			// Special characters
			/* 36 */ { "ns:some owl:Class", 		new String[] {"ns:some", "owl:Class"} },// test : in literal
			/* 37 */ { "xxx <" + OWL + "Class>", 	new String[] {"xxx", "<" + OWL + "Class>"} },// test < # > in literal
			/* 38 */ { "<htt://s@s:www.a#Class> xxx",new String[] {"<htt://s@s:www.a#Class>", "xxx"} },// test @ in literal
		});
	}
	// @formatter:on

	@Parameter(0)
	public String parameter;

	@Parameter(1)
	public Object result;

	private static int i = 0;

	Converter converter = new Converter();

	@Test
	public void testCase() {
		System.out.println();
		// @formatter:off
		System.out.println("--------------------------- " + this.getClass().getSimpleName() + " [Test Case " + i++ + "] ---------------------------");
		// @formatter:on
		System.out.println("Input parameter: [" + parameter + "]");
		System.out.println("Expected result: [" + toString(result) + "]");
		try {
			String[] splitted = converter.splitClassAssertioin(parameter);
			Stream.of(splitted).forEach(s -> System.out.println("	[" + s + "]"));
			if (result.getClass().isArray()) {
				String[] array = (String[]) result;
				Assert.assertEquals(2, splitted.length);
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

	private String toString(Object object) {
		if (object.getClass().isArray()) {
			return Arrays.toString((String[]) object);
		} else {
			return object.toString();
		}
	}

}
