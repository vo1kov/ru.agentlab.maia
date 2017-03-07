package ru.agentlab.maia.agent;

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

import ru.agentlab.maia.IRole;
import ru.agentlab.maia.agent.RoleBase;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#removeAll(IRole[])}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_removeAllArray_PositiveUnitTests extends RoleBaseAbstractTest {

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* ---------------------------------------------------------------------------------------------------------------------------
        /*|       | Args                     | State                  | Result                                                        |
		/*| ##    |---------------------------------------------------|---------------------------------------------------------------|
        /*|       | role                     | roles before           | returns | roles after                | events                 |
        /* ---------------------------------------------------------------------------------------------------------------------------
		/*   0 */ { new IRole[]{},           new IRole[]{},           false,    new IRole[]{},               new Object[] {} },
		/*   1 */ { new IRole[]{R1},         new IRole[]{},           false,    new IRole[]{},               new Object[] {} },
		/*   2 */ { new IRole[]{R1, R2},     new IRole[]{},           false,    new IRole[]{},               new Object[] {} }, 
		
		/*   3 */ { new IRole[]{},           new IRole[]{R1},         false,    new IRole[]{R1},             new Object[] {} }, 
		/*   4 */ { new IRole[]{R1},         new IRole[]{R1},         true,     new IRole[]{},               new Object[] {removed(R1)} }, 
		/*   5 */ { new IRole[]{R2},         new IRole[]{R1},         false,    new IRole[]{R1},             new Object[] {} }, 
		/*   6 */ { new IRole[]{R1, R2},     new IRole[]{R1},         true,     new IRole[]{},               new Object[] {removed(R1)} }, 
		/*   7 */ { new IRole[]{R2, R3},     new IRole[]{R1},         false,    new IRole[]{R1},             new Object[] {} }, 
		
		/*   8 */ { new IRole[]{R1},         new IRole[]{R1, R2, R3}, true,     new IRole[]{R2, R3},         new Object[] {removed(R1)} }, 
		/*   9 */ { new IRole[]{R2, R3},     new IRole[]{R1, R2, R3}, true,     new IRole[]{R1},             new Object[] {removed(R2), removed(R3)} }, 
		/*  10 */ { new IRole[]{R1, R2, R3}, new IRole[]{R1, R2, R3}, true,     new IRole[]{},               new Object[] {removed(R1), removed(R2), removed(R3)} }, 
		/*  11 */ { new IRole[]{R4},         new IRole[]{R1, R2, R3}, false,    new IRole[]{R1, R2, R3},     new Object[] {} }, 
		/*  12 */ { new IRole[]{R2, R4},     new IRole[]{R1, R2, R3}, true,     new IRole[]{R1, R3},         new Object[] {removed(R2)} }, 
		// @formatter:on
		});
	}

	@Parameter(0)
	public IRole[] rolesToRemove;

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
		boolean result = roleBase.removeAll(rolesToRemove);
		// Then
		assertThat(result, equalTo(expected));
		assertThat(roleBase.getRoles(), containsInAnyOrder(rolesAfter));
		thenQueueFired(events);
	}

}
