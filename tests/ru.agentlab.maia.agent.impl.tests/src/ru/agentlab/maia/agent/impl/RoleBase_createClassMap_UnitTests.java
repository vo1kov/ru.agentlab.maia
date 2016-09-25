package ru.agentlab.maia.agent.impl;

import static org.mockito.Mockito.verify;

import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#create(Class, java.util.Map)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createClassMap_UnitTests extends RoleBaseAbstractTest {

	@Test(expected = NullPointerException.class)
	public void nullClassEmptyCollection() {
		// Given
		Class<?> clazz = givenNullClass();
		Map<String, Object> map = givenEmptyMap();
		// When
		whenCreate(clazz, map);
	}

	@Test(expected = NullPointerException.class)
	public void dummyServiceClassNullCollection() {
		// Given
		Class<?> clazz = givenDummyServiceClass();
		Map<String, Object> map = givenNullMap();
		// When
		whenCreate(clazz, map);
	}

	@Test(expected = NullPointerException.class)
	public void nullClassNullCollection() {
		// Given
		Class<?> clazz = givenNullClass();
		Map<String, Object> map = givenNullMap();
		// When
		whenCreate(clazz, map);
	}

	@Test
	@Ignore
	public void should_makeWithInjector_whenValidArguments() {
		roleBase.create(DummyService.class);
		verify(injector).make(DummyService.class, givenEmptyMap());
	}

}
