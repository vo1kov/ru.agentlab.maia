package ru.agentlab.maia.agent.impl;

import java.util.Collection;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import com.google.common.collect.Lists;

import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.agent.event.RoleDeactivatedEvent;
import ru.agentlab.maia.agent.event.RoleRemovedEvent;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#clear()}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_clear_UnitTests extends RoleBaseAbstractTest {

	@Test
	public void whenHave0Roles() {
		// Given
		givenEmptyRoles();
		// When
		whenClear();
		// Then
		thenRolesEmpty();
		thenQueueNotFired();
	}

	@Test
	public void whenHave1InactiveRole() {
		// Given
		IRole role = givenInactiveRole();
		givenStoredRoles(role);
		// When
		whenClear();
		// Then
		thenRolesEmpty();
		thenQueueFired(Lists.newArrayList(new RoleRemovedEvent(role)));
	}

	@Test
	public void whenHave1ActiveRole() {
		// Given
		IRole role = givenActiveRole();
		givenStoredRoles(role);
		// When
		whenClear();
		// Then
		thenRolesEmpty();
		thenQueueFired(Lists.newArrayList(new RoleDeactivatedEvent(role), new RoleRemovedEvent(role)));
	}

	@Test
	public void whenHave3InactiveRoles() {
		// Given
		Collection<IRole> inactiveRoles = givenInactiveRoles(3);
		givenStoredRoles(inactiveRoles);
		// When
		whenClear();
		// Then
		thenRolesEmpty();
		thenQueueFired(inactiveRoles.stream().map(r -> new RoleRemovedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void whenHave3ActiveRoles() {
		// Given
		Collection<IRole> activeRoles = givenActiveRoles(3);
		givenStoredRoles(activeRoles);
		// When
		whenClear();
		// Then
		thenRolesEmpty();
		thenQueueFired(activeRoles.stream().map(role -> {
			return new Event[] { new RoleDeactivatedEvent(role), new RoleRemovedEvent(role) };
		}).flatMap(Stream::of).collect(Collectors.toList()));
	}

	@Test
	@SuppressWarnings("rawtypes")
	public void whenHave3Active3InactiveRoles() {
		// Given
		Collection<IRole> activeRoles = givenActiveRoles(3);
		Collection<IRole> inactiveRoles = givenInactiveRoles(3);
		Collection<IRole> roles = Stream
			.concat(activeRoles.stream(), inactiveRoles.stream())
			.collect(Collectors.toList());
		givenStoredRoles(roles);
		// When
		whenClear();
		// Then
		thenRolesEmpty();
		Stream<Event> activeRoleEvents = activeRoles.stream().map(role -> {
			return new Event[] { new RoleDeactivatedEvent(role), new RoleRemovedEvent(role) };
		}).flatMap(Stream::of);
		Stream<Event> inactiveRoleEvents = inactiveRoles.stream().map(RoleRemovedEvent::new);
		thenQueueFired(Stream.concat(activeRoleEvents, inactiveRoleEvents).collect(Collectors.toList()));
	}

}
