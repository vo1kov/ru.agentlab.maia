package ru.agentlab.maia.agent;

import java.util.Arrays;
import java.util.Collection;

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
 * Tests for {@link RoleBase#create(Class)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createClass_NegativeUnitTests extends RoleBaseAbstractTest {

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* --------------------------------------------------------------------------------------------------------------
        /*|       | Arguments       | Result                                                                             |
		/*| ##    |-----------------|------------------------------------------------------------------------------------|
        /*|       | clazz           | throws                        | Message                                            |
        /* --------------------------------------------------------------------------------------------------------------
        // nulls
		/*   0 */ { null,           NullPointerException.class,     "Role class to create should be non null" },
		// primitive types
		/*   1 */ { byte.class,     IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   2 */ { short.class,    IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   3 */ { int.class,      IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   4 */ { long.class,     IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   5 */ { float.class,    IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   6 */ { double.class,   IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   7 */ { boolean.class,  IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   8 */ { char.class,     IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   9 */ { void.class,     IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		// primitive wrappers
		/*  10 */ { Byte.class,     IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  11 */ { Short.class,    IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  12 */ { Integer.class,  IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  13 */ { Long.class,     IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  14 */ { Float.class,    IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  15 */ { Double.class,   IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  16 */ { Boolean.class,  IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  17 */ { Character.class,IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		// @formatter:on
		});
	}

	@Parameter(0)
	public Class<?> clazz;

	@Parameter(1)
	public Class<? extends Exception> exception;

	@Parameter(2)
	public String message;

	@Test
	public void evaluateTestCase() {
		// Given
		thrown.expect(exception);
		thrown.expectMessage(message);
		// When
		roleBase.create(clazz);
	}

}
