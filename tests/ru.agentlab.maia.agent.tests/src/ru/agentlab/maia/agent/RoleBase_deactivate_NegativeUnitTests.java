package ru.agentlab.maia.agent;

import static org.mockito.Mockito.verifyNoMoreInteractions;

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
 * Tests for {@link RoleBase#deactivate(IRole)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_deactivate_NegativeUnitTests extends RoleBaseAbstractTest {

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* ------------------------------------------------------------------------------------------------------------------------------
        /*|       | Args  | State                  | Result                                                                              |
		/*| ##    |--------------------------------|-------------------------------------------------------------------------------------|
        /*|       | role  | roles                  | throws                         | Message                                            |
        /* ------------------------------------------------------------------------------------------------------------------------------
		/*   0 */ { null, new IRole[]{R1},         NullPointerException.class,      "Role to deactivate should be non null" }, 
		/*   1 */ { R1,   new IRole[]{},           IllegalArgumentException.class,  "Unknown role to deactivate, role should exists into role base" }, 
		/*   2 */ { R2,   new IRole[]{R1},         IllegalArgumentException.class,  "Unknown role to deactivate, role should exists into role base" }, 
		/*   2 */ { R3,   new IRole[]{R1, R2},     IllegalArgumentException.class,  "Unknown role to deactivate, role should exists into role base" }, 
		/*   3 */ { R4,   new IRole[]{R1, R2, R3}, IllegalArgumentException.class,  "Unknown role to deactivate, role should exists into role base" }, 
		// @formatter:on
		});
	}

	@Parameter(0)
	public IRole roleToActivate;

	@Parameter(1)
	public IRole[] rolesBefore;

	@Parameter(2)
	public Class<? extends Exception> expected;

	@Parameter(3)
	public String message;

	@Test
	public void evaluateTestCase() {
		// Given
		givenStoredRoles(rolesBefore);
		thrown.expect(expected);
		thrown.expectMessage(message);
		// When
		roleBase.deactivate(roleToActivate);
		// Then
		verifyNoMoreInteractions(eventQueue);
	}

}
