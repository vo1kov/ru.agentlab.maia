package ru.agentlab.maia.agent.impl;

import java.util.Collection;
import java.util.Collections;
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
 * Tests for {@link RoleBase#addAll(Collection)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_addAllCollection_UnitTests extends RoleBaseAbstractTest {

	@Test(expected = NullPointerException.class)
	public void nullCollection_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		Collection<IRole> roles = givenNullCollection();
		// When
		roleBase.addAll(roles);
	}

	@Test(expected = NullPointerException.class)
	public void nullCollection_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> roles = givenNullCollection();
		// When
		roleBase.addAll(roles);
	}

	@Test(expected = NullPointerException.class)
	public void nullCollection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> roles = givenNullCollection();
		// When
		roleBase.addAll(roles);
	}

	@Test
	public void emptyCollection_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		Collection<IRole> roles = Collections.emptyList();
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(0);
		thenEventQueueNotFired();
	}

	@Test
	public void emptyCollection_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> roles = Collections.emptyList();
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(1);
		thenEventQueueNotFired();
	}

	@Test
	public void emptyCollection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> roles = Collections.emptyList();
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenEventQueueNotFired();
	}

	@Test
	public void new0existing1Collection_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> roles = givenExistingRolesCollection(1);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(1);
		thenRolesContainsAll(roles);
		thenEventQueueNotFired();
	}

	@Test
	public void new0existing1Collection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> roles = givenExistingRolesCollection(1);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenRolesContainsAll(roles);
		thenEventQueueNotFired();
	}

	@Test
	public void new0existing10Collection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> roles = givenExistingRolesCollection(10);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenRolesContainsAll(roles);
		thenEventQueueNotFired();
	}

	@Test
	public void new1existing0Collection_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		Collection<IRole> newRoles = givenNewRolesCollection(1);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(1);
		thenRolesContainsAll(newRoles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing0Collection_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> newRoles = givenNewRolesCollection(1);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(2);
		thenRolesContainsAll(newRoles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing0Collection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(1);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContainsAll(newRoles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing1Collection_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> newRoles = givenNewRolesCollection(1);
		Collection<IRole> existingRoles = givenExistingRolesCollection(1);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(2);
		thenRolesContainsAll(roles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing1Collection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(1);
		Collection<IRole> existingRoles = givenExistingRolesCollection(1);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContainsAll(roles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing10Collection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(1);
		Collection<IRole> existingRoles = givenExistingRolesCollection(10);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContainsAll(roles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing0Collection_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		Collection<IRole> newRoles = givenNewRolesCollection(5);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(5);
		thenRolesContainsAll(newRoles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing0Collection_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> newRoles = givenNewRolesCollection(5);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(6);
		thenRolesContainsAll(newRoles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing0Collection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(5);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(15);
		thenRolesContainsAll(newRoles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing1Collection_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		Collection<IRole> newRoles = givenNewRolesCollection(5);
		Collection<IRole> existingRoles = givenExistingRolesCollection(1);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(6);
		thenRolesContainsAll(roles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing1Collection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(5);
		Collection<IRole> existingRoles = givenExistingRolesCollection(1);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(15);
		thenRolesContainsAll(roles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing10Collection_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		Collection<IRole> newRoles = givenNewRolesCollection(5);
		Collection<IRole> existingRoles = givenExistingRolesCollection(10);
		Collection<IRole> roles = Stream.concat(newRoles.stream(), existingRoles.stream()).collect(Collectors.toList());
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(15);
		thenRolesContainsAll(roles);
		thenQueueFired(newRoles.stream().map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

}
