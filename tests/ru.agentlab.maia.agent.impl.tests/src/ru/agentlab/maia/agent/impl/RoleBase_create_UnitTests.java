package ru.agentlab.maia.agent.impl;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

import java.util.Collections;
import java.util.Queue;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.IPlanBase;
import ru.agentlab.maia.agent.IRoleBase;
import ru.agentlab.maia.container.IInjector;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for:
 * <ul>
 * <li>{@link RoleBase#create(Class)}
 * <li>{@link RoleBase#create(Class, java.util.Map)}
 * <li>{@link RoleBase#create(Object)}
 * <li>{@link RoleBase#create(Object, java.util.Map)}
 * </ul>
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_create_UnitTests {

	static public class FakeService {

	}

	@SuppressWarnings("unchecked")
	Queue<Object> eventQueue = mock(Queue.class);

	IInjector injector = mock(IInjector.class);

	IPlanBase planBase = mock(IPlanBase.class);

	IRoleBase roleBase = new RoleBase(eventQueue, injector, planBase);

	@Test(expected = NullPointerException.class)
	public void should_throwNPE_whenNullClass() {
		roleBase.create(null);
	}

	@Test(expected = NullPointerException.class)
	public void should_throwNPE_whenNullClassAndExtra() {
		roleBase.create(null, null);
	}

	@Test(expected = NullPointerException.class)
	public void should_throwNPE_whenNullExtra() {
		roleBase.create(Object.class, null);
	}

	@Test
	@Ignore
	public void should_makeWithInjector_whenValidArguments() {
		roleBase.create(FakeService.class);
		verify(injector).make(FakeService.class, Collections.emptyMap());
	}

}
