package ru.agentlab.maia.agent;

import java.lang.reflect.Method;

import org.junit.Test;

public class Plan_isRelevant_Test {

	@Test
	public void test() throws NoSuchMethodException, SecurityException {
		// Given
		Object role = new DummyService();
		Method method = role.getClass().getMethod("method");
		Plan plan = new Plan(role, method);
	}

}

class DummyService {

	public void method() {

	}

}