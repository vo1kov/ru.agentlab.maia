package ru.agentlab.maia.agent.impl;

import static com.google.common.collect.Lists.newArrayList;
import static java.util.Collections.emptyList;
import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;

import java.util.Arrays;
import java.util.Collection;

import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;

import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#addAll(Collection)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_addAllCollection_PositiveUnitTests extends RoleBaseAbstractTest {

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* ---------------------------------------------------------------------------------------------------------------------------
        /*|       | Args                     | State                  | Result                                                        |
		/*| ##    |---------------------------------------------------|---------------------------------------------------------------|
        /*|       | role                     | roles before           | returns | roles after                | events                 |
        /* ---------------------------------------------------------------------------------------------------------------------------
		/*   0 */ { emptyList(),              new IRole[]{},           false,    new IRole[]{},               new Object[] {} },
		/*   1 */ { newArrayList(R1),         new IRole[]{},           true,     new IRole[]{R1},             new Object[] {added(R1)} },
		/*   2 */ { newArrayList(R1, R2),     new IRole[]{},           true,     new IRole[]{R1, R2},         new Object[] {added(R1), added(R2)} }, 
		/*   3 */ { emptyList(),              new IRole[]{R1},         false,    new IRole[]{R1},             new Object[] {} }, 
		/*   4 */ { newArrayList(R1),         new IRole[]{R1},         false,    new IRole[]{R1},             new Object[] {} }, 
		/*   5 */ { newArrayList(R2),         new IRole[]{R1},         true,     new IRole[]{R1, R2},         new Object[] {added(R2)} }, 
		/*   6 */ { newArrayList(R1, R2),     new IRole[]{R1},         true,     new IRole[]{R1, R2},         new Object[] {added(R2)} }, 
		/*   7 */ { newArrayList(R2, R3),     new IRole[]{R1},         true,     new IRole[]{R1, R2, R3},     new Object[] {added(R2), added(R3)} }, 
		/*   8 */ { newArrayList(R1),         new IRole[]{R1, R2, R3}, false,    new IRole[]{R1, R2, R3},     new Object[] {} }, 
		/*   9 */ { newArrayList(R2, R3),     new IRole[]{R1, R2, R3}, false,    new IRole[]{R1, R2, R3},     new Object[] {} }, 
		/*  10 */ { newArrayList(R1, R2, R3), new IRole[]{R1, R2, R3}, false,    new IRole[]{R1, R2, R3},     new Object[] {} }, 
		/*  11 */ { newArrayList(R4),         new IRole[]{R1, R2, R3}, true,     new IRole[]{R1, R2, R3, R4}, new Object[] {added(R4)} }, 
		/*  12 */ { newArrayList(R2, R4),     new IRole[]{R1, R2, R3}, true,     new IRole[]{R1, R2, R3, R4}, new Object[] {added(R4)} }, 
		// @formatter:on
		});
	}

	@Parameter(0)
	public Collection<IRole> rolesToAdd;

	@Parameter(1)
	public IRole[] rolesBefore;

	@Parameter(2)
	public boolean expected;

	@Parameter(3)
	public IRole[] rolesAfter;

	@Parameter(4)
	public Object[] events;

	@Test
	public void evaluateTestCase() {
		// Given
		givenStoredRoles(rolesBefore);
		// When
		boolean result = roleBase.addAll(rolesToAdd);
		// Then
		assertThat(result, equalTo(expected));
		assertThat(roleBase.getRoles(), containsInAnyOrder(rolesAfter));
		thenQueueFired(events);
	}

}
