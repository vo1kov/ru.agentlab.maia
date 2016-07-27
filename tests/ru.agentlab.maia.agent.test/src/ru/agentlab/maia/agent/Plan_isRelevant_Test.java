package ru.agentlab.maia.agent;

import java.lang.reflect.Method;

import org.junit.Test;

import ru.agentlab.maia.agent.doubles.DummyService;
import ru.agentlab.maia.agent.impl.PlanBodyStateful;

public class Plan_isRelevant_Test {

	@Test
	public void test() throws NoSuchMethodException, SecurityException {
		// Given
		Object role = new DummyService();
		Method method = role.getClass().getMethod("method");
		PlanBodyStateful plan = new PlanBodyStateful(role, method);
	}

}