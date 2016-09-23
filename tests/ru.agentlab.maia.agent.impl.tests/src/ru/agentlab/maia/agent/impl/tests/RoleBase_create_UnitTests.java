package ru.agentlab.maia.agent.impl.tests;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

import java.util.Collections;
import java.util.Queue;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.IPlanBase;
import ru.agentlab.maia.agent.IRoleBase;
import ru.agentlab.maia.agent.impl.RoleBase;
import ru.agentlab.maia.container.IInjector;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;

/**
 * Tests for:
 * <ul>
 * <li>{@link RoleBase#create(Class) RoleBase::create(Class)}
 * <li>{@link RoleBase#create(Class, java.util.Map) RoleBase::create(Class, java.util.Map)}
 * <li>{@link RoleBase#create(Object) RoleBase::create(Object)}
 * <li>{@link RoleBase#create(Object, java.util.Map) RoleBase::create(Object, java.util.Map)}
 * </ul> 
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class })
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
	public void should_makeWithInjector_whenValidArguments() {
		roleBase.create(FakeService.class);
		verify(injector).make(FakeService.class, Collections.emptyMap());
	}

}
