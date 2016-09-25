package ru.agentlab.maia.agent.impl;

import java.util.Collection;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#addAll(java.util.stream.Stream)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_addAllStream_UnitTests extends RoleBaseAbstractTest {

	@Test(expected = NullPointerException.class)
	public void nullStream_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		Stream<IRole> roles = givenNullStream();
		// When
		whenAddAll(roles);
	}

	@Test(expected = NullPointerException.class)
	public void nullStream_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Stream<IRole> roles = givenNullStream();
		// When
		whenAddAll(roles);
	}

	@Test(expected = NullPointerException.class)
	public void nullStream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Stream<IRole> roles = givenNullStream();
		// When
		whenAddAll(roles);
	}

	@Test
	public void emptyStream_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		Stream<IRole> roles = givenEmptyStream();
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(0);
		thenQueueNotFired();
	}

	@Test
	public void emptyStream_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Stream<IRole> roles = givenEmptyStream();
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(1);
		thenQueueNotFired();
	}

	@Test
	public void emptyStream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Stream<IRole> roles = givenEmptyStream();
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenQueueNotFired();
	}

	@Test
	public void new0existing1Stream_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> roles = givenExistingRolesCollection(1);
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, false);
		thenRolesSize(1);
		thenRolesContainsAll(roles);
		thenQueueNotFired();
	}

	@Test
	public void new0existing1Stream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> roles = givenExistingRolesCollection(1);
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenRolesContainsAll(roles);
		thenQueueNotFired();
	}

	@Test
	public void new0existing10Stream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> roles = givenExistingRolesCollection(10);
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenRolesContainsAll(roles);
		thenQueueNotFired();
	}

	@Test
	public void new1existing0Stream_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		Collection<IRole> roles = givenNewRolesCollection(1);
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(1);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(roles));
	}

	@Test
	public void new1existing0Stream_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> roles = givenNewRolesCollection(1);
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(2);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(roles));
	}

	@Test
	public void new1existing0Stream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> roles = givenNewRolesCollection(1);
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(roles));
	}

	@Test
	public void new1existing1Stream_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> newRoles = givenNewRolesCollection(1);
		Collection<IRole> existingRoles = givenExistingRolesCollection(1);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(2);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(newRoles));
	}

	@Test
	public void new1existing1Stream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(1);
		Collection<IRole> existingRoles = givenExistingRolesCollection(1);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(newRoles));
	}

	@Test
	public void new1existing10Stream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(1);
		Collection<IRole> existingRoles = givenExistingRolesCollection(10);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(newRoles));
	}

	@Test
	public void new5existing0Stream_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		Collection<IRole> roles = givenNewRolesCollection(5);
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(5);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(roles));
	}

	@Test
	public void new5existing0Stream_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> roles = givenNewRolesCollection(5);
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(6);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(roles));
	}

	@Test
	public void new5existing0Stream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> roles = givenNewRolesCollection(5);
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(15);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(roles));
	}

	@Test
	public void new5existing1Stream_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> newRoles = givenNewRolesCollection(5);
		Collection<IRole> existingRoles = givenExistingRolesCollection(1);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(6);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(newRoles));
	}

	@Test
	public void new5existing1Stream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(5);
		Collection<IRole> existingRoles = givenExistingRolesCollection(1);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(15);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(newRoles));
	}

	@Test
	public void new5existing10Stream_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(5);
		Collection<IRole> existingRoles = givenExistingRolesCollection(10);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles.stream());
		// Then
		thenResult(result, true);
		thenRolesSize(15);
		thenRolesContainsAll(roles);
		thenQueueFired(mapToRoleAddedEvent(newRoles));
	}

}
