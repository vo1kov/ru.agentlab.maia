package ru.agentlab.maia.agent;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.hamcrest.Matcher;
import org.junit.Rule;
import org.junit.rules.ExpectedException;
import org.mockito.ArgumentCaptor;

import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IRole;
import ru.agentlab.maia.agent.RoleBase;
import ru.agentlab.maia.agent.event.RoleActivatedEvent;
import ru.agentlab.maia.agent.event.RoleAddedEvent;
import ru.agentlab.maia.agent.event.RoleDeactivatedEvent;
import ru.agentlab.maia.agent.event.RoleRemovedEvent;

public abstract class RoleBaseAbstractTest {

	public static final IRole R1 = mock(IRole.class);
	public static final IRole R2 = mock(IRole.class);
	public static final IRole R3 = mock(IRole.class);
	public static final IRole R4 = mock(IRole.class);

	public static final IRole A1 = mock(IRole.class);
	public static final IRole A2 = mock(IRole.class);
	public static final IRole A3 = mock(IRole.class);
	public static final IRole I1 = mock(IRole.class);
	public static final IRole I2 = mock(IRole.class);
	public static final IRole I3 = mock(IRole.class);
	static {
		when(A1.isActive()).thenReturn(true);
		when(A2.isActive()).thenReturn(true);
		when(A3.isActive()).thenReturn(true);
		when(I1.isActive()).thenReturn(false);
		when(I2.isActive()).thenReturn(false);
		when(I3.isActive()).thenReturn(false);
	}

	public static Object added(IRole role) {
		return new RoleAddedEvent(role);
	}

	public static Object activated(IRole role) {
		return new RoleActivatedEvent(role);
	}

	public static Object removed(IRole role) {
		return new RoleRemovedEvent(role);
	}

	public static Object deactivated(IRole role) {
		return new RoleDeactivatedEvent(role);
	}

	static public class DummyService {
	}

	@Rule
	public ExpectedException thrown = ExpectedException.none();

	@SuppressWarnings("unchecked")
	protected Queue<Object> eventQueue = mock(Queue.class);

	protected IInjector injector = mock(IInjector.class);

	protected IPlanBase planBase = mock(IPlanBase.class);

	protected RoleBase roleBase = new RoleBase(eventQueue, injector, planBase);

	protected Random random = new Random();

	protected Class<?> givenDummyServiceClass() {
		return DummyService.class;
	}

	protected Object givenDummyService() {
		return new DummyService();
	}

	protected IPlan<?>[] givenDummyPlans(int size) {
		return new IPlan[size];
	}

	@SuppressWarnings("unchecked")
	protected Map<String, Object> givenDummyMap() {
		return mock(Map.class);
	}

	protected void givenStoredRoles(IRole... roles) {
		roleBase.roles.clear();
		Stream.of(roles).forEach(roleBase.roles::add);
	}

	protected void thenQueueFired(Object[] expectedEvents) {
		ArgumentCaptor<Object> argument = ArgumentCaptor.forClass(Object.class);
		verify(eventQueue, times(expectedEvents.length)).offer(argument.capture());
		List<Object> capturedEvents = argument.getAllValues();
		List<Matcher<? super Object>> matchers = Stream
			.of(expectedEvents)
			.map(event -> equalTo(event))
			.collect(Collectors.toList());
		assertThat(capturedEvents, containsInAnyOrder(matchers));
	}

}
