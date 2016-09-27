package ru.agentlab.maia.agent.impl;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.when;

import java.util.Map;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#create(Class, java.util.Map)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createClassMap_PositiveUnitTests extends RoleBaseAbstractTest {

	@Test
	public void dummyServiceClass() {
		// Given
		Class<?> clazz = givenDummyServiceClass();
		Map<String, Object> extra = givenDummyMap();
		Object objectRole = givenDummyService();
		IPlan<?>[] plans = givenDummyPlans(2);
		Object make = injector.make(clazz, extra);
		when(make).thenReturn(objectRole);
		when(roleBase.getPlans(objectRole)).thenReturn(plans);
		// When
		IRole result = roleBase.create(clazz, extra);
		// Then
		assertThat(result, notNullValue());
		assertThat(result.getRoleObject(), notNullValue());
		assertThat(result.getRoleObject(), equalTo(objectRole));
		assertThat(result.getExtra(), notNullValue());
		assertThat(result.getExtra(), equalTo(extra));
		assertThat(result.getPlans(), notNullValue());
		assertThat(result.getPlans(), equalTo(plans));
	}

}
