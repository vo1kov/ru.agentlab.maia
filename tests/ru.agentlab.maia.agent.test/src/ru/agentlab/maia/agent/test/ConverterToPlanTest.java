package ru.agentlab.maia.agent.test;

import static org.junit.Assert.assertNotNull;

import java.lang.reflect.Method;

import org.junit.Test;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.Agent;
import ru.agentlab.maia.agent.Converter;
import ru.agentlab.maia.agent.test.doubles.BeliefAddedDummy;

public class ConverterToPlanTest {

	IAgent agent = new Agent();

	@Test
	public void testEmptyParameter() throws NoSuchMethodException, SecurityException {
		Method emptyParameter = BeliefAddedDummy.class.getMethod("emptyParameter");
		IPlan plan = Converter.toPlan(emptyParameter);
		assertNotNull(plan);
	}

}
