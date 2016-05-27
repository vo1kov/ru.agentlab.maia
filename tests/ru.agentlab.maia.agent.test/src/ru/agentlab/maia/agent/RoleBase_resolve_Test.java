package ru.agentlab.maia.agent;

import java.util.HashMap;
import java.util.Map;
import java.util.Queue;

import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IConverter;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IRoleBase;

public class RoleBase_resolve_Test {

	IInjector injector;

	Map<Class<?>, Object> map = new HashMap<>();

	Queue<IEvent<?>> eventQueue = Mockito.mock(Queue.class);

	IConverter converter;

	IPlanBase planBase;

	IGoalBase goalBase;

	IBeliefBase beliefBase;

	IRoleBase roleBase = new RoleBase();

	@Before
	public void init() {

	}

	@Test
	public void test() {

	}

}
