package ru.agentlab.maia.agent;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.doReturn;

import java.util.Collections;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IRole;
import ru.agentlab.maia.agent.RoleBase;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#create(Class)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createClass_PositiveUnitTests extends RoleBaseAbstractTest {

	@Test
	public void dummyServiceClass() {
		// Given
		Class<?> clazz = givenDummyServiceClass();
		Object objectRole = givenDummyService();
		IPlan<?>[] plans = givenDummyPlans(2);
		doReturn(objectRole).when(injector).make(clazz, Collections.emptyMap());
		doReturn(plans).when(roleBase).getPlans(objectRole);
		// When
		IRole result = roleBase.create(clazz);
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
