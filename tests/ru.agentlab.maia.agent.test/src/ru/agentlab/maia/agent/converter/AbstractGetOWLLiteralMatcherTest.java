package ru.agentlab.maia.agent.converter;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.instanceOf;
import static org.junit.Assert.assertThat;

import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runners.Parameterized.Parameter;
import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralMatcher;
import ru.agentlab.maia.test.util.LoggerRule;

/**
 * 
 * @see #evaluateTestCase()
 * 
 * @author Dmitriy Shishkin
 */
public abstract class AbstractGetOWLLiteralMatcherTest {

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
			IMatcher<? super OWLLiteral> matcher = converter.getOWLLiteralMatcher(parameter);
			System.out.println("Result matcher: " + matcher);
			// Then
			if (result instanceof OWLLiteralMatcher) {
				assertThat(matcher, equalTo(result));
			} else {
				Assert.fail("Expected [" + result + "], but was: [" + matcher + "]");
			}
		} catch (Exception e) {
			// Then
			if (result instanceof Class<?>) {
				assertThat(e, instanceOf((Class<?>) result));
			} else {
				Assert.fail("Expected [" + result + "], but was: [" + e + "]");
			}
		}
	}

}