package ru.agentlab.maia.agent.impl;

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

import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#create(Class, java.util.Map)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createClassMap_NegativeUnitTests extends RoleBaseAbstractTest {

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* -------------------------------------------------------------------------------------------------------------------------------
        /*|       | Arguments                        | Result                                                                             |
		/*| ##    |----------------------------------|------------------------------------------------------------------------------------|
        /*|       | clazz           | extra          | throws                        | Message                                            |
        /* -------------------------------------------------------------------------------------------------------------------------------
        // nulls
		/*   0 */ { null,           mock(Map.class), NullPointerException.class,     "Role class to create should be non null" },
		/*   1 */ { null,           null,            NullPointerException.class,     "Role class to create should be non null" },
		/*   2 */ { DummyService.class,null,         NullPointerException.class,     "Extra should be non null, use empty map instead" },
		// primitive types                     
		/*   3 */ { byte.class,     mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   4 */ { short.class,    mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   5 */ { int.class,      mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   6 */ { long.class,     mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   7 */ { float.class,    mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   8 */ { double.class,   mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*   9 */ { boolean.class,  mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  10 */ { char.class,     mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  11 */ { void.class,     mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		// primitive wrappers 
		/*  12 */ { Byte.class,     mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  13 */ { Short.class,    mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  14 */ { Integer.class,  mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  15 */ { Long.class,     mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  16 */ { Float.class,    mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  17 */ { Double.class,   mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  18 */ { Boolean.class,  mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		/*  19 */ { Character.class,mock(Map.class), IllegalArgumentException.class, "Role class to create should be non primitive type" }, 
		// @formatter:on
		});
	}

	@Parameter(0)
	public Class<?> clazz;

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
		roleBase.create(clazz, extra);
	}

}
