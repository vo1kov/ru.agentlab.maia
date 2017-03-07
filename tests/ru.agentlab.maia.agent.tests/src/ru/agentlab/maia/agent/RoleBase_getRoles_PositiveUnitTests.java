package ru.agentlab.maia.agent;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.verifyZeroInteractions;

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
 * Tests for {@link RoleBase#getRoles()}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_getRoles_PositiveUnitTests extends RoleBaseAbstractTest {

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* ----------------------------------------------------------
        /*|       | State                    | Result                |
		/*| ##    |--------------------------|-----------------------|
        /*|       | roles                    | returns               |
        /* ----------------------------------------------------------
		/*   0 */ { new IRole[]{},           new IRole[]{} },
		/*   1 */ { new IRole[]{R1},         new IRole[]{R1} }, 
		/*   2 */ { new IRole[]{R1, R2},     new IRole[]{R1, R2} }, 
		/*   3 */ { new IRole[]{R1, R2, R3}, new IRole[]{R1, R2, R3} }, 
		// @formatter:on
		});
	}

	@Parameter(0)
	public IRole[] roles;

	@Parameter(1)
	public IRole[] expected;

	@Test
	public void evaluateTestCase() {
		// Given
		givenStoredRoles(roles);
		// When
		Collection<IRole> result = roleBase.getRoles();
		// Then
		assertThat(result, containsInAnyOrder(expected));
		verifyZeroInteractions(eventQueue);
	}

}
