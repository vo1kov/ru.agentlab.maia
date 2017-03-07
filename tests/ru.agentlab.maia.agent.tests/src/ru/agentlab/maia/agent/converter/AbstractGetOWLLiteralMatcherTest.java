package ru.agentlab.maia.agent.converter;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.instanceOf;
import static org.junit.Assert.assertThat;

import org.hamcrest.Matcher;
import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runners.Parameterized.Parameter;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.vocab.Namespaces;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import ru.agentlab.maia.annotation.Converter;
import ru.agentlab.maia.tests.util.LoggerRule;

/**
 * 
 * @see #evaluateTestCase()
 * 
 * @author Dmitriy Shishkin
 */
public abstract class AbstractGetOWLLiteralMatcherTest {

	public static final String HEX_BINARY = OWL2Datatype.XSD_HEX_BINARY.getShortForm();
	public static final String NORMALIZED_STRING = OWL2Datatype.XSD_NORMALIZED_STRING.getShortForm();
	public static final String RATIONAL = OWL2Datatype.OWL_RATIONAL.getShortForm();
	public static final String REAL = OWL2Datatype.OWL_REAL.getShortForm();
	public static final String STRING = OWL2Datatype.XSD_STRING.getShortForm();
	public static final String LITERAL = OWL2Datatype.RDFS_LITERAL.getShortForm();
	public static final String XML_LITERAL = OWL2Datatype.RDF_XML_LITERAL.getShortForm();
	public static final String PLAIN_LITERAL = OWL2Datatype.RDF_PLAIN_LITERAL.getShortForm();

	public final static String RDF = Namespaces.RDF.toString();
	public final static String RDFS = Namespaces.RDFS.toString();
	public final static String OWL = Namespaces.OWL.toString();
	public final static String XSD = Namespaces.XSD.toString();

	@Rule
	public LoggerRule rule = new LoggerRule(this);

	@Parameter(0)
	public String parameter;

	@Parameter(1)
	public Object result;

	@Test
	public void evaluateTestCase() {
		// Given
		Converter converter = new Converter();
		try {
			// When
			Matcher<? super OWLLiteral> matcher = converter.getOWLLiteralMatcher(parameter);
			System.out.println("Result matcher: " + matcher);
			// Then
			if (result instanceof Class<?>) {
				Assert.fail("Expected [" + result + "], but was: [" + matcher + "]");
			}
			assertThat(matcher, equalTo(result));
		} catch (Exception e) {
			// Then
			if (!(result instanceof Class<?>)) {
				Assert.fail("Expected [" + result + "], but was: [" + e + "]");
			}
			assertThat(e, instanceOf((Class<?>) result));
		}
	}

}