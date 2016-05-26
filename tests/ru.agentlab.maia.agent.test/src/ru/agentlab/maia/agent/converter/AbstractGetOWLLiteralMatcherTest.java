package ru.agentlab.maia.agent.converter;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runners.Parameterized.Parameter;
import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralMatcher;

public abstract class AbstractGetOWLLiteralMatcherTest {

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
		System.out.println("Expected result: [" + result + "]");
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