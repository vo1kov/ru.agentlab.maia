package ru.agentlab.maia.agent.impl;

import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.agent.event.RoleAddedEvent;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#add(IRole)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_add_UnitTests extends RoleBaseAbstractTest {

	@Test(expected = NullPointerException.class)
	public void nullRole_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		IRole role = givenNullRole();
		// When
		whenAdd(role);
	}

	@Test(expected = NullPointerException.class)
	public void nullRole_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole role = givenNullRole();
		// When
		whenAdd(role);
	}

	@Test(expected = NullPointerException.class)
	public void nullRole_whenHave5Roles() {
		// Given
		givenStoredRoles(5);
		IRole role = givenNullRole();
		// When
		whenAdd(role);
	}

	@Test
	public void newRole_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		IRole role = givenNewRole();
		// When
		boolean result = whenAdd(role);
		// Then
		thenResult(result, true);
		thenRolesSize(1);
		thenRolesContains(role);
		thenQueueFired(Stream.of(role).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void newRole_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole role = givenNewRole();
		// When
		boolean result = whenAdd(role);
		// Then
		thenResult(result, true);
		thenRolesSize(2);
		thenRolesContains(role);
		thenQueueFired(Stream.of(role).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void newRole_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole role = givenNewRole();
		// When
		boolean result = whenAdd(role);
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContains(role);
		thenQueueFired(Stream.of(role).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void existingRole_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole role = givenExistingRole();
		// When
		boolean result = whenAdd(role);
		// Then
		thenResult(result, false);
		thenRolesSize(1);
		thenRolesContains(role);
		thenEventQueueNotFired();
	}

	@Test
	public void existingRole_whenHave100Roles() {
		// Given
		givenStoredRoles(100);
		IRole role = givenExistingRole();
		// When
		boolean result = whenAdd(role);
		// Then
		thenResult(result, false);
		thenRolesSize(100);
		thenRolesContains(role);
		thenEventQueueNotFired();
	}

}
