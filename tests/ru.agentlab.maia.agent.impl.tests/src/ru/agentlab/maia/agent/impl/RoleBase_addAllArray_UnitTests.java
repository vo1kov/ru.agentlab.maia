package ru.agentlab.maia.agent.impl;

import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.commons.lang3.ArrayUtils;
import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.agent.event.RoleAddedEvent;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#addAll(IRole[])}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_addAllArray_UnitTests extends RoleBaseAbstractTest {

	@Test(expected = NullPointerException.class)
	public void nullArray_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		IRole[] roles = givenNullArray();
		// When
		roleBase.addAll(roles);
	}

	@Test(expected = NullPointerException.class)
	public void nullArray_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole[] roles = givenNullArray();
		// When
		roleBase.addAll(roles);
	}

	@Test(expected = NullPointerException.class)
	public void nullArray_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] roles = givenNullArray();
		// When
		roleBase.addAll(roles);
	}

	@Test
	public void emptyArray_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		IRole[] roles = new IRole[0];
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(0);
		thenEventQueueNotFired();
	}

	@Test
	public void emptyArray_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole[] roles = new IRole[0];
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(1);
		thenEventQueueNotFired();
	}

	@Test
	public void emptyArray_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] roles = new IRole[0];
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenEventQueueNotFired();
	}

	@Test
	public void new0existing1Array_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole[] roles = givenExistingRolesArray(1);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(1);
		thenRolesContainsAll(roles);
		thenEventQueueNotFired();
	}

	@Test
	public void new0existing1Array_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] roles = givenExistingRolesArray(1);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenRolesContainsAll(roles);
		thenEventQueueNotFired();
	}

	@Test
	public void new0existing10Array_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] roles = givenExistingRolesArray(10);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, false);
		thenRolesSize(10);
		thenRolesContainsAll(roles);
		thenEventQueueNotFired();
	}

	@Test
	public void new1existing0Array_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		IRole[] newRoles = givenNewRolesArray(1);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(1);
		thenRolesContainsAll(newRoles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing0Array_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole[] newRoles = givenNewRolesArray(1);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(2);
		thenRolesContainsAll(newRoles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing0Array_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] newRoles = givenNewRolesArray(1);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContainsAll(newRoles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing1Array_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole[] newRoles = givenNewRolesArray(1);
		IRole[] existingRoles = givenExistingRolesArray(1);
		IRole[] roles = ArrayUtils.addAll(newRoles, existingRoles);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(2);
		thenRolesContainsAll(roles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing1Array_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] newRoles = givenNewRolesArray(1);
		IRole[] existingRoles = givenExistingRolesArray(1);
		IRole[] roles = ArrayUtils.addAll(newRoles, existingRoles);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContainsAll(roles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new1existing10Array_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] newRoles = givenNewRolesArray(1);
		IRole[] existingRoles = givenExistingRolesArray(10);
		IRole[] roles = ArrayUtils.addAll(newRoles, existingRoles);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(11);
		thenRolesContainsAll(roles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing0Array_whenHave0Roles() {
		// Given
		givenEmptyRoles();
		IRole[] newRoles = givenNewRolesArray(5);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(5);
		thenRolesContainsAll(newRoles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing0Array_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole[] newRoles = givenNewRolesArray(5);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(6);
		thenRolesContainsAll(newRoles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing0Array_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] newRoles = givenNewRolesArray(5);
		// When
		boolean result = whenAddAll(newRoles);
		// Then
		thenResult(result, true);
		thenRolesSize(15);
		thenRolesContainsAll(newRoles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing1Array_whenHave1Roles() {
		// Given
		givenStoredRoles(1);
		IRole[] newRoles = givenNewRolesArray(5);
		IRole[] existingRoles = givenExistingRolesArray(1);
		IRole[] roles = ArrayUtils.addAll(newRoles, existingRoles);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(6);
		thenRolesContainsAll(roles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing1Array_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] newRoles = givenNewRolesArray(5);
		IRole[] existingRoles = givenExistingRolesArray(1);
		IRole[] roles = ArrayUtils.addAll(newRoles, existingRoles);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(15);
		thenRolesContainsAll(roles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

	@Test
	public void new5existing10Array_whenHave10Roles() {
		// Given
		givenStoredRoles(10);
		IRole[] newRoles = givenNewRolesArray(5);
		IRole[] existingRoles = givenExistingRolesArray(10);
		IRole[] roles = ArrayUtils.addAll(newRoles, existingRoles);
		// When
		boolean result = whenAddAll(roles);
		// Then
		thenResult(result, true);
		thenRolesSize(15);
		thenRolesContainsAll(roles);
		thenQueueFired(Stream.of(newRoles).map(r -> new RoleAddedEvent(r)).collect(Collectors.toList()));
	}

}
