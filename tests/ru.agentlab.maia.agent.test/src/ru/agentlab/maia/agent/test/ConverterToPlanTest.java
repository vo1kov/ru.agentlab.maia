package ru.agentlab.maia.agent.test;

import static org.junit.Assert.assertNotNull;

import java.lang.reflect.Method;
import java.util.Arrays;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.Converter;
import ru.agentlab.maia.agent.test.doubles.BeliefAddedDummy;
import ru.agentlab.maia.agent.test.doubles.BeliefRemovedDummy;

/**
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class ConverterToPlanTest {

	@Parameters
	public static Iterable<Object[]> data() {
		return Arrays.asList(new Object[][] { 
			/* 0 */ { BeliefAddedDummy.class }, 
			/* 1 */ { BeliefRemovedDummy.class } });
	}

	@Parameter
	public Class<?> roleClazz;

	@Test(expected = IllegalArgumentException.class)
	public void testEmptyParameter() throws NoSuchMethodException, SecurityException {
		Method emptyParameter = roleClazz.getMethod("emptyParameter");
		Converter.toPlan(emptyParameter);
	}

	@Test(expected = IllegalArgumentException.class)
	public void testOnlyOneParameter() throws NoSuchMethodException, SecurityException {
		Method emptyParameter = roleClazz.getMethod("onlyOneParameter");
		Converter.toPlan(emptyParameter);
	}

	@Test(expected = IllegalArgumentException.class)
	public void testOnlyTwoParameter() throws NoSuchMethodException, SecurityException {
		Method emptyParameter = roleClazz.getMethod("onlyTwoParameter");
		Converter.toPlan(emptyParameter);
	}

	@Test
	public void testExactlyThreeParameter() throws NoSuchMethodException, SecurityException {
		Method emptyParameter = roleClazz.getMethod("exactlyThreeParameter");
		IPlan plan = Converter.toPlan(emptyParameter);
		assertNotNull(plan);
	}

}
