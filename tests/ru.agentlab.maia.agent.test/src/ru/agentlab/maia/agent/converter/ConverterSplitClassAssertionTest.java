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
 * 		<tr><th rowspan="2">##  <th>Input     		<th>Output						<th rowspan="2">Comment
 * 		<tr>		<th>Parameter 					<th>Literal
 * 	<thead>
 * 	<tbody>
 *		<tr><td> 0 <td>"" 							<td>AnnotationFormatException	<td>test empty string
 *		<tr><td> 1 <td>"  " 						<td>AnnotationFormatException	<td>test empty string
 *		<tr><td colspan="4">
 *		<tr><td> 2 <td>"xxx" 						<td>AnnotationFormatException	<td>test 1 word
 *		<tr><td> 3 <td>" xxx" 						<td>AnnotationFormatException	<td>test 1 word with first space
 *		<tr><td> 4 <td>"^^rdf:XMLLiteral" 			<td>AnnotationFormatException	<td>test 1 word
 *		<tr><td> 5 <td>"&lt;RDF#XMLLiteral&gt;"		<td>AnnotationFormatException	<td>test 1 word
 *		<tr><td colspan="4">
 *		<tr><td> 6 <td>"xxx xxx xxx" 				<td>AnnotationFormatException	<td>3 words with space         
 *		<tr><td> 7 <td>"xxx\rxxx\rxxx" 				<td>AnnotationFormatException	<td>3 words with caret return  
 *		<tr><td> 8 <td>"xxx\nxxx\nxxx" 				<td>AnnotationFormatException	<td>3 words with new line      
 *		<tr><td> 9 <td>"xxx\txxx\txxx" 				<td>AnnotationFormatException	<td>3 words with new tabulation
 *		<tr><td>10 <td>"xxx	xxx	xxx" 				<td>AnnotationFormatException	<td>3 words with new tabulation
 *		<tr><td>11 <td>"xxx\r\nxxx\txxx" 			<td>AnnotationFormatException	<td>3 words all
 *		<tr><td colspan="4">
 *		<tr><td>12 <td>"xxx xxx" 					<td>{"xxx", "xxx"}				<td>2 words with space
 *		<tr><td>13 <td>"123 456" 					<td>{"123", "456"}				<td>2 words with space
 *		<tr><td>14 <td>"  123  456" 				<td>{"123", "456"}				<td>2 words with first spaces
 *		<tr><td>15 <td>"123  456  " 				<td>{"123", "456"}				<td>2 words with last spaces
 *		<tr><td>16 <td>"  123  456    " 			<td>{"123", "456"}				<td>2 words with surrounded by spaces
 *		<tr><td>17 <td>"123 456" 					<td>{"123", "456"}				<td>2 words with space
 *		<tr><td>18 <td>"123\r\n456" 				<td>{"123", "456"}				<td>2 words with caret return
 *		<tr><td>19 <td>"123\n456" 					<td>{"123", "456"}				<td>2 words with new line
 *		<tr><td>20 <td>"\r\n123  456" 				<td>{"123", "456"}				<td>2 words with first new line
 *		<tr><td>21 <td>"123  456\r\n" 				<td>{"123", "456"}				<td>2 words with last new line
 *		<tr><td>22 <td>"\r\n123  456\r\n" 			<td>{"123", "456"}				<td>2 words with surrounded by new lines
 *		<tr><td>23 <td>"123\t456" 					<td>{"123", "456"}				<td>2 words with tabulation
 *		<tr><td>24 <td>"123	456" 					<td>{"123", "456"}				<td>2 words with tabulation
 *		<tr><td>25 <td>"123\t\t\t456" 				<td>{"123", "456"}				<td>2 words with multiple tabulations
 *		<tr><td>26 <td>"123			456" 			<td>{"123", "456"}				<td>2 words with multiple tabulations
 *		<tr><td colspan="4">
 *		<tr><td>27 <td>"ns:some owl:Class" 			<td>{"ns:some", "owl:Class"}	<td>test : in literal
 *		<tr><td>28 <td>"xxx &lt;OWL#Class&gt;" 		<td>{"xxx", "&lt;OWL#Class&gt;"}<td>test < # > in literal
 *		<tr><td>29 <td>"&lt;htt://s@s:www.a#Class&gt; xxx"<td>{"&lt;htt://s@s:www.a#Class&gt;", "xxx"}<td>test @ in literal
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
			/*  0 */ { "", 							AnnotationFormatException.class },		// test empty string
			/*  1 */ { "  ", 						AnnotationFormatException.class },		// test empty string
			// 1 word
			/*  2 */ { "xxx", 						AnnotationFormatException.class },		// test 1 word
			/*  3 */ { " xxx", 						AnnotationFormatException.class },		// test 1 word with first space
			/*  4 */ { "^^rdf:XMLLiteral", 			AnnotationFormatException.class },		// test 1 word
			/*  5 */ { "<" + RDF + "XMLLiteral>", 	AnnotationFormatException.class },		// test 1 word
			// 3 words
			/*  6 */ { "xxx xxx xxx", 				AnnotationFormatException.class },		// 3 words with space         
			/*  7 */ { "xxx\rxxx\rxxx", 			AnnotationFormatException.class },		// 3 words with caret return  
			/*  8 */ { "xxx\nxxx\nxxx", 			AnnotationFormatException.class },		// 3 words with new line      
			/*  9 */ { "xxx\txxx\txxx", 			AnnotationFormatException.class },		// 3 words with new tabulation
			/* 10 */ { "xxx	xxx	xxx", 				AnnotationFormatException.class },		// 3 words with new tabulation
			/* 11 */ { "xxx\r\nxxx\txxx", 			AnnotationFormatException.class },		// 3 words all
			// 2 words
			/* 12 */ { "xxx xxx", 					new String[] {"xxx", "xxx"} },			// 2 words with space
			/* 13 */ { "123 456", 					new String[] {"123", "456"} },			// 2 words with space
			/* 14 */ { "  123  456", 				new String[] {"123", "456"} },			// 2 words with first spaces
			/* 15 */ { "123  456  ", 				new String[] {"123", "456"} },			// 2 words with last spaces
			/* 16 */ { "  123  456    ", 			new String[] {"123", "456"} },			// 2 words with surrounded by spaces
			/* 17 */ { "123 456", 					new String[] {"123", "456"} },			// 2 words with space
			/* 18 */ { "123\r\n456", 				new String[] {"123", "456"} },			// 2 words with caret return
			/* 19 */ { "123\n456", 					new String[] {"123", "456"} },			// 2 words with new line
			/* 20 */ { "\r\n123  456", 				new String[] {"123", "456"} },			// 2 words with first new line
			/* 21 */ { "123  456\r\n", 				new String[] {"123", "456"} },			// 2 words with last new line
			/* 22 */ { "\r\n123  456\r\n", 			new String[] {"123", "456"} },			// 2 words with surrounded by new lines
			/* 23 */ { "123\t456", 					new String[] {"123", "456"} },			// 2 words with tabulation
			/* 24 */ { "123	456", 					new String[] {"123", "456"} },			// 2 words with tabulation
			/* 25 */ { "123\t\t\t456", 				new String[] {"123", "456"} },			// 2 words with multiple tabulations
			/* 26 */ { "123			456", 			new String[] {"123", "456"} },			// 2 words with multiple tabulations
			// Special characters
			/* 27 */ { "ns:some owl:Class", 		new String[] {"ns:some", "owl:Class"} },// test : in literal
			/* 28 */ { "xxx <" + OWL + "Class>", 	new String[] {"xxx", "<" + OWL + "Class>"} },// test < # > in literal
			/* 29 */ { "<htt://s@s:www.a#Class> xxx",new String[] {"<htt://s@s:www.a#Class>", "xxx"} },// test @ in literal
		});
	}
	// @formatter:on

	@Parameter(0)
	public String parameter;

	@Parameter(1)
	public Object result;

	@Test
	public void anyEmptyLiteralShouldThrow() {
		System.out.println("[" + parameter + "]");
		try {
			String[] splitted = Converter.splitClassAssertioin(parameter);
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

}
