package ru.agentlab.maia.agent.impl;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.when;

import java.util.Collections;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#create(Object)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createObject_PositiveUnitTests extends RoleBaseAbstractTest {

	@Test
	public void dummyService() {
		// Given
		Object objectRole = givenDummyService();
		IPlan<?>[] plans = givenDummyPlans(2);
		when(roleBase.getPlans(objectRole)).thenReturn(plans);
		// When
		IRole result = roleBase.create(objectRole);
		// Then
		assertThat(result, notNullValue());
		assertThat(result.getRoleObject(), notNullValue());
		assertThat(result.getRoleObject(), equalTo(objectRole));
		assertThat(result.getExtra(), notNullValue());
		assertThat(result.getExtra(), equalTo(Collections.emptyMap()));
		assertThat(result.getPlans(), notNullValue());
		assertThat(result.getPlans(), equalTo(plans));
	}

}
