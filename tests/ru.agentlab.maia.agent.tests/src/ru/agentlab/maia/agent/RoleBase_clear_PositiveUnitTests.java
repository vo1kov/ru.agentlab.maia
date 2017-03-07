package ru.agentlab.maia.agent;

import static org.hamcrest.Matchers.empty;
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
 * Tests for {@link RoleBase#clear()}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_clear_PositiveUnitTests extends RoleBaseAbstractTest {

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* -----------------------------------------------------------------------------------------------------------------------
        /*|       | State                    | Result                                                                             |
		/*| ##    |--------------------------|------------------------------------------------------------------------------------|
        /*|       | roles                    | notifies                                                                           |
        /* -----------------------------------------------------------------------------------------------------------------------
        // 0 roles
		/*   0 */ { new IRole[]{},           new Object[] {} },
		// 1 role                                  
		/*   1 */ { new IRole[]{I1},         new Object[] {removed(I1)} }, 
		/*   2 */ { new IRole[]{A1},         new Object[] {deactivated(A1), removed(A1)} }, 
		// 3 roles
		/*   3 */ { new IRole[]{I1, I2, I3}, new Object[] {removed(I1), removed(I2), removed(I3)} }, 
		/*   4 */ { new IRole[]{I1, A2, I3}, new Object[] {removed(I1), deactivated(A2), removed(A2), removed(I3)} },
		/*   5 */ { new IRole[]{A1, I2, A3}, new Object[] {deactivated(A1), removed(A1), removed(I2), deactivated(A3), removed(A3)} },
		/*   6 */ { new IRole[]{A1, A2, A3}, new Object[] {deactivated(A1), removed(A1), deactivated(A2), removed(A2), deactivated(A3), removed(A3)} }, 
		// @formatter:on
		});
	}

	@Parameter(0)
	public IRole[] roles;

	@Parameter(1)
	public Object[] events;

	@Test
	public void evaluateTestCase() {
		// Given
		givenStoredRoles(roles);
		// When
		roleBase.clear();
		// Then
		assertThat(roleBase.getRoles(), empty());
		thenQueueFired(events);
	}

}
