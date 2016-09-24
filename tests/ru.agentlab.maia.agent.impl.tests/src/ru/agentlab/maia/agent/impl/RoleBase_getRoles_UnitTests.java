package ru.agentlab.maia.agent.impl;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.empty;
import static org.junit.Assert.assertThat;

import java.util.Collection;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#getRoles()}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_getRoles_UnitTests extends RoleBaseAbstractTest {

	@Test
	public void whenHave0Roles() {
		// Given
		givenEmptyRoles();
		// When
		Collection<IRole> result = whenGetRoles();
		// Then
		assertThat(result, empty());
	}

	@Test
	public void whenHave1Roles() {
		// Given
		Collection<IRole> roles = givenNewRolesCollection(1);
		givenStoredRoles(roles);
		// When
		Collection<IRole> result = whenGetRoles();
		// Then
		assertThat(result, containsInAnyOrder(roles.toArray(new IRole[roles.size()])));
	}

	@Test
	public void whenHave10Roles() {
		// Given
		Collection<IRole> roles = givenNewRolesCollection(10);
		givenStoredRoles(roles);
		// When
		Collection<IRole> result = whenGetRoles();
		// Then
		assertThat(result, containsInAnyOrder(roles.toArray(new IRole[roles.size()])));
	}

}
