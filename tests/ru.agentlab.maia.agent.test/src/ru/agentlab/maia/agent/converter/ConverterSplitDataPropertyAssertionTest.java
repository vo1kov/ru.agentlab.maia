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
 * Test method {@link Converter#splitDataPropertyAssertioin(String)} which split
 * literal into 3 parts:
 * <ol>
 * <li>OWLIndividual template;
 * <li>OWLDataProperty template;
 * <li>OWLLiteral template;
 * </ol>
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterSplitDataPropertyAssertionTest {

	private final static String RDF = Namespaces.RDF.toString();
	private final static String OWL = Namespaces.OWL.toString();

	// @formatter:off
	// Name is not working because some of the test strings have \r\n symbols
	@Parameters//(name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] { 
			/* ---------------------------------------------------------------------------------------------------------------------
			 *| ##	| Input Parameter 				| Result										| Comment						|
			 *----------------------------------------------------------------------------------------------------------------------*/
			// 0 words
			/*  0 */ { "", 							AssertionWrongFormatException.class },			// test empty string
			/*  1 */ { "  ", 						AssertionWrongFormatException.class },			// test empty string
			// 1 word
			/*  2 */ { "xxx", 						AssertionWrongFormatException.class },			// test 1 word
			/*  3 */ { " xxx", 						AssertionWrongFormatException.class },			// test 1 word with first space
			/*  4 */ { "^^rdf:XMLLiteral", 			AssertionWrongFormatException.class },			// test 1 word
			/*  5 */ { "<" + RDF + "XMLLiteral>", 	AssertionWrongFormatException.class },			// test 1 word
			// 2 words
			/*  6 */ { "xxx xxx", 					AssertionWrongFormatException.class },			// 2 words with space
			/*  7 */ { "123 456", 					AssertionWrongFormatException.class },			// 2 words with space
			/*  8 */ { "  123  456", 				AssertionWrongFormatException.class },			// 2 words with first spaces
			/*  9 */ { "123  456  ", 				AssertionWrongFormatException.class },			// 2 words with last spaces
			/* 10 */ { "  123  456    ", 			AssertionWrongFormatException.class },			// 2 words with surrounded by spaces
			/* 11 */ { "123 456", 					AssertionWrongFormatException.class },			// 2 words with space
			/* 12 */ { "123\r\n456", 				AssertionWrongFormatException.class },			// 2 words with caret return
			/* 13 */ { "123\n456", 					AssertionWrongFormatException.class },			// 2 words with new line
			/* 14 */ { "\r\n123  456", 				AssertionWrongFormatException.class },			// 2 words with first new line
			/* 15 */ { "123  456\r\n", 				AssertionWrongFormatException.class },			// 2 words with last new line
			/* 16 */ { "\r\n123  456\r\n", 			AssertionWrongFormatException.class },			// 2 words with surrounded by new lines
			/* 17 */ { "123\t456", 					AssertionWrongFormatException.class },			// 2 words with tabulation
			/* 18 */ { "123	456", 					AssertionWrongFormatException.class },			// 2 words with tabulation
			/* 19 */ { "123\t\t\t456", 				AssertionWrongFormatException.class },			// 2 words with multiple tabulations
			/* 20 */ { "123			456", 			AssertionWrongFormatException.class },			// 2 words with multiple tabulations
			// 3 words
			/* 21 */ { "xxx xxx xxx", 				new String[] {"xxx", "xxx", "xxx"} },			// 3 words with space
			/* 22 */ { "123 456 789", 				new String[] {"123", "456", "789"} },			// 3 words with space
			/* 23 */ { "  123  456 789", 			new String[] {"123", "456", "789"} },			// 3 words with first spaces
			/* 24 */ { "123  456 789  ", 			new String[] {"123", "456", "789  "} },			// 3 words with last spaces
			/* 25 */ { "  123  456  789  ", 		new String[] {"123", "456", "789  "} },			// 3 words with surrounded by spaces
			/* 26 */ { "123 456 789", 				new String[] {"123", "456", "789"} },			// 3 words with space
			/* 27 */ { "123\r\n456\r\n789", 		new String[] {"123", "456", "789"} },			// 3 words with caret return
			/* 28 */ { "123\n456\n789", 			new String[] {"123", "456", "789"} },			// 3 words with new line
			/* 29 */ { "\r\n123  456 789", 			new String[] {"123", "456", "789"} },			// 3 words with first new line
			/* 30 */ { "123  456 789\r\n", 			new String[] {"123", "456", "789\r\n"} },		// 3 words with last new line
			/* 31 */ { "\r\n123  456 789\r\n", 		new String[] {"123", "456", "789\r\n"} },		// 3 words with surrounded by new lines
			/* 32 */ { "123\t456\t789", 			new String[] {"123", "456", "789"} },			// 3 words with tabulation
			/* 33 */ { "123	456	789", 				new String[] {"123", "456", "789"} },			// 3 words with tabulation
			/* 34 */ { "123\t\t\t456\t\t789", 		new String[] {"123", "456", "789"} },			// 3 words with multiple tabulations
			/* 35 */ { "123			456		789",	new String[] {"123", "456", "789"} },			// 3 words with multiple tabulations
			// 4 words
			/* 21 */ { "xxx xxx xxx xxx", 			new String[] {"xxx", "xxx", "xxx xxx"} },		// 4 words with space
			/* 22 */ { "123 456 789 012", 			new String[] {"123", "456", "789 012"} },		// 4 words with space
			/* 23 */ { "  123  456 789 012", 		new String[] {"123", "456", "789 012"} },		// 4 words with first spaces
			/* 24 */ { "123  456 789 012  ", 		new String[] {"123", "456", "789 012  "} },		// 4 words with last spaces
			/* 25 */ { "  123  456  789 012  ", 	new String[] {"123", "456", "789 012  "} },		// 4 words with surrounded by spaces
			/* 26 */ { "123 456 789 012", 			new String[] {"123", "456", "789 012"} },		// 4 words with space
			/* 27 */ { "123\r\n456\r\n789\r\n012", 	new String[] {"123", "456", "789\r\n012"} },	// 4 words with caret return
			/* 28 */ { "123\n456\n789\n012", 		new String[] {"123", "456", "789\n012"} },		// 4 words with new line
			/* 29 */ { "\r\n123  456 789	012", 	new String[] {"123", "456", "789	012"} },	// 4 words with first new line
			/* 30 */ { "123  456 789 012\r\n", 		new String[] {"123", "456", "789 012\r\n"} },	// 4 words with last new line
			/* 31 */ { "\r\n123  456 789 012\r\n", 	new String[] {"123", "456", "789 012\r\n"} },	// 4 words with surrounded by new lines
			/* 32 */ { "123\t456\t789\t012", 		new String[] {"123", "456", "789\t012"} },		// 4 words with tabulation
			/* 33 */ { "123	456	789	012", 			new String[] {"123", "456", "789	012"} },	// 4 words with tabulation
			/* 34 */ { "123\t\t\t456\t\t789\t\t012",new String[] {"123", "456", "789\t\t012"} },	// 4 words with multiple tabulations
			/* 35 */ { "123		456		789 012",	new String[] {"123", "456", "789 012"} },		// 4 words with multiple tabulations
			// More words
			/* 36 */ { "xxx xxx xxx xxx", 			new String[] {"xxx", "xxx", "xxx xxx"} },		// more words with space         
			/* 37 */ { "xxx\rxxx\rxxx\rxxx", 		new String[] {"xxx", "xxx", "xxx\rxxx"} },		// more words with caret return  
			/* 38 */ { "xxx\nxxx\nxxx\nxxx", 		new String[] {"xxx", "xxx", "xxx\nxxx"} },		// more words with new line      
			/* 39 */ { "xxx\txxx\txxx\txxx", 		new String[] {"xxx", "xxx", "xxx\txxx"} },		// more words with new tabulation
			/* 40 */ { "xxx	xxx	xxx	xxx", 			new String[] {"xxx", "xxx", "xxx	xxx"} },	// more words with new tabulation
			/* 41 */ { "xxx\r\nxxx\txxx\txxx", 		new String[] {"xxx", "xxx", "xxx\txxx"} },		// more words all
			// Special characters
			/* 42 */ { "ns:some rdf:type owl:Class", new String[] {"ns:some", "rdf:type", "owl:Class"} },// test : in literal
			/* 43 */ { "xxx rdf:type <" + OWL + "Class>", new String[] {"xxx", "rdf:type", "<" + OWL + "Class>"} },// test < # > in literal
			/* 44 */ { "<htt://s@s:www.a#Class> rdf:type  xxx",new String[] {"<htt://s@s:www.a#Class>", "rdf:type", "xxx"} },// test @ in literal
			/* 42 */ { "ns:some rdf:type a b c d^^xsd:string", new String[] {"ns:some", "rdf:type", "a b c d^^xsd:string"} },// test multiple words
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
	public void anyEmptyLiteralShouldThrow() {
		System.out.println("--------------------------- Test Case " + i++ + " ---------------------------");
		System.out.println("Input parameter: " + parameter);
		System.out.println("Expected result: " + toString(result));
		try {
			String[] splitted = converter.splitDataPropertyAssertioin(parameter);
			Stream.of(splitted).forEach(s -> System.out.println("	[" + s + "]"));
			if (result.getClass().isArray()) {
				String[] array = (String[]) result;
				Assert.assertEquals(3, splitted.length);
				Assert.assertArrayEquals(array, splitted);
			} else {
				Assert.fail("Expected [" + result + "], but was: [" + Arrays.toString(splitted) + "]");
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
