package ru.agentlab.maia.agent.impl;

import java.util.Collection;
import java.util.Collections;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import com.google.common.collect.Lists;

import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.agent.event.RoleDeactivatedEvent;
import ru.agentlab.maia.agent.event.RoleRemovedEvent;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#remove(IRole)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_remove_UnitTests extends RoleBaseAbstractTest {

	@Test(expected = NullPointerException.class)
	public void nullRole_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		IRole role = givenNullRole();
		// When
		whenRemove(role);
	}

	@Test(expected = NullPointerException.class)
	public void nullRole_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole role = givenNullRole();
		// When
		whenRemove(role);
	}

	@Test(expected = NullPointerException.class)
	public void nullRole_whenHave5Roles() {
		// Given
		givenStoredRoles(5);
		IRole role = givenNullRole();
		// When
		whenRemove(role);
	}

	@Test
	public void newRole_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		IRole role = givenNewRole();
		// When
		boolean result = whenRemove(role);
		// Then
		thenResult(result, false);
		thenRolesSize(0);
		thenRolesEmpty();
		thenQueueNotFired();
	}

	@Test
	public void newRole_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole role = givenNewRole();
		// When
		boolean result = whenRemove(role);
		// Then
		thenResult(result, false);
		thenRolesSize(1);
		thenRolesNotContains(role);
		thenQueueNotFired();
	}

	@Test
	public void newRole_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole role = givenNewRole();
		// When
		boolean result = whenRemove(role);
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenRolesNotContains(role);
		thenQueueNotFired();
	}

	@Test
	public void existingInactiveRole_whenHave1Roles() {
		// Given
		IRole role = givenInactiveRole();
		givenStoredRoles(role);
		// When
		boolean result = whenRemove(role);
		// Then
		thenResult(result, true);
		thenRolesSize(0);
		thenRolesEmpty();
		thenQueueFired(Collections.singletonList(new RoleRemovedEvent(role)));

	}

	@Test
	public void existingInactiveRole_whenHave100Roles() {
		// Given
		Collection<IRole> roles = givenInactiveRoles(100);
		givenStoredRoles(roles);
		IRole role = givenExistingRole();
		// When
		boolean result = whenRemove(role);
		// Then
		thenResult(result, true);
		thenRolesSize(99);
		thenRolesNotContains(role);
		thenQueueFired(Collections.singletonList(new RoleRemovedEvent(role)));
	}

	@Test
	public void existingActiveRole_whenHave1Roles() {
		// Given
		IRole role = givenActiveRole();
		givenStoredRoles(role);
		// When
		boolean result = whenRemove(role);
		// Then
		thenResult(result, true);
		thenRolesSize(0);
		thenRolesEmpty();
		thenQueueFired(Lists.newArrayList(new RoleDeactivatedEvent(role), new RoleRemovedEvent(role)));

	}

	@Test
	public void existingActiveRole_whenHave100Roles() {
		// Given
		Collection<IRole> roles = givenActiveRoles(100);
		givenStoredRoles(roles);
		IRole role = givenExistingRole();
		// When
		boolean result = whenRemove(role);
		// Then
		thenResult(result, true);
		thenRolesSize(99);
		thenRolesNotContains(role);
		thenQueueFired(Lists.newArrayList(new RoleDeactivatedEvent(role), new RoleRemovedEvent(role)));
	}

}
