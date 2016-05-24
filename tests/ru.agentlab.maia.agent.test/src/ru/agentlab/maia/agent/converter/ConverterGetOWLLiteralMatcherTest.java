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
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.vocab.Namespaces;

import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.JavaAnyMatcher;
import ru.agentlab.maia.agent.match.JavaStringMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralMatcher;
import ru.agentlab.maia.agent.match.OWLNamedObjectMatcher;
import ru.agentlab.maia.agent.match.VariableMatcher;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterGetOWLLiteralMatcherTest {

	private static final String HEX_BINARY = "hexBinary";
	private static final String NORMALIZED_STRING = "normalizedString";
	private static final String RATIONAL = "rational";
	private static final String REAL = "real";
	private static final String STRING = "string";
	private static final String PLAIN_LITERAL = "PlainLiteral";
	private static final String LITERAL = "Literal";
	private static final String XML_LITERAL = "XMLLiteral";

	private final static String RDF = Namespaces.RDF.toString();
	private final static String RDFS = Namespaces.RDFS.toString();
	private final static String OWL = Namespaces.OWL.toString();
	private final static String XSD = Namespaces.XSD.toString();

	private static IMatcher<? super String> _str(String value) {
		return new JavaStringMatcher(value);
	}

	private static IMatcher<? super OWLDatatype> _typ(String namespace, String value) {
		return new OWLNamedObjectMatcher(IRI.create(namespace, value));
	}

	private static IMatcher<? super Object> _var(String value) {
		return new VariableMatcher(value);
	}

	private static IMatcher<? super Object> _any() {
		return JavaAnyMatcher.getInstance();
	}

	private static IMatcher<? super OWLLiteral> matcher(IMatcher<? super String> literalMatcher,
			IMatcher<? super String> languageMatcher, IMatcher<? super OWLDatatype> datatypeMatcher) {
		return new OWLLiteralMatcher(literalMatcher, languageMatcher, datatypeMatcher);
	}

	// @formatter:off
	// Name is not working because some of the test strings have \r\n symbols
	@Parameters//(name="When parameter is [{0}] then result is [{1}]")
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] { 
			/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
			 *| ##		| Input Parameter 							| Result Literal																| Comment						|
			  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
			// rdf:XMLLiteral
			/*  0 */ 	{ "^^rdf:XMLLiteral", 						matcher(_str(""), 				_any(),		 	_typ(RDF, XML_LITERAL)) },		// test empty string
			/*  1 */ 	{ "test^^rdf:XMLLiteral", 					matcher(_str("test"),			_any(),		 	_typ(RDF, XML_LITERAL)) },		// test non-empty string
			/*  2 */ 	{ "test string^^rdf:XMLLiteral", 			matcher(_str("test string"),	_any(),		 	_typ(RDF, XML_LITERAL)) },		// test value with whitespace
			/*  3 */ 	{ "true^^rdf:XMLLiteral", 					matcher(_str("true"), 			_any(),		 	_typ(RDF, XML_LITERAL)) },		// test value with another type
			/*  4 */ 	{ "2.3^^rdf:XMLLiteral", 					matcher(_str("2.3"),			_any(),		 	_typ(RDF, XML_LITERAL)) },		// test value with another type
			/*  5 */ 	{ "test string^^<" + RDF + "XMLLiteral>", 	matcher(_str("test string"),	_any(),		 	_typ(RDF, XML_LITERAL)) }, 		// test type full name
			/*  6 */ 	{ "?var^^rdf:XMLLiteral", 					matcher(_var("var"),			_any(),		 	_typ(RDF, XML_LITERAL)) }, 		// test variable value
			/*  7 */ 	{ "?var@?lang^^rdf:XMLLiteral", 			AnnotationFormatException.class }, 												// test variable value and lang, should be PlainLiteral
//			/*  8 */ 	{ "test string^^rdfs:XMLLiteral",			AnnotationFormatException.class }, 												// wrong namespace
//			/*  9 */ 	{ "test string^^<" + RDFS + "XMLLiteral>",	AnnotationFormatException.class }, 												// wrong namespace
			// rdfs:Literal
			/* 10 */ 	{ "^^rdfs:Literal", 						matcher(_str(""), 				_any(),		 	_typ(RDFS, LITERAL)) },			// test empty string
			/* 11 */ 	{ "test^^rdfs:Literal", 					matcher(_str("test"), 			_any(),		 	_typ(RDFS, LITERAL)) },			// test non-empty string
			/* 12 */ 	{ "test string^^rdfs:Literal",				matcher(_str("test string"), 	_any(),		 	_typ(RDFS, LITERAL)) },			// test value with whitespace
			/* 13 */ 	{ "test string^^<" + RDFS + "Literal>", 	matcher(_str("test string"), 	_any(),		 	_typ(RDFS, LITERAL)) }, 		// test type full name
			/* 14 */ 	{ "?var^^rdfs:Literal", 					matcher(_var("var"),			_any(),		 	_typ(RDFS, LITERAL)) }, 		// test variable value
			/* 15 */ 	{ "?var@?lang^^rdfs:Literal", 				AnnotationFormatException.class }, 												// test variable value and lang, should be PlainLiteral
//			/* 16 */ 	{ "test string^^rdfs:Literal", 				AnnotationFormatException.class }, 												// wrong namespace
//			/* 17 */ 	{ "test string^^<" + OWL + "Literal>", 		AnnotationFormatException.class }, 												// wrong namespace
			// rdf:PlainLiteral
			/* 18 */ 	{ "", 										matcher(_str(""), 				_any(),		 	_typ(RDF, PLAIN_LITERAL)) },	// test empty string
			/* 19 */ 	{ "^^rdf:PlainLiteral", 					matcher(_str(""), 				_any(),		 	_typ(RDF, PLAIN_LITERAL)) },	// test empty string
			/* 20 */ 	{ "test^^rdf:PlainLiteral",					matcher(_str("test"), 			_any(),		 	_typ(RDF, PLAIN_LITERAL)) },	// test non-empty string
			/* 21 */ 	{ "test string^^rdf:PlainLiteral",			matcher(_str("test string"), 	_any(),		 	_typ(RDF, PLAIN_LITERAL)) },	// test value with whitespace
			/* 22 */ 	{ "test string^^<" + RDF + "PlainLiteral>",	matcher(_str("test string"), 	_any(),		 	_typ(RDF, PLAIN_LITERAL)) },	// test full name
			/* 23 */ 	{ "Padre de familia@es", 					matcher(_str("Padre de familia"),_str("es"), 	_typ(RDF, PLAIN_LITERAL)) }, 	// test language tag
			/* 24 */ 	{ "Padre de familia@es^^rdf:PlainLiteral",	matcher(_str("Padre de familia"),_str("es"), 	_typ(RDF, PLAIN_LITERAL)) }, 	// test language tag
			/* 25 */ 	{ "Family Guy@", 							matcher(_str("Family Guy"),		_str(""), 		_typ(RDF, PLAIN_LITERAL)) }, 	// test language tag
			/* 26 */ 	{ "Family Guy@en", 							matcher(_str("Family Guy"),		_str("en"), 	_typ(RDF, PLAIN_LITERAL)) }, 	// test language tag
			/* 27 */ 	{ "Тестовая строка@ru^^xsd:string", 		matcher(_str("Тестовая строка@ru"),_any(),	 	_typ(XSD, STRING)) }, 			// test language tag
			/* 28 */ 	{ "Тестовая строка@ru^^rdf:PlainLiteral",	matcher(_str("Тестовая строка"),_str("ru"), 	_typ(RDF, PLAIN_LITERAL)) }, 	// test language tag
			/* 29 */ 	{ "Тестовая@строка@ru^^rdf:PlainLiteral",	matcher(_str("Тестовая@строка"),_str("ru"), 	_typ(RDF, PLAIN_LITERAL)) }, 	// test language tag
			/* 30 */ 	{ "?var^^rdf:PlainLiteral", 				matcher(_var("var"),			_any(),		 	_typ(RDF, PLAIN_LITERAL)) }, 	// test variable
			/* 31 */ 	{ "?var@?lang^^rdf:PlainLiteral", 			matcher(_var("var"),			_var("lang"), 	_typ(RDF, PLAIN_LITERAL)) }, 	// test variable value and lang
			/* 32 */ 	{ "?var@?lang", 							matcher(_var("var"),			_var("lang"), 	_typ(RDF, PLAIN_LITERAL)) }, 	// test variable value, lang and no type
			/* 33 */ 	{ "?var", 									matcher(_var("var"),			_any(), 		_typ(RDF, PLAIN_LITERAL)) }, 	// test variable value only
			/* 34 */ 	{ "?var@?lang^^?type", 						matcher(_var("var"),			_var("lang"), 	_var("type")) }, 				// test variable value, lang and type
//			/* 35 */ 	{ "Padre de familia@es^^owl:PlainLiteral",	AnnotationFormatException.class }, 												// wrong namespace
//			/* 36 */ 	{ "test string^^<" + OWL + "PlainLiteral>",	AnnotationFormatException.class }, 												// wrong namespace
			// owl:real
			/* 37 */ 	{ "^^owl:real", 							matcher(_str(""), 				_any(),		 	_typ(OWL, REAL)) },				// test empty string
			/* 38 */ 	{ "test^^owl:real",							matcher(_str("test"), 			_any(),		 	_typ(OWL, REAL)) },				// test non-empty string
			/* 39 */ 	{ "test string^^owl:real",					matcher(_str("test string"), 	_any(),		 	_typ(OWL, REAL)) },				// test value with whitespace
			/* 40 */ 	{ "test string^^<" + OWL + "real>", 		matcher(_str("test string"), 	_any(),		 	_typ(OWL, REAL)) }, 			// test full name
			/* 41 */ 	{ "?var^^owl:real", 						matcher(_var("var"),			_any(),		 	_typ(OWL, REAL)) }, 			// test variable value
			/* 42 */ 	{ "?var@?lang^^owl:real", 					AnnotationFormatException.class }, 												// test variable value and lang, should be PlainLiteral
//			/* 43 */ 	{ "test string^^rdfs:real", 				AnnotationFormatException.class }, 												// wrong namespace
//			/* 44 */ 	{ "test string^^<" + RDF + "real>", 		AnnotationFormatException.class }, 												// wrong namespace
			// owl:rational
			/* 45 */ 	{ "^^owl:rational", 						AnnotationFormatException.class },												// test empty string
			/* 46 */ 	{ "2/3^^owl:rational",						matcher(_str("2/3"), 			_any(),		 	_typ(OWL, RATIONAL)) },			// test non-empty string
			/* 47 */ 	{ "2 / 3^^owl:rational",					matcher(_str("2/3"), 			_any(),		 	_typ(OWL, RATIONAL)) },			// test non-empty string
			/* 48 */ 	{ "-2 /3^^owl:rational",					matcher(_str("-2/3"), 			_any(),		 	_typ(OWL, RATIONAL)) },			// test non-empty string
			/* 49 */ 	{ "+2/ 3^^owl:rational",					matcher(_str("+2/3"), 			_any(),		 	_typ(OWL, RATIONAL)) },			// test non-empty string
			/* 50 */ 	{ "45/7^^<" + OWL + "rational>", 			matcher(_str("45/7"), 			_any(),		 	_typ(OWL, RATIONAL)) }, 		// test full name
			/* 51 */ 	{ "?var^^owl:rational", 					matcher(_var("var"),			_any(),		 	_typ(OWL, RATIONAL)) }, 		// test variable value
			/* 52 */ 	{ "?var@?lang^^owl:rational", 				AnnotationFormatException.class }, 												// test variable value and lang, should be PlainLiteral
			/* 53 */ 	{ "2^^owl:rational",						AnnotationFormatException.class },												// test wrong format
			/* 54 */ 	{ "2.5/3.21^^owl:rational",					AnnotationFormatException.class },												// test wrong format
			// xsd:string
			/* 55 */ 	{ "^^xsd:string", 							matcher(_str(""), 				_any(),		 	_typ(XSD, STRING)) },			// test empty string
			/* 56 */ 	{ "test^^xsd:string", 						matcher(_str("test"), 			_any(),		 	_typ(XSD, STRING)) },			// test non-empty string
			/* 57 */ 	{ "test string^^xsd:string", 				matcher(_str("test string"), 	_any(),		 	_typ(XSD, STRING)) },			// test value with whitespace
			/* 58 */ 	{ "test \rstring^^xsd:string", 				matcher(_str("test \rstring"), 	_any(),		 	_typ(XSD, STRING)) },			// test value with whitespace
			/* 59 */ 	{ "test \nstring^^xsd:string", 				matcher(_str("test \nstring"), 	_any(),		 	_typ(XSD, STRING)) },			// test value with whitespace
			/* 60 */ 	{ "test\tstring^^xsd:string", 				matcher(_str("test\tstring"), 	_any(),		 	_typ(XSD, STRING)) },			// test value with whitespace
			/* 61 */ 	{ "test string^^<" + XSD + "string>", 		matcher(_str("test string"), 	_any(),		 	_typ(XSD, STRING)) }, 			// test full name
			/* 62 */ 	{ "?var^^xsd:string", 						matcher(_var("var"),			_any(),		 	_typ(XSD, STRING)) }, 			// test variable value
			/* 63 */ 	{ "?var@?lang^^xsd:string", 				AnnotationFormatException.class }, 												// test variable value and lang, should be PlainLiteral
//			/* 64 */ 	{ "test string^^rdfs:string", 				AnnotationFormatException.class }, 												// wrong namespace
//			/* 65 */ 	{ "test string^^<" + RDF + "string>", 		AnnotationFormatException.class }, 												// wrong namespace
			// xsd:normalizedString
			/* 66 */ 	{ "^^xsd:normalizedString", 				matcher(_str(""), 				_any(),		 	_typ(XSD, NORMALIZED_STRING))},	// test empty string
			/* 67 */ 	{ "test^^xsd:normalizedString", 			matcher(_str("test"), 			_any(),		 	_typ(XSD, NORMALIZED_STRING))},	// test non-empty string
			/* 68 */ 	{ "test string^^xsd:normalizedString", 		matcher(_str("test string"), 	_any(),		 	_typ(XSD, NORMALIZED_STRING))},	// test value with whitespace
			/* 69 */ 	{ "test \rstring^^xsd:normalizedString", 	matcher(_str("test  string"), 	_any(),		 	_typ(XSD, NORMALIZED_STRING))},	// test value with whitespace
			/* 70 */ 	{ "test \nstring^^xsd:normalizedString", 	matcher(_str("test  string"), 	_any(),		 	_typ(XSD, NORMALIZED_STRING))},	// test value with whitespace
			/* 71 */ 	{ "test\tstring^^xsd:normalizedString", 	matcher(_str("test string"), 	_any(),		 	_typ(XSD, NORMALIZED_STRING))},	// test value with whitespace
			/* 72 */ 	{ "string^^<" + XSD + "normalizedString>",	matcher(_str("string"), 		_any(),		 	_typ(XSD, NORMALIZED_STRING))},	// test full name
			/* 73 */ 	{ "?var^^xsd:normalizedString", 			matcher(_var("var"),			_any(),		 	_typ(XSD, NORMALIZED_STRING))}, // test variable value
			/* 74 */ 	{ "?var@?lang^^xsd:normalizedString", 		AnnotationFormatException.class }, 												// test variable value and lang, should be PlainLiteral
//			/* 75 */ 	{ "test string^^rdfs:normalizedString", 	AnnotationFormatException.class }, 												// wrong namespace
//			/* 76 */ 	{ "test^^<" + RDF + "normalizedString>",	AnnotationFormatException.class }, 												// wrong namespace
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
			/*  0 */ 	{ "^^rdf:boolean", 							AnnotationFormatException.class },												// wrong empty value
			/*  0 */ 	{ "true^^xsd:boolean", 						matcher(_str("true"), 			_any(),		 	_typ(XSD, "boolean")) },		// test true string
			/*  0 */ 	{ "false^^xsd:boolean", 					matcher(_str("false"), 			_any(),		 	_typ(XSD, "boolean")) },		// test false string
			/*  0 */ 	{ "1^^xsd:boolean", 						matcher(_str("true"), 			_any(),		 	_typ(XSD, "boolean")) },		// test 1 string
			/*  0 */ 	{ "0^^xsd:boolean", 						matcher(_str("false"), 			_any(),		 	_typ(XSD, "boolean")) },		// test 0 string
			/*  0 */ 	{ "true^^<" + XSD + "boolean>",				matcher(_str("true"), 			_any(),		 	_typ(XSD, "boolean")) }, 		// test full name
			/*  0 */ 	{ "false^^<" + XSD + "boolean>",			matcher(_str("false"), 			_any(),		 	_typ(XSD, "boolean")) }, 		// test full name
			/*  0 */ 	{ "+1^^xsd:boolean", 						AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "-1^^xsd:boolean", 						AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "+0^^xsd:boolean", 						AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "-0^^xsd:boolean", 						AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "^^xsd:boolean", 							AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "test string^^xsd:boolean", 				AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "2^^xsd:boolean", 						AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "?var^^xsd:boolean", 						matcher(_var("var"),			_any(),		 	_typ(XSD, "boolean")) }, 		// test variable value
			/*  0 */ 	{ "?var@?lang^^xsd:boolean", 				AnnotationFormatException.class }, 												// test variable value and lang, should be PlainLiteral
//			/*  0 */ 	{ "true^^rdf:boolean",						AnnotationFormatException.class }, 												// wrong namespace
//			/*  0 */ 	{ "true^^<" + OWL + "boolean>",				AnnotationFormatException.class }, 												// wrong namespace
			// xsd:hexBinary
			/*  0 */ 	{ "^^xsd:hexBinary", 						matcher(_str(""), 				_any(),		 	_typ(XSD, HEX_BINARY)) },		// test empty string
			/*  0 */ 	{ "a1^^xsd:hexBinary", 						matcher(_str("a1"), 			_any(),		 	_typ(XSD, HEX_BINARY)) },		// test non-empty string
			/*  0 */ 	{ "a1e2ff^^xsd:hexBinary", 					matcher(_str("a1e2ff"), 		_any(),		 	_typ(XSD, HEX_BINARY)) },		// test non-empty string
			/*  0 */ 	{ "qwe^^xsd:hexBinary", 					AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "f^^xsd:hexBinary", 						AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "a1e2f^^xsd:hexBinary", 					AnnotationFormatException.class },												// wrong value format
			/*  0 */ 	{ "?var@?lang^^xsd:hexBinary", 				AnnotationFormatException.class }, 												// test variable value and lang, should be PlainLiteral
//			/*  0 */ 	{ "true^^rdf:hexBinary",					AnnotationFormatException.class }, 												// wrong namespace
//			/*  0 */ 	{ "true^^<" + OWL + "boolean>",				AnnotationFormatException.class }, 												// wrong namespace
			// xsd:base64Binary
			// xsd:anyURI
			// xsd:dateTime
			// xsd:dateTimeStamp
			// Misc
			/*  0 */ 	{ "test string^rdf:XMLLiteral", 			AnnotationFormatException.class }, 												// wrong separator, should be ^^
			/*  0 */ 	{ "test string^rdf:Literal", 				AnnotationFormatException.class }, 												// wrong separator, should be ^^
			/*  0 */ 	{ "test string^rdf:real", 					AnnotationFormatException.class }, 												// wrong separator, should be ^^
			/*  0 */ 	{ "true^xsd:boolean", 						AnnotationFormatException.class }, 												// wrong separator, should be ^^
			/*  0 */ 	{ "test string^^^rdf:XMLLiteral", 			AnnotationFormatException.class }, 												// wrong separator, should be ^^
			/*  0 */ 	{ "test string^^^rdf:Literal", 				AnnotationFormatException.class }, 												// wrong separator, should be ^^
			/*  0 */ 	{ "test string^^^rdf:real", 				AnnotationFormatException.class }, 												// wrong separator, should be ^^
			/*  0 */ 	{ "false^^^xsd:boolean", 					AnnotationFormatException.class }, 												// wrong separator, should be ^^
			/*  0 */ 	{ "?var^^?type", 							matcher(_var("var"),			_any(),		 	_var("type")) }, 				// test variable value and type
		});
	}
	// @formatter:on

	@Parameter(0)
	public String parameter;

	@Parameter(1)
	public Object result;

	private static int i = 0;

	@Test
	public void anyEmptyLiteralShouldThrow() {
		System.out.println(i++ + " " + parameter);
		try {
			IMatcher<? super OWLLiteral> matcher = Converter.getOWLLiteralMatcher(parameter);
			if (result instanceof OWLLiteralMatcher) {
				OWLLiteralMatcher ethalon = (OWLLiteralMatcher) result;
				System.out.println("	" + ethalon);
				System.out.println("	" + matcher);
				System.out.println("	" + matcher.equals(ethalon));
				Assert.assertEquals(ethalon, matcher);
				System.out.println("	success");
			} else {
				System.out.println("	fail");
				Assert.fail("Expected [" + result + "], but was: [" + matcher + "]");
			}
		} catch (AnnotationFormatException e) {
			System.out.println(e);
			if (result instanceof Class<?>) {
				Class<?> ethalon = (Class<?>) result;
				Assert.assertEquals(ethalon, e.getClass());
				System.out.println("	success");
			} else {
				System.out.println("	fail");
				Assert.fail("Expected [" + result + "], but was: [" + e.getMessage() + "]");
			}
		}
	}

}
