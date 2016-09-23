package ru.agentlab.maia.agent.impl.tests;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.mock;

import java.util.Collection;
import java.util.Queue;
import java.util.stream.Stream;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.IPlanBase;
import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.agent.IRoleBase;
import ru.agentlab.maia.agent.impl.RoleBase;
import ru.agentlab.maia.container.IInjector;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;

/**
 * Tests for:
 * <ul>
 * <li>{@link RoleBase#addAll(Collection) RoleBase::addAll(Collection)}
 * <li>{@link RoleBase#addAll(IRole[]) RoleBase::addAll(IRole[])}
 * <li>{@link RoleBase#addAll(java.util.stream.Stream) RoleBase::addAll(Stream)}
 * </ul>
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class })
public class RoleBase_addAll_UnitTests {

	static public class FakeService {

	}

	@SuppressWarnings("unchecked")
	Queue<Object> eventQueue = mock(Queue.class);

	IInjector injector = mock(IInjector.class);

	IPlanBase planBase = mock(IPlanBase.class);

	IRoleBase roleBase = new RoleBase(eventQueue, injector, planBase);

	@Test(expected = NullPointerException.class)
	public void should_throwNPE_whenNullCollection() {
		// Given
		Collection<IRole> roles = null;
		// When
		roleBase.addAll(roles);
	}

	@Test(expected = NullPointerException.class)
	public void should_throwNPE_whenNullArray() {
		// Given
		IRole[] roles = null;
		// When
		roleBase.addAll(roles);
	}

	@Test(expected = NullPointerException.class)
	public void should_throwNPE_whenNullStream() {
		// Given
		Stream<IRole> roles = null;
		// When
		roleBase.addAll(roles);
	}

	@Test
	public void should_storeNewRole_whenValidArguments() {
		// // Given
		// IRole role = mock(IRole.class);
		// Collection<IRole> roles = roleBase.getRoles();
		// assertThat(roles.contains(role), equalTo(false));
		// int sizeBefore = roles.size();
		// // When
		// boolean result = roleBase.add(role);
		// // Then
		// int sizeAfter = roles.size();
		// assertThat(result, equalTo(true));
		// assertThat(sizeAfter, equalTo(sizeBefore + 1));
		// assertThat(roles.contains(role), equalTo(true));
	}

	@Test
	public void should_ignoreRole_whenAlreadyExists() {
		// // Given
		// IRole role = mock(IRole.class);
		// Collection<IRole> roles = roleBase.getRoles();
		// assertThat(roles.contains(role), equalTo(true));
		// int sizeBefore = roles.size();
		// // When
		// boolean result = roleBase.add(role);
		// // Then
		// int sizeAfter = roles.size();
		// assertThat(result, equalTo(false));
		// assertThat(sizeAfter, equalTo(sizeBefore));
		// assertThat(roles.contains(role), equalTo(true));
	}

}
