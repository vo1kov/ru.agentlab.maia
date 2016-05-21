package ru.agentlab.maia.agent.match;

import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLOntologyManager;

/**
 * Test cases:
 * <!-- @formatter:off -->
 * <table border="thin single black collapse">
 * 	<thead>
 * 		<tr><th rowspan="2">##</th><th colspan="4">Input</th><th colspan="2">Output</th></tr>
 * 		<tr><th>Matcher Individual</th><th>Matcher Class</th><th>Axiom Individual</th><th>Axiom Class</th><th>Result</th><th>Unifier</th></tr>
 * 	<thead>
 * 	<tbody>
 * 		<tr><td>0</td>  <td>URI1#test1</td> <td>URI1#class1</td> <td>URI1#test1</td> <td>URI1#class1</td> <td>true</td>  <td>empty</td></tr>
 * 		<tr><td>1</td>  <td>URI1#test1</td> <td>URI1#class1</td> <td>URI1#test1</td> <td>URI1#xxxxxx</td> <td>false</td> <td>no matter</td></tr>
 * 		<tr><td>2</td>  <td>URI1#test1</td> <td>URI1#class1</td> <td>URI1#xxxxx</td> <td>URI1#class1</td> <td>false</td> <td>no matter</td></tr>
 * 		<tr><td>3</td>  <td>URI1#test1</td> <td>URI1#class1</td> <td>URI1#xxxxx</td> <td>URI1#xxxxxx</td> <td>false</td> <td>no matter</td></tr>
 * 
 * 		<tr><td>4</td>  <td>URI1#test1</td> <td>?class</td>      <td>URI1#test1</td> <td>URI1#class1</td> <td>true</td>  <td>?class=URI1#class1</td></tr>
 * 		<tr><td>5</td>  <td>URI1#test1</td> <td>?class</td>      <td>URI1#test1</td> <td>URI1#xxxxxx</td> <td>true</td>  <td>?class=URI1#xxxxx</td></tr>
 * 		<tr><td>6</td>  <td>URI1#test1</td> <td>?class</td>      <td>URI1#xxxxx</td> <td>URI1#class1</td> <td>false</td> <td>no matter</td></tr>
 * 		<tr><td>7</td>  <td>URI1#test1</td> <td>?class</td>      <td>URI1#xxxxx</td> <td>URI1#xxxxxx</td> <td>false</td> <td>no matter</td></tr>
 * 
 * 		<tr><td>8</td>  <td>?indiv</td>     <td>URI1#class1</td> <td>URI1#test1</td> <td>URI1#class1</td> <td>true</td>  <td>?indiv=URI1#test1</td></tr>
 * 		<tr><td>9</td>  <td>?indiv</td>     <td>URI1#class1</td> <td>URI1#test1</td> <td>URI1#xxxxxx</td> <td>false</td> <td>no matter</td></tr>
 * 		<tr><td>10</td> <td>?indiv</td>     <td>URI1#class1</td> <td>URI1#xxxxx</td> <td>URI1#class1</td> <td>true</td>  <td>?indiv=URI1#xxxxx</td></tr>
 * 		<tr><td>11</td> <td>?indiv</td>     <td>URI1#class1</td> <td>URI1#xxxxx</td> <td>URI1#xxxxxx</td> <td>false</td> <td>no matter</td></tr>
 * 
 * 		<tr><td>12</td> <td>?indiv</td>     <td>?class</td>      <td>URI1#test1</td> <td>URI1#class1</td> <td>true</td>  <td>?indiv=URI1#test1 ?class=URI1#class1</td></tr>
 * 		<tr><td>13</td> <td>?indiv</td>     <td>?class</td>      <td>URI1#test1</td> <td>URI1#xxxxxx</td> <td>true</td>  <td>?indiv=URI1#test1 ?class=URI1#xxxxxx</td></tr>
 * 		<tr><td>14</td> <td>?indiv</td>     <td>?class</td>      <td>URI1#xxxxx</td> <td>URI1#class1</td> <td>true</td>  <td>?indiv=URI1#xxxxx ?class=URI1#class1</td></tr>
 * 		<tr><td>15</td> <td>?indiv</td>     <td>?class</td>      <td>URI1#xxxxx</td> <td>URI1#xxxxxx</td> <td>true</td>  <td>?indiv=URI1#xxxxx ?class=URI1#xxxxxx</td></tr>
 * 	</tbody>
 * </table>
 * <!-- @formatter:on -->
 * URI1 = http://example.com#
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class OWLClassAssertionAxiomMatcherTest {

	private static OWLOntologyManager manager = OWLManager.createOWLOntologyManager();

	private static OWLDataFactory factory = manager.getOWLDataFactory();

	private static String NAMESPACE = "http://example.com#";

	private static OWLNamedIndividual TEST1 = factory.getOWLNamedIndividual(IRI.create(NAMESPACE + "test1"));
	private static OWLNamedIndividual XXXXX = factory.getOWLNamedIndividual(IRI.create(NAMESPACE + "xxxxx"));
	private static OWLClass CLASS1 = factory.getOWLClass(IRI.create(NAMESPACE + "class1"));
	private static OWLClass XXXXXX = factory.getOWLClass(IRI.create(NAMESPACE + "xxxxxx"));

	private static IMatcher<OWLNamedObject> INDIV_STATIC_MATCHER = new OWLNamedObjectStaticMatcher(TEST1);
	private static IMatcher<OWLNamedObject> INDIV_VAR_MATCHER = new OWLNamedObjectVariableMatcher("indiv");
	private static IMatcher<OWLNamedObject> CLASS_STATIC_MATCHER = new OWLNamedObjectStaticMatcher(CLASS1);
	private static IMatcher<OWLNamedObject> CLASS_VAR_MATCHER = new OWLNamedObjectVariableMatcher("class");

	private static Map<String, Object> EMPTY = new HashMap<>();
	private static Map<String, Object> ONLY_TEST1 = new HashMap<>();
	private static Map<String, Object> ONLY_XXXXX = new HashMap<>();
	private static Map<String, Object> ONLY_CLASS1 = new HashMap<>();
	private static Map<String, Object> ONLY_XXXXXX = new HashMap<>();
	private static Map<String, Object> TEST1_CLASS1 = new HashMap<>();
	private static Map<String, Object> XXXXX_CLASS1 = new HashMap<>();
	private static Map<String, Object> TEST1_XXXXXX = new HashMap<>();
	private static Map<String, Object> XXXXX_XXXXXX = new HashMap<>();

	static {
		ONLY_TEST1.put("indiv", TEST1);
		ONLY_XXXXX.put("indiv", XXXXX);
		ONLY_CLASS1.put("class", CLASS1);
		ONLY_XXXXXX.put("class", XXXXXX);
		TEST1_CLASS1.put("indiv", TEST1);
		TEST1_CLASS1.put("class", CLASS1);
		XXXXX_CLASS1.put("indiv", XXXXX);
		XXXXX_CLASS1.put("class", CLASS1);
		TEST1_XXXXXX.put("indiv", TEST1);
		TEST1_XXXXXX.put("class", XXXXXX);
		XXXXX_XXXXXX.put("indiv", XXXXX);
		XXXXX_XXXXXX.put("class", XXXXXX);
	}

	// @formatter:off
	@Parameters
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] { 
			/*  0 */ { INDIV_STATIC_MATCHER, CLASS_STATIC_MATCHER, TEST1, CLASS1, true,  EMPTY },
			/*  1 */ { INDIV_STATIC_MATCHER, CLASS_STATIC_MATCHER, TEST1, XXXXXX, false, null },
			/*  2 */ { INDIV_STATIC_MATCHER, CLASS_STATIC_MATCHER, XXXXX, CLASS1, false, null },
			/*  3 */ { INDIV_STATIC_MATCHER, CLASS_STATIC_MATCHER, XXXXX, XXXXXX, false, null },
			
			/*  4 */ { INDIV_STATIC_MATCHER, CLASS_VAR_MATCHER,    TEST1, CLASS1, true,  ONLY_CLASS1 },
			/*  5 */ { INDIV_STATIC_MATCHER, CLASS_VAR_MATCHER,    TEST1, XXXXXX, true,  ONLY_XXXXXX },
			/*  6 */ { INDIV_STATIC_MATCHER, CLASS_VAR_MATCHER,    XXXXX, CLASS1, false, null },
			/*  7 */ { INDIV_STATIC_MATCHER, CLASS_VAR_MATCHER,    XXXXX, XXXXXX, false, null },
			
			/*  8 */ { INDIV_VAR_MATCHER,    CLASS_STATIC_MATCHER, TEST1, CLASS1, true,  ONLY_TEST1 },
			/*  9 */ { INDIV_VAR_MATCHER,    CLASS_STATIC_MATCHER, TEST1, XXXXXX, false, null },
			/* 10 */ { INDIV_VAR_MATCHER,    CLASS_STATIC_MATCHER, XXXXX, CLASS1, true,  ONLY_XXXXX },
			/* 11 */ { INDIV_VAR_MATCHER,    CLASS_STATIC_MATCHER, XXXXX, XXXXXX, false, null },
			
			/* 12 */ { INDIV_VAR_MATCHER,    CLASS_VAR_MATCHER,    TEST1, CLASS1, true, TEST1_CLASS1 },
			/* 13 */ { INDIV_VAR_MATCHER,    CLASS_VAR_MATCHER,    TEST1, XXXXXX, true, TEST1_XXXXXX },
			/* 14 */ { INDIV_VAR_MATCHER,    CLASS_VAR_MATCHER,    XXXXX, CLASS1, true, XXXXX_CLASS1 },
			/* 15 */ { INDIV_VAR_MATCHER,    CLASS_VAR_MATCHER,    XXXXX, XXXXXX, true, XXXXX_XXXXXX },
		});
	}
	// @formatter:on

	@Parameter(0)
	public IMatcher<OWLNamedObject> indivMatcher;

	@Parameter(1)
	public IMatcher<OWLNamedObject> classMatcher;

	@Parameter(2)
	public OWLNamedIndividual indivAxiom;

	@Parameter(3)
	public OWLClass classAxiom;

	@Parameter(4)
	public boolean result;

	@Parameter(5)
	public Map<String, Object> resultUnifier;

	@Test
	public void test() {
		// Given
		OWLClassAssertionAxiomMatcher matcher = new OWLClassAssertionAxiomMatcher(indivMatcher, classMatcher);
		OWLClassAssertionAxiom axiom = factory.getOWLClassAssertionAxiom(classAxiom, indivAxiom);
		Unifier unifier = new Unifier();

		// When
		System.out.println("Match " + axiom + " by " + matcher);
		boolean match = matcher.match(axiom, unifier);
		unifier.values.forEach((k, v) -> {
			System.out.println("	" + k + "=" + v);
		});

		// Then
		Assert.assertEquals(result, match);
		if (match) {
			Assert.assertEquals(resultUnifier.size(), unifier.values.size());
			resultUnifier.forEach((k, v) -> {
				Assert.assertEquals(v, unifier.get(k));
			});
		}
	}
}
