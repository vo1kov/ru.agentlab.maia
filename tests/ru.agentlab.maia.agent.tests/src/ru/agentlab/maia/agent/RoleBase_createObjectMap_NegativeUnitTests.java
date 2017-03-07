package ru.agentlab.maia.agent;

import static org.mockito.Mockito.mock;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;

import ru.agentlab.maia.agent.RoleBase;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#create(Object, java.util.Map)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createObjectMap_NegativeUnitTests extends RoleBaseAbstractTest {

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* -------------------------------------------------------------------------------------------------------------------------------------------
        /*|       | Arguments                                    | Result                                                                             |
		/*| ##    |----------------------------------------------|------------------------------------------------------------------------------------|
        /*|       | service                     | extra          | throws                        | Message                                            |
        /* -------------------------------------------------------------------------------------------------------------------------------------------
        // nulls
		/*   0 */ { null,                       mock(Map.class), NullPointerException.class,     "Role should be non null" },
		/*   0 */ { null,                       null,            NullPointerException.class,     "Role should be non null" },
		/*   0 */ { mock(Object.class),         null,            NullPointerException.class,     "Extra should be non null, use empty map instead" },
		// primitive wrappers
		/*   1 */ { Byte.valueOf((byte) 1),     mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   2 */ { Short.valueOf((short) 2),   mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   3 */ { Integer.valueOf((int) 3),   mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   4 */ { Long.valueOf((long) 4L),    mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   5 */ { Float.valueOf((float) 5.6F),mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   6 */ { Double.valueOf((double) 7D),mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   7 */ { Boolean.valueOf(true),      mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   8 */ { Character.valueOf('w'),     mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		// @formatter:on
		});
	}

	@Parameter(0)
	public Object service;

	@Parameter(1)
	public Map<String, Object> extra;

	@Parameter(2)
	public Class<? extends Exception> exception;

	@Parameter(3)
	public String message;

	@Test
	public void evaluateTestCase() {
		// Given
		thrown.expect(exception);
		thrown.expectMessage(message);
		// When
		roleBase.create(service, extra);
	}

}
