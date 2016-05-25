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
import ru.agentlab.maia.agent.match.JavaBooleanMatcher;
import ru.agentlab.maia.agent.match.JavaDoubleMatcher;
import ru.agentlab.maia.agent.match.JavaFloatMatcher;
import ru.agentlab.maia.agent.match.JavaIntegerMatcher;
import ru.agentlab.maia.agent.match.JavaStringMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralBooleanMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralDoubleMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralFloatMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralIntegerMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralPlainMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralTypedMatcher;
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
	private static final String LITERAL = "Literal";
	private static final String XML_LITERAL = "XMLLiteral";

	private final static String RDF = Namespaces.RDF.toString();
	private final static String RDFS = Namespaces.RDFS.toString();
	private final static String OWL = Namespaces.OWL.toString();
	private final static String XSD = Namespaces.XSD.toString();

	private static IMatcher<? super String> _str(String value) {
		return new JavaStringMatcher(value);
	}

	private static IMatcher<? super Boolean> _boo(boolean value) {
		return new JavaBooleanMatcher(value);
	}

	private static IMatcher<? super Float> _flo(float value) {
		return new JavaFloatMatcher(value);
	}

	private static IMatcher<? super Integer> _int(int value) {
		return new JavaIntegerMatcher(value);
	}

	private static IMatcher<? super Double> _dou(double value) {
		return new JavaDoubleMatcher(value);
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

	private static IMatcher<? super OWLLiteral> plainMatcher(IMatcher<? super String> literalMatcher,
			IMatcher<? super String> languageMatcher) {
		return new OWLLiteralPlainMatcher(literalMatcher, languageMatcher);
	}

	private static IMatcher<? super OWLLiteral> typedMatcher(IMatcher<? super String> literalMatcher,
			IMatcher<? super OWLDatatype> datatypeMatcher) {
		return new OWLLiteralTypedMatcher(literalMatcher, datatypeMatcher);
	}

	private static IMatcher<? super OWLLiteral> boolnMatcher(IMatcher<? super Boolean> matcher) {
		return new OWLLiteralBooleanMatcher(matcher);
	}

	private static IMatcher<? super OWLLiteral> floatMatcher(IMatcher<? super Float> matcher) {
		return new OWLLiteralFloatMatcher(matcher);
	}

	private static IMatcher<? super OWLLiteral> intgrMatcher(IMatcher<? super Integer> matcher) {
		return new OWLLiteralIntegerMatcher(matcher);
	}

	private static IMatcher<? super OWLLiteral> doublMatcher(IMatcher<? super Double> matcher) {
		return new OWLLiteralDoubleMatcher(matcher);
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
			/*  0 */ 	{ "^^rdf:XMLLiteral", 						typedMatcher(_str(""), 				_typ(RDF, XML_LITERAL)) },		// test empty string
			/*  1 */ 	{ "test^^rdf:XMLLiteral", 					typedMatcher(_str("test"),			_typ(RDF, XML_LITERAL)) },		// test non-empty string
			/*  2 */ 	{ "test string^^rdf:XMLLiteral", 			typedMatcher(_str("test string"),	_typ(RDF, XML_LITERAL)) },		// test value with whitespace
			/*  3 */ 	{ "true^^rdf:XMLLiteral", 					typedMatcher(_str("true"), 			_typ(RDF, XML_LITERAL)) },		// test value with another type
			/*  4 */ 	{ "2.3^^rdf:XMLLiteral", 					typedMatcher(_str("2.3"),			_typ(RDF, XML_LITERAL)) },		// test value with another type
			/*  5 */ 	{ "test string^^<" + RDF + "XMLLiteral>", 	typedMatcher(_str("test string"),	_typ(RDF, XML_LITERAL)) }, 		// test type full name
			/*  6 */ 	{ "?var^^rdf:XMLLiteral", 					typedMatcher(_var("var"),			_typ(RDF, XML_LITERAL)) }, 		// test variable value
			/*  7 */ 	{ "?var@?lang^^rdf:XMLLiteral", 			LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/*  8 */ 	{ "test string^^rdfs:XMLLiteral",			LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/*  9 */ 	{ "test string^^<" + RDFS + "XMLLiteral>",	LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			// rdfs:Literal
			/* 10 */ 	{ "^^rdfs:Literal", 						typedMatcher(_str(""), 				_typ(RDFS, LITERAL)) },			// test empty string
			/* 11 */ 	{ "test^^rdfs:Literal", 					typedMatcher(_str("test"), 			_typ(RDFS, LITERAL)) },			// test non-empty string
			/* 12 */ 	{ "test string^^rdfs:Literal",				typedMatcher(_str("test string"), 	_typ(RDFS, LITERAL)) },			// test value with whitespace
			/* 13 */ 	{ "test string^^<" + RDFS + "Literal>", 	typedMatcher(_str("test string"), 	_typ(RDFS, LITERAL)) }, 		// test type full name
			/* 14 */ 	{ "?var^^rdfs:Literal", 					typedMatcher(_var("var"),			_typ(RDFS, LITERAL)) }, 		// test variable value
			/* 15 */ 	{ "?var@?lang^^rdfs:Literal", 				LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/* 16 */ 	{ "test string^^rdf:Literal", 				LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/* 17 */ 	{ "test string^^<" + OWL + "Literal>", 		LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			// rdf:PlainLiteral
			/* 18 */ 	{ "", 										plainMatcher(_str(""), 				_any()) },						// test empty string
			/* 19 */ 	{ "^^rdf:PlainLiteral", 					plainMatcher(_str(""), 				_any()) },						// test empty string
			/* 20 */ 	{ "test^^rdf:PlainLiteral",					plainMatcher(_str("test"), 			_any()) },						// test non-empty string
			/* 21 */ 	{ "test string^^rdf:PlainLiteral",			plainMatcher(_str("test string"), 	_any()) },						// test value with whitespace
			/* 22 */ 	{ "test string^^<" + RDF + "PlainLiteral>",	plainMatcher(_str("test string"), 	_any()) },						// test full name
			/* 23 */ 	{ "Padredefamilia@es", 						plainMatcher(_str("Padredefamilia"),_str("es")) }, 					// test language tag
			/* 24 */ 	{ "Padredefamilia@es^^rdf:PlainLiteral",	plainMatcher(_str("Padredefamilia"),_str("es")) }, 					// test language tag
			/* 25 */ 	{ "Family Guy@", 							plainMatcher(_str("Family Guy"), 	_str("")) }, 					// test language tag
			/* 26 */ 	{ "Family Guy@en", 							plainMatcher(_str("Family Guy"),	_str("en")) }, 					// test language tag
			/* 28 */ 	{ "Тест строка@ru^^rdf:PlainLiteral",		plainMatcher(_str("Тест строка"),	_str("ru")) }, 					// test language tag
			/* 29 */ 	{ "Тест@строка@ru^^rdf:PlainLiteral",		plainMatcher(_str("Тест@строка"),	_str("ru")) }, 					// test language tag
			/* 30 */ 	{ "?var^^rdf:PlainLiteral", 				plainMatcher(_var("var"),			_any()) }, 						// test variable
			/* 31 */ 	{ "?var@?lang^^rdf:PlainLiteral", 			plainMatcher(_var("var"),			_var("lang")) }, 				// test variable value and lang
			/* 32 */ 	{ "?var@?lang", 							plainMatcher(_var("var"),			_var("lang")) }, 				// test variable value, lang and no type
			/* 33 */ 	{ "?var", 									plainMatcher(_var("var"),			_any()) }, 						// test variable value only
			/* 27 */ 	{ "Тест строка@ru^^xsd:string", 			typedMatcher(_str("Тест строка@ru"),_typ(XSD, STRING)) }, 			// test language tag
			/* 35 */ 	{ "Padre de familia@es^^owl:PlainLiteral",	LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/* 36 */ 	{ "test string^^<" + OWL + "PlainLiteral>",	LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			// owl:real
			/* 37 */ 	{ "^^owl:real", 							typedMatcher(_str(""), 				_typ(OWL, REAL)) },				// test empty string
			/* 38 */ 	{ "test^^owl:real",							typedMatcher(_str("test"), 			_typ(OWL, REAL)) },				// test non-empty string
			/* 39 */ 	{ "test string^^owl:real",					typedMatcher(_str("test string"), 	_typ(OWL, REAL)) },				// test value with whitespace
			/* 40 */ 	{ "test string^^<" + OWL + "real>", 		typedMatcher(_str("test string"), 	_typ(OWL, REAL)) }, 			// test full name
			/* 41 */ 	{ "?var^^owl:real", 						typedMatcher(_var("var"),			_typ(OWL, REAL)) }, 			// test variable value
			/* 42 */ 	{ "?var@?lang^^owl:real", 					LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/* 43 */ 	{ "test string^^rdfs:real", 				LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/* 44 */ 	{ "test string^^<" + RDF + "real>", 		LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			// owl:rational
			/* 45 */ 	{ "^^owl:rational", 						LiteralNotInLexicalSpaceException.class },							// test empty string
			/* 46 */ 	{ "2/3^^owl:rational",						typedMatcher(_str("2/3"), 			_typ(OWL, RATIONAL)) },			// test non-empty string
			/* 47 */ 	{ "2 / 3^^owl:rational",					typedMatcher(_str("2 / 3"), 		_typ(OWL, RATIONAL)) },			// test non-empty string
			/* 48 */ 	{ "-2 /3^^owl:rational",					typedMatcher(_str("-2 /3"), 		_typ(OWL, RATIONAL)) },			// test non-empty string
			/* 49 */ 	{ "+2/ 3^^owl:rational",					typedMatcher(_str("+2/ 3"), 		_typ(OWL, RATIONAL)) },			// test non-empty string
			/* 50 */ 	{ "45/7^^<" + OWL + "rational>", 			typedMatcher(_str("45/7"), 			_typ(OWL, RATIONAL)) }, 		// test full name
			/* 51 */ 	{ "?var^^owl:rational", 					typedMatcher(_var("var"),			_typ(OWL, RATIONAL)) }, 		// test variable value
			/* 52 */ 	{ "?var@?lang^^owl:rational", 				LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/* 53 */ 	{ "2^^owl:rational",						LiteralNotInLexicalSpaceException.class },							// test wrong format
			/* 54 */ 	{ "2.5/3.21^^owl:rational",					LiteralNotInLexicalSpaceException.class },							// test wrong format
			// xsd:string
			/* 55 */ 	{ "^^xsd:string", 							typedMatcher(_str(""), 				_typ(XSD, STRING)) },			// test empty string
			/* 56 */ 	{ "test^^xsd:string", 						typedMatcher(_str("test"), 			_typ(XSD, STRING)) },			// test non-empty string
			/* 57 */ 	{ "test string^^xsd:string", 				typedMatcher(_str("test string"), 	_typ(XSD, STRING)) },			// test value with whitespace
			/* 58 */ 	{ "test \rstring^^xsd:string", 				typedMatcher(_str("test \rstring"), _typ(XSD, STRING)) },			// test value with whitespace
			/* 59 */ 	{ "test \nstring^^xsd:string", 				typedMatcher(_str("test \nstring"), _typ(XSD, STRING)) },			// test value with whitespace
			/* 60 */ 	{ "test\tstring^^xsd:string", 				typedMatcher(_str("test\tstring"), 	_typ(XSD, STRING)) },			// test value with whitespace
			/* 61 */ 	{ "test string^^<" + XSD + "string>", 		typedMatcher(_str("test string"), 	_typ(XSD, STRING)) }, 			// test full name
			/* 62 */ 	{ "?var^^xsd:string", 						typedMatcher(_var("var"),			_typ(XSD, STRING)) }, 			// test variable value
			/* 63 */ 	{ "?var@?lang^^xsd:string", 				LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/* 64 */ 	{ "test string^^rdfs:string", 				LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/* 65 */ 	{ "test string^^<" + RDF + "string>", 		LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			// xsd:normalizedString
			/* 66 */ 	{ "^^xsd:normalizedString", 				typedMatcher(_str(""), 				_typ(XSD, NORMALIZED_STRING))},	// test empty string
			/* 67 */ 	{ "test^^xsd:normalizedString", 			typedMatcher(_str("test"), 			_typ(XSD, NORMALIZED_STRING))},	// test non-empty string
			/* 68 */ 	{ "test string^^xsd:normalizedString", 		typedMatcher(_str("test string"), 	_typ(XSD, NORMALIZED_STRING))},	// test value with whitespace
			/* 72 */ 	{ "string^^<" + XSD + "normalizedString>",	typedMatcher(_str("string"), 		_typ(XSD, NORMALIZED_STRING))},	// test full name
			/* 73 */ 	{ "?var^^xsd:normalizedString", 			typedMatcher(_var("var"),			_typ(XSD, NORMALIZED_STRING))}, // test variable value
			/* 74 */ 	{ "?var@?lang^^xsd:normalizedString", 		LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/* 69 */ 	{ "test \rstring^^xsd:normalizedString", 	LiteralNotInLexicalSpaceException.class},							// test value with whitespace
			/* 70 */ 	{ "test \nstring^^xsd:normalizedString", 	LiteralNotInLexicalSpaceException.class},							// test value with whitespace
			/* 71 */ 	{ "test\tstring^^xsd:normalizedString", 	LiteralNotInLexicalSpaceException.class},							// test value with whitespace
			/* 75 */ 	{ "test string^^rdfs:normalizedString", 	LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/* 76 */ 	{ "test^^<" + RDF + "normalizedString>",	LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
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
			/*  0 */ 	{ "^^xsd:double", 							LiteralNotInLexicalSpaceException.class },							// wrong empty value
			/*  0 */ 	{ "0^^xsd:double", 							doublMatcher(_dou(0)) },											// test 0 string
			/*  0 */ 	{ "-0^^xsd:double", 						doublMatcher(_dou(0)) },											// test 0 string
			/*  0 */ 	{ "+0^^xsd:double", 						doublMatcher(_dou(0)) },											// test 0 string
			/*  0 */ 	{ "1^^xsd:double", 							doublMatcher(_dou(1)) },											// test 1 string
			/*  0 */ 	{ "-1^^xsd:double", 						doublMatcher(_dou(-1)) },											// test 1 string
			/*  0 */ 	{ "+1^^xsd:double", 						doublMatcher(_dou(1)) },											// test 1 string
			/*  0 */ 	{ "12345^^<" + XSD + "double>",				doublMatcher(_dou(12345)) }, 										// test more numbers
			/*  0 */ 	{ "2.2E12^^<" + XSD + "double>",			doublMatcher(_dou(2.2e12)) }, 											// test dot name
			/*  0 */ 	{ Double.MAX_VALUE+"^^xsd:double",			doublMatcher(_dou(Double.MAX_VALUE)) }, 							// test max value
			/*  0 */ 	{ "-"+Double.MAX_VALUE+"^^xsd:double",		doublMatcher(_dou(-Double.MAX_VALUE)) }, 							// test min value
			/*  0 */ 	{ Double.MAX_VALUE+"0^^xsd:double",			doublMatcher(_dou(Double.POSITIVE_INFINITY)) }, 					// test > +infinity
			/*  0 */ 	{ "INF^^xsd:double",						doublMatcher(_dou(Double.POSITIVE_INFINITY)) }, 					// test +infinity
			/*  0 */ 	{ "-"+Double.MAX_VALUE+"0^^xsd:double",		doublMatcher(_dou(Double.NEGATIVE_INFINITY)) }, 					// test < -infinity
			/*  0 */ 	{ "-INF^^xsd:double",						doublMatcher(_dou(Double.NEGATIVE_INFINITY)) }, 					// test +infinity
			/*  0 */ 	{ "NaN^^xsd:double",						doublMatcher(_dou(Double.NaN)) }, 									// test NaN
			/*  0 */ 	{ "-NaN^^xsd:double",						LiteralNotInLexicalSpaceException.class }, 							// test -NaN
			/*  0 */ 	{ "+-1^^xsd:double", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "-+1^^xsd:double", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "+0.3.3^^xsd:double", 					LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "-0-^^xsd:double", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "test string^^xsd:double", 				LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "2/4^^xsd:double", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "?var^^xsd:double", 						doublMatcher(_var("var")) }, 										// test variable value
			/*  0 */ 	{ "?var@?lang^^xsd:double", 				LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/*  0 */ 	{ "true^^rdf:boolean",						LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/*  0 */ 	{ "true^^<" + OWL + "double>",				LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			// xsd:float
			/*  0 */ 	{ "^^xsd:float", 							LiteralNotInLexicalSpaceException.class },							// wrong empty value
			/*  0 */ 	{ "0^^xsd:float", 							floatMatcher(_flo(0)) },											// test 0 string
			/*  0 */ 	{ "-0^^xsd:float", 							floatMatcher(_flo(0)) },											// test 0 string
			/*  0 */ 	{ "+0^^xsd:float", 							floatMatcher(_flo(0)) },											// test 0 string
			/*  0 */ 	{ "1^^xsd:float", 							floatMatcher(_flo(1)) },											// test 1 string
			/*  0 */ 	{ "-1^^xsd:float", 							floatMatcher(_flo(-1)) },											// test 1 string
			/*  0 */ 	{ "+1^^xsd:float", 							floatMatcher(_flo(1)) },											// test 1 string
			/*  0 */ 	{ "12345^^<" + XSD + "float>",				floatMatcher(_flo(12345)) }, 										// test more numbers
			/*  0 */ 	{ "2.2E12^^<" + XSD + "float>",				floatMatcher(_flo(2.2e12f)) }, 											// test dot name
			/*  0 */ 	{ Float.MAX_VALUE+"^^xsd:float",			floatMatcher(_flo(Float.MAX_VALUE)) }, 								// test max value
			/*  0 */ 	{ "-"+Float.MAX_VALUE+"^^xsd:float",		floatMatcher(_flo(-Float.MAX_VALUE)) }, 							// test min value
			/*  0 */ 	{ Float.MAX_VALUE+"0^^xsd:float",			floatMatcher(_flo(Float.POSITIVE_INFINITY)) }, 						// test > +infinity
			/*  0 */ 	{ "INF^^xsd:float",							floatMatcher(_flo(Float.POSITIVE_INFINITY)) }, 						// test +infinity
			/*  0 */ 	{ "-"+Float.MAX_VALUE+"0^^xsd:float",		floatMatcher(_flo(Float.NEGATIVE_INFINITY)) }, 						// test < -infinity
			/*  0 */ 	{ "-INF^^xsd:float",						floatMatcher(_flo(Float.NEGATIVE_INFINITY)) }, 						// test +infinity
			/*  0 */ 	{ "NaN^^xsd:float",							floatMatcher(_flo(Float.NaN)) }, 									// test NaN
			/*  0 */ 	{ "-NaN^^xsd:float",						LiteralNotInLexicalSpaceException.class }, 							// test -NaN
			/*  0 */ 	{ "+-1^^xsd:float", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "-+1^^xsd:float", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "+0.3.3^^xsd:float", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "-0-^^xsd:float", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "test string^^xsd:float", 				LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "2/4^^xsd:float", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "?var^^xsd:float", 						floatMatcher(_var("var")) }, 										// test variable value
			/*  0 */ 	{ "?var@?lang^^xsd:float", 					LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/*  0 */ 	{ "true^^rdf:float",						LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/*  0 */ 	{ "true^^<" + OWL + "float>",				LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			// xsd:boolean
			/*  0 */ 	{ "^^xsd:boolean", 							LiteralNotInLexicalSpaceException.class },							// wrong empty value
			/*  0 */ 	{ "true^^xsd:boolean", 						boolnMatcher(_boo(true)) },											// test true string
			/*  0 */ 	{ "false^^xsd:boolean", 					boolnMatcher(_boo(false)) },										// test false string
			/*  0 */ 	{ "1^^xsd:boolean", 						boolnMatcher(_boo(true)) },											// test 1 string
			/*  0 */ 	{ "0^^xsd:boolean", 						boolnMatcher(_boo(false)) },										// test 0 string
			/*  0 */ 	{ "true^^<" + XSD + "boolean>",				boolnMatcher(_boo(true)) }, 										// test full name
			/*  0 */ 	{ "false^^<" + XSD + "boolean>",			boolnMatcher(_boo(false)) }, 										// test full name
			/*  0 */ 	{ "+1^^xsd:boolean", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "-1^^xsd:boolean", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "+0^^xsd:boolean", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "-0^^xsd:boolean", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "test string^^xsd:boolean", 				LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "2^^xsd:boolean", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "?var^^xsd:boolean", 						boolnMatcher(_var("var")) }, 										// test variable value
			/*  0 */ 	{ "?var@?lang^^xsd:boolean", 				LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/*  0 */ 	{ "true^^rdf:boolean",						LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/*  0 */ 	{ "true^^<" + OWL + "boolean>",				LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			// xsd:hexBinary
			/*  0 */ 	{ "^^xsd:hexBinary", 						typedMatcher(_str(""), 				_typ(XSD, HEX_BINARY)) },		// test empty string
			/*  0 */ 	{ "a1^^xsd:hexBinary", 						typedMatcher(_str("a1"), 			_typ(XSD, HEX_BINARY)) },		// test non-empty string
			/*  0 */ 	{ "a1e2ff^^xsd:hexBinary", 					typedMatcher(_str("a1e2ff"), 		_typ(XSD, HEX_BINARY)) },		// test non-empty string
			/*  0 */ 	{ "?var@?lang^^xsd:hexBinary", 				LiteralIllelgalLanguageTagException.class }, 						// test variable value and lang
			/*  0 */ 	{ "qwe^^xsd:hexBinary", 					LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "f^^xsd:hexBinary", 						LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "a1e2f^^xsd:hexBinary", 					LiteralNotInLexicalSpaceException.class },							// wrong value format
			/*  0 */ 	{ "true^^rdf:hexBinary",					LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			/*  0 */ 	{ "true^^<" + OWL + "boolean>",				LiteralWrongBuildInDatatypeException.class }, 						// wrong namespace
			// xsd:base64Binary
			// xsd:anyURI
			// xsd:dateTime
			// xsd:dateTimeStamp
			// Misc
			/*  0 */ 	{ "test string^rdf:XMLLiteral", 			plainMatcher(_str("test string^rdf:XMLLiteral"),_any()) }, 			// wrong separator, should be ^^
			/*  0 */ 	{ "test string^rdf:Literal", 				plainMatcher(_str("test string^rdf:Literal"),_any()) }, 			// wrong separator, should be ^^
			/*  0 */ 	{ "test string^rdf:real", 					plainMatcher(_str("test string^rdf:real"),_any()) }, 				// wrong separator, should be ^^
			/*  0 */ 	{ "true^xsd:boolean", 						plainMatcher(_str("true^xsd:boolean"),_any()) }, 					// wrong separator, should be ^^
			/*  0 */ 	{ "test string^^^rdf:XMLLiteral", 			typedMatcher(_str("test string^"),	_typ(RDF, XML_LITERAL)) }, 		// wrong separator, should be ^^
			/*  0 */ 	{ "test string^^^rdfs:Literal", 			typedMatcher(_str("test string^"),	_typ(RDFS, LITERAL)) }, 		// wrong separator, should be ^^
			/*  0 */ 	{ "test string^^^owl:real", 				typedMatcher(_str("test string^"),	_typ(OWL, REAL)) }, 			// wrong separator, should be ^^
			/*  0 */ 	{ "?var^^?type", 							typedMatcher(_var("var"),			_var("type")) }, 				// test variable value and type
//			/* 34 */ 	{ "?var@?lang^^?type", 						plainMatcher(_var("var"),			_var("lang"), 	_var("type")) },// test variable value, lang and type
			/*  0 */ 	{ "false^^^xsd:boolean", 					LiteralNotInLexicalSpaceException.class }, 							// wrong value [true^] format
			/*  0 */ 	{ "false^^some:type", 						LiteralUnknownPrefixException.class }, 								// unknown prefix
			/*  0 */ 	{ "false^^xsd : b o o lean:boolean", 		LiteralWrongFormatException.class }, 								// wrong format
			/*  0 */ 	{ "?v ar^^?t; pe", 							LiteralWrongFormatException.class }, 								// test variable value and type
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
		System.out.println(i++ + " " + parameter);
		try {
			IMatcher<? super OWLLiteral> matcher = converter.getOWLLiteralMatcher(parameter);
			System.out.println("	matcher: " + matcher);
			if (result instanceof OWLLiteralMatcher) {
				OWLLiteralMatcher ethalon = (OWLLiteralMatcher) result;
				System.out.println("	ethalon: " + ethalon);
				System.out.println("	result : " + matcher.equals(ethalon));
				Assert.assertEquals(ethalon, matcher);
				System.out.println("	success");
			} else {
				System.out.println("	fail");
				Assert.fail("Expected [" + result + "], but was: [" + matcher + "]");
			}
		} catch (Exception e) {
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
