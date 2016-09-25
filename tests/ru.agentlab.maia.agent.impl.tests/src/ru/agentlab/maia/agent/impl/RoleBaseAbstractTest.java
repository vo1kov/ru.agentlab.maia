package ru.agentlab.maia.agent.impl;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.empty;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.hasItems;
import static org.hamcrest.Matchers.iterableWithSize;
import static org.hamcrest.Matchers.not;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyZeroInteractions;
import static org.mockito.Mockito.when;

import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import org.hamcrest.Matcher;
import org.mockito.ArgumentCaptor;

import ru.agentlab.maia.agent.IPlanBase;
import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.agent.event.RoleAddedEvent;
import ru.agentlab.maia.container.IInjector;

public abstract class RoleBaseAbstractTest {

	static public class DummyService {
	}

	@SuppressWarnings("unchecked")
	protected Queue<Object> eventQueue = mock(Queue.class);

	protected IInjector injector = mock(IInjector.class);

	protected IPlanBase planBase = mock(IPlanBase.class);

	protected RoleBase roleBase = new RoleBase(eventQueue, injector, planBase);

	// ======================== Given Arguments ========================

	protected Class<?> givenNullClass() {
		return null;
	}

	protected Object givenNullObject() {
		return null;
	}

	protected Class<?> givenDummyServiceClass() {
		return DummyService.class;
	}

	protected Object givenDummyService() {
		return new DummyService();
	}

	protected Map<String, Object> givenNullMap() {
		return null;
	}

	protected Map<String, Object> givenEmptyMap() {
		return Collections.emptyMap();
	}

	protected IRole givenNullRole() {
		return null;
	}

	protected IRole givenNewRole() {
		return mock(IRole.class);
	}

	protected IRole givenActiveRole() {
		IRole role = mock(IRole.class);
		when(role.isActive()).thenReturn(true);
		return role;
	}

	protected IRole givenInactiveRole() {
		IRole role = mock(IRole.class);
		when(role.isActive()).thenReturn(false);
		return role;
	}

	protected Collection<IRole> givenInactiveRoles(int size) {
		return IntStream.range(0, size).mapToObj(i -> givenInactiveRole()).collect(Collectors.toList());
	}

	protected Collection<IRole> givenActiveRoles(int size) {
		return IntStream.range(0, size).mapToObj(i -> givenActiveRole()).collect(Collectors.toList());
	}

	protected IRole givenExistingRole() {
		return roleBase.roles.iterator().next();
	}

	protected Collection<IRole> givenNullCollection() {
		return null;
	}

	protected Collection<IRole> givenEmptyCollection() {
		return Collections.emptyList();
	}

	protected Collection<IRole> givenNewRolesCollection(int size) {
		return IntStream.range(0, size).mapToObj(i -> mock(IRole.class)).collect(Collectors.toList());
	}

	protected Collection<IRole> givenExistingRolesCollection(int size) {
		Iterator<IRole> iterator = roleBase.roles.iterator();
		return IntStream.range(0, size).mapToObj(i -> iterator.next()).collect(Collectors.toList());
	}

	protected IRole[] givenNullArray() {
		return null;
	}

	protected IRole[] givenEmptyArray() {
		return new IRole[0];
	}

	protected IRole[] givenNewRolesArray(int size) {
		return IntStream.range(0, size).mapToObj(i -> mock(IRole.class)).toArray(s -> new IRole[s]);
	}

	protected IRole[] givenExistingRolesArray(int size) {
		Iterator<IRole> iterator = roleBase.roles.iterator();
		return IntStream.range(0, size).mapToObj(i -> iterator.next()).toArray(s -> new IRole[s]);
	}

	protected Stream<IRole> givenNullStream() {
		return null;
	}

	protected Stream<IRole> givenEmptyStream() {
		return Stream.empty();
	}

	// ========================== Given State ==========================

	protected void givenEmptyRoles() {
		roleBase.roles.clear();
	}

	protected void givenStoredRoles(int size) {
		roleBase.roles.clear();
		IntStream.range(0, size).mapToObj(i -> mock(IRole.class)).forEach(roleBase.roles::add);
	}

	protected void givenStoredRoles(IRole role) {
		roleBase.roles.clear();
		roleBase.roles.add(role);
	}

	protected void givenStoredRoles(Collection<IRole> roles) {
		roleBase.roles.clear();
		roles.forEach(roleBase.roles::add);
	}

	// ========================= When Methods ==========================

	protected boolean whenAdd(IRole role) {
		return roleBase.add(role);
	}

	protected boolean whenAddAll(Collection<IRole> roles) {
		return roleBase.addAll(roles);
	}

	protected boolean whenAddAll(IRole[] roles) {
		return roleBase.addAll(roles);
	}

	protected boolean whenAddAll(Stream<IRole> roles) {
		return roleBase.addAll(roles);
	}

	protected IRole whenCreate(Class<?> clazz) {
		return roleBase.create(clazz);
	}

	protected IRole whenCreate(Class<?> clazz, Map<String, Object> map) {
		return roleBase.create(clazz, map);
	}

	protected IRole whenCreate(Object objectRole) {
		return roleBase.create(objectRole);
	}

	protected IRole whenCreate(Object objectRole, Map<String, Object> map) {
		return roleBase.create(objectRole, map);
	}

	protected boolean whenRemove(IRole role) {
		return roleBase.remove(role);
	}

	protected Collection<IRole> whenGetRoles() {
		return roleBase.getRoles();
	}

	protected void whenClear() {
		roleBase.clear();
	}

	// ======================== Then Assertions ========================

	protected void thenResult(boolean result, boolean expected) {
		assertThat(result, equalTo(expected));
	}

	protected void thenQueueFired(Collection<Object> expectedEvents) {
		ArgumentCaptor<Object> argument = ArgumentCaptor.forClass(Object.class);
		verify(eventQueue, times(expectedEvents.size())).offer(argument.capture());
		List<Object> capturedEvents = argument.getAllValues();
		List<Matcher<? super Object>> matchers = expectedEvents
			.stream()
			.map(event -> equalTo(event))
			.collect(Collectors.toList());
		assertThat(capturedEvents, containsInAnyOrder(matchers));
	}

	protected void thenQueueNotFired() {
		verifyZeroInteractions(eventQueue);
	}

	protected void thenRolesEmpty() {
		assertThat(roleBase.getRoles(), empty());
	}

	protected void thenRolesContains(IRole role) {
		assertThat(roleBase.getRoles(), hasItem(role));
	}

	protected void thenRolesContainsAll(Collection<IRole> roles) {
		assertThat(roleBase.getRoles(), hasItems(roles.toArray(new IRole[roles.size()])));
	}

	protected void thenRolesContainsAll(IRole[] roles) {
		assertThat(roleBase.getRoles(), hasItems(roles));
	}

	protected void thenRolesContainsAll(Stream<IRole> roles) {
		IRole[] array = roles.toArray(size -> new IRole[size]);
		assertThat(roleBase.getRoles(), hasItems(array));
	}

	protected void thenRolesNotContains(IRole role) {
		assertThat(roleBase.getRoles(), not(hasItem(role)));
	}

	protected void thenRolesNotContainsAll(Collection<IRole> roles) {
		assertThat(roleBase.getRoles(), not(hasItems(roles.toArray(new IRole[roles.size()]))));
	}

	protected void thenRolesNotContainsAll(IRole[] roles) {
		assertThat(roleBase.getRoles(), not(hasItems(roles)));
	}

	protected void thenRolesNotContainsAll(Stream<IRole> roles) {
		IRole[] array = roles.toArray(size -> new IRole[size]);
		assertThat(roleBase.getRoles(), not(hasItems(array)));
	}

	protected void thenRolesSize(int size) {
		assertThat(roleBase.getRoles(), iterableWithSize(size));
	}

	// ============================ Utility ============================

	protected List<Object> mapToRoleAddedEvent(Collection<IRole> roles) {
		return roles.stream().map(role -> new RoleAddedEvent(role)).collect(Collectors.toList());
	}

	protected List<Object> mapToRoleAddedEvent(IRole[] roles) {
		return Stream.of(roles).map(role -> new RoleAddedEvent(role)).collect(Collectors.toList());
	}

}
