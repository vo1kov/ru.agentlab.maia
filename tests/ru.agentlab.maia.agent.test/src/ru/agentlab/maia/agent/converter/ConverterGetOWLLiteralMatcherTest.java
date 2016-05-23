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

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.vocab.Namespaces;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralMatcher;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterGetOWLLiteralMatcherTest {

	private static OWLOntologyManager manager = OWLManager.createConcurrentOWLOntologyManager();

	private static OWLDataFactory factory = manager.getOWLDataFactory();

	final static String RDF = Namespaces.RDF.toString();
	final static String RDFS = Namespaces.RDFS.toString();
	final static String OWL = Namespaces.OWL.toString();
	final static String XSD = Namespaces.XSD.toString();

	// @formatter:off
	// Name is not working because some of the test strings have \r\n symbols
	@Parameters//(name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] { 
			/* ---------------------------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 							| Result Literal														| Comment					|
			  ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
			// rdf:XMLLiteral
			/*  0 */ 	{ "^^rdf:XMLLiteral", 						factory.getOWLLiteral("", OWL2Datatype.RDF_XML_LITERAL) },				// test empty string
			/*  1 */ 	{ "true^^rdf:XMLLiteral", 					factory.getOWLLiteral("true", OWL2Datatype.RDF_XML_LITERAL) },
			/*  2 */ 	{ "2.3^^rdf:XMLLiteral", 					factory.getOWLLiteral("2.3", OWL2Datatype.RDF_XML_LITERAL) },
			/*  3 */ 	{ "test string^^rdf:XMLLiteral", 			factory.getOWLLiteral("test string", OWL2Datatype.RDF_XML_LITERAL) },
			/*  4 */ 	{ "test string^^<" + RDF + "XMLLiteral>", 	factory.getOWLLiteral("test string", OWL2Datatype.RDF_XML_LITERAL) }, 	// test full name
			// rdfs:Literal
			/*  5 */ 	{ "^^rdfs:Literal", 						factory.getOWLLiteral("", OWL2Datatype.RDFS_LITERAL) },
			/*  6 */ 	{ "test string^^rdfs:Literal",				factory.getOWLLiteral("test string", OWL2Datatype.RDFS_LITERAL) },
			/*  7 */ 	{ "test string^^<" + RDFS + "Literal>", 	factory.getOWLLiteral("test string", OWL2Datatype.RDFS_LITERAL) }, 		// test full name
			// rdf:PlainLiteral
			/*  8 */ 	{ "^^rdf:PlainLiteral", 					factory.getOWLLiteral("", OWL2Datatype.RDF_PLAIN_LITERAL) }, 			// test empty string
			/*  8 */ 	{ "^^rdf:PlainLiteral", 					factory.getOWLLiteral("", OWL2Datatype.RDF_PLAIN_LITERAL) }, 			// test empty string
			/*  9 */ 	{ "test string^^rdf:PlainLiteral",			factory.getOWLLiteral("test string", OWL2Datatype.RDF_PLAIN_LITERAL) },
			/* 10 */ 	{ "test string^^<" + RDF + "PlainLiteral>",	factory.getOWLLiteral("test string", OWL2Datatype.RDF_PLAIN_LITERAL) },	// test full name
			/* 11 */ 	{ "Padre de familia@es", 					factory.getOWLLiteral("Padre de familia", "es") }, 						// test language tag
			/* 12 */ 	{ "Padre de familia@es^^rdf:PlainLiteral",	factory.getOWLLiteral("Padre de familia", "es") }, 						// test language tag
			/* 13 */ 	{ "Family Guy@", 							factory.getOWLLiteral("Family Guy", "") }, 								// test language tag
			/* 14 */ 	{ "Family Guy@en", 							factory.getOWLLiteral("Family Guy", "en") }, 							// test language tag
			/* 15 */ 	{ "Тестовая строка@ru^^xsd:string", 		factory.getOWLLiteral("Тестовая строка@ru") }, 							// test language tag
			/* 16 */ 	{ "Тестовая строка@ru^^xsd:PlainLiteral",	factory.getOWLLiteral("Тестовая строка", "ru") }, 						// test language tag
			/* 16 */ 	{ "Тестовая@строка@ru^^xsd:PlainLiteral",	factory.getOWLLiteral("Тестовая@строка", "ru") }, 						// test language tag
			// owl:real
			/* 17 */ 	{ "^^owl:real", 							factory.getOWLLiteral("", OWL2Datatype.OWL_REAL) },						// test empty string
			/* 18 */ 	{ "test string^^owl:real",					factory.getOWLLiteral("test string", OWL2Datatype.OWL_REAL) },
			/* 19 */ 	{ "test string^^<" + OWL + "real>", 		factory.getOWLLiteral("test string", OWL2Datatype.OWL_REAL) }, 			// test full name
			// owl:rational
			/* 20 */ 	{ "2/3^^owl:rational",						factory.getOWLLiteral("2/3", OWL2Datatype.OWL_RATIONAL) },
			/* 21 */ 	{ "2 / 3^^owl:rational",					factory.getOWLLiteral("2/3", OWL2Datatype.OWL_RATIONAL) },
			/* 22 */ 	{ "-2 /3^^owl:rational",					factory.getOWLLiteral("-2/3", OWL2Datatype.OWL_RATIONAL) },
			/* 23 */ 	{ "+2/ 3^^owl:rational",					factory.getOWLLiteral("+2/3", OWL2Datatype.OWL_RATIONAL) },
			/* 24 */ 	{ "45/7^^<" + OWL + "rational>", 			factory.getOWLLiteral("45/7", OWL2Datatype.OWL_RATIONAL) }, 			// test full name
			/* 25 */ 	{ "2^^owl:rational",						AnnotationFormatException.class },										// test empty string
			/* 26 */ 	{ "2.5/3.21^^owl:rational",					AnnotationFormatException.class },										// test empty string
			/* 27 */ 	{ "^^owl:rational", 						AnnotationFormatException.class },										// test empty string
			// xsd:string
			/*  0 */ 	{ "", 										factory.getOWLLiteral("") },											// test empty string
			/*  0 */ 	{ "^^xsd:string", 							factory.getOWLLiteral("") },
			/*  0 */ 	{ "test string^^xsd:string", 				factory.getOWLLiteral("test string") },
			/*  0 */ 	{ "test \rstring^^xsd:string", 				factory.getOWLLiteral("test \rstring") },
			/*  0 */ 	{ "test \nstring^^xsd:string", 				factory.getOWLLiteral("test \nstring") },
			/*  0 */ 	{ "test\tstring^^xsd:string", 				factory.getOWLLiteral("test\tstring") },
			/*  0 */ 	{ "^^xsd:string", 							AnnotationFormatException.class },
			/*  0 */ 	{ "test string^^<" + XSD + "string>", 		factory.getOWLLiteral("test string") }, 								// test full name
			// xsd:normalizedString
			/*  0 */ 	{ "^^xsd:normalizedString", 				factory.getOWLLiteral("", OWL2Datatype.XSD_NORMALIZED_STRING) },
			/*  0 */ 	{ "test string^^xsd:normalizedString", 		factory.getOWLLiteral("test string", OWL2Datatype.XSD_NORMALIZED_STRING) },
			/*  0 */ 	{ "string^^<" + XSD + "normalizedString>",	factory.getOWLLiteral("test string", OWL2Datatype.XSD_NORMALIZED_STRING) }, // test full name
			/*  0 */ 	{ "test \rstring^^xsd:normalizedString", 	AnnotationFormatException.class },										// wrong value format
			/*  0 */ 	{ "test \nstring^^xsd:normalizedString", 	AnnotationFormatException.class },										// wrong value format
			/*  0 */ 	{ "test\tstring^^xsd:normalizedString", 	AnnotationFormatException.class },										// wrong value format
			// xsd:token
			// xsd:language
			// xsd:Name
			// xsd:NCName
			// xsd:NMTOKEN
			// xsd:decimal
			// xsd:integer
			// xsd:nonNegativeInteger
			// xsd:nonPositiveInteger
			// xsd:positiveInteger
			// xsd:negativeInteger
			// xsd:long
			// xsd:int
			// xsd:short
			// xsd:byte
			// xsd:unsignedLong
			// xsd:unsignedInt
			// xsd:unsignedShort
			// xsd:unsignedByte
			// xsd:double
			// xsd:float
			// xsd:boolean
			/*  0 */ 	{ "^^rdf:boolean", 							AnnotationFormatException.class },										// wrong empty value
			/*  0 */ 	{ "true^^xsd:boolean", 						factory.getOWLLiteral(true) },
			/*  0 */ 	{ "false^^xsd:boolean", 					factory.getOWLLiteral(false) },
			/*  0 */ 	{ "1^^xsd:boolean", 						factory.getOWLLiteral(true) },
			/*  0 */ 	{ "0^^xsd:boolean", 						factory.getOWLLiteral(false) },
			/*  0 */ 	{ "true^^<" + XSD + "boolean>",				factory.getOWLLiteral(true) }, 											// test full name
			/*  0 */ 	{ "false^^<" + XSD + "boolean>",			factory.getOWLLiteral(false) }, 										// test full name
			/*  0 */ 	{ "+1^^xsd:boolean", 						AnnotationFormatException.class },										// wrong value format
			/*  0 */ 	{ "-1^^xsd:boolean", 						AnnotationFormatException.class },										// wrong value format
			/*  0 */ 	{ "+0^^xsd:boolean", 						AnnotationFormatException.class },										// wrong value format
			/*  0 */ 	{ "-0^^xsd:boolean", 						AnnotationFormatException.class },										// wrong value format
			/*  0 */ 	{ "^^xsd:boolean", 							AnnotationFormatException.class },										// wrong value format
			/*  0 */ 	{ "test string^^xsd:boolean", 				AnnotationFormatException.class },										// wrong value format
			/*  0 */ 	{ "2^^xsd:boolean", 						AnnotationFormatException.class },										// wrong value format
			// xsd:hexBinary
			/*  0 */ 	{ "^^xsd:hexBinary", 						factory.getOWLLiteral("", OWL2Datatype.XSD_HEX_BINARY) },
			/*  0 */ 	{ "a1^^xsd:hexBinary", 						factory.getOWLLiteral("a1", OWL2Datatype.XSD_HEX_BINARY) },
			/*  0 */ 	{ "a1e2ff^^xsd:hexBinary", 					factory.getOWLLiteral("a1e2ff", OWL2Datatype.XSD_HEX_BINARY) },
			/*  0 */ 	{ "f^^xsd:hexBinary", 						AnnotationFormatException.class },										// wrong value format
			/*  0 */ 	{ "a1e2f^^xsd:hexBinary", 					AnnotationFormatException.class },										// wrong value format
			// xsd:base64Binary
			// xsd:anyURI
			// xsd:dateTime
			// xsd:dateTimeStamp
			// Misc
			/*  0 */ 	{ "test string^^<" + RDFS + "XMLLiteral>",	AnnotationFormatException.class }, 										// wrong namespace
			/*  0 */ 	{ "test string^^<" + OWL + "Literal>", 		AnnotationFormatException.class }, 										// wrong namespace
			/*  0 */ 	{ "test string^^<" + RDF + "real>", 		AnnotationFormatException.class }, 										// wrong namespace
			/*  0 */ 	{ "true^^<" + OWL + "boolean>",				AnnotationFormatException.class }, 										// wrong namespace
			/*  0 */ 	{ "test string^rdf:XMLLiteral", 			AnnotationFormatException.class }, 										// wrong separator, should be ^^
			/*  0 */ 	{ "test string^rdf:Literal", 				AnnotationFormatException.class }, 										// wrong separator, should be ^^
			/*  0 */ 	{ "test string^rdf:real", 					AnnotationFormatException.class }, 										// wrong separator, should be ^^
			/*  0 */ 	{ "true^xsd:boolean", 						AnnotationFormatException.class }, 										// wrong separator, should be ^^
			/*  0 */ 	{ "test string^^^rdf:XMLLiteral", 			AnnotationFormatException.class }, 										// wrong separator, should be ^^
			/*  0 */ 	{ "test string^^^rdf:Literal", 				AnnotationFormatException.class }, 										// wrong separator, should be ^^
			/*  0 */ 	{ "test string^^^rdf:real", 				AnnotationFormatException.class }, 										// wrong separator, should be ^^
			/*  0 */ 	{ "false^^^xsd:boolean", 					AnnotationFormatException.class }, 										// wrong separator, should be ^^
		});
	}
	// @formatter:on

	@Parameter(0)
	public String parameter;

	@Parameter(1)
	public Object result;

	@Test
	public void anyEmptyLiteralShouldThrow() {
		System.out.println(parameter);
		try {
			IMatcher<OWLLiteral> matcher = Converter.getOWLLiteralMatcher(parameter);
			if (result instanceof OWLLiteral) {
				OWLLiteral literal = (OWLLiteral) result;
				IMatcher<OWLLiteral> ethalon = new OWLLiteralMatcher(literal);
				System.out.println("	" + ethalon);
				System.out.println("	" + matcher);
				Assert.assertEquals(ethalon, matcher);
				System.out.println("	success");
			} else {
				System.out.println("	fail");
				Assert.fail("Expected " + result);
			}
		} catch (AnnotationFormatException e) {
			System.out.println(e);
			if (result instanceof Class<?>) {
				Class<?> ethalon = (Class<?>) result;
				Assert.assertEquals(ethalon, e.getClass());
				System.out.println("	success");
			} else {
				System.out.println("	fail");
				Assert.fail("Expected " + result);
			}
		}
	}

}
