package ru.agentlab.maia.agent.impl;

import java.util.Map;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#create(Object, java.util.Map)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createObjectMap_UnitTests extends RoleBaseAbstractTest {

	@Test(expected = NullPointerException.class)
	public void nullObjectEmptyCollection() {
		// Given
		Object objectRole = givenNullObject();
		Map<String, Object> map = givenEmptyMap();
		// When
		whenCreate(objectRole, map);
	}

	@Test(expected = NullPointerException.class)
	public void dummyServiceNullCollection() {
		// Given
		Object objectRole = givenDummyService();
		Map<String, Object> map = givenNullMap();
		// When
		whenCreate(objectRole, map);
	}

	@Test(expected = NullPointerException.class)
	public void nullObjectNullCollection() {
		// Given
		Object objectRole = givenNullObject();
		Map<String, Object> map = givenNullMap();
		// When
		whenCreate(objectRole, map);
	}

}
