package ru.agentlab.maia.agent;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

import javax.annotation.PreDestroy;

import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;

import ru.agentlab.maia.IPlan;
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
public class RoleBase_deactivate_PositiveUnitTests extends RoleBaseAbstractTest {

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* ---------------------------------------------------------------------------
        /*|       | Args | State                  | Result                            |
		/*| ##    |-------------------------------|-----------------------------------|
        /*|       | role | roles                  | returns | events                  |
        /* ---------------------------------------------------------------------------
		/*   0 */ { I1,  new IRole[]{I1},         false,    new Object[] {} }, 
		/*   1 */ { A1,  new IRole[]{A1},         true,     new Object[] {deactivated(A1)} }, 
		/*   2 */ { I2,  new IRole[]{I1, I2, I3}, false,    new Object[] {} }, 
		/*   3 */ { A3,  new IRole[]{A1, A2, A3}, true,     new Object[] {deactivated(A3)} }, 
		// @formatter:on
		});
	}

	@Parameter(0)
	public IRole roleToDeactivate;

	@Parameter(1)
	public IRole[] rolesBefore;

	@Parameter(2)
	public boolean deactivated;

	@Parameter(3)
	public Object[] events;

	@Test
	@SuppressWarnings("unchecked")
	public void evaluateTestCase() {
		// Given
		givenStoredRoles(rolesBefore);
		IPlan<?>[] plans = new IPlan[] { mock(IPlan.class), mock(IPlan.class), mock(IPlan.class) };
		Map<String, Object> extra = mock(Map.class);
		Object roleObject = mock(Object.class);
		when(roleToDeactivate.getRoleObject()).thenReturn(roleObject);
		when(roleToDeactivate.getPlans()).thenReturn(plans);
		when(roleToDeactivate.getExtra()).thenReturn(extra);
		// When
		boolean result = roleBase.deactivate(roleToDeactivate);
		// Then
		assertThat(result, equalTo(deactivated));
		if (deactivated) {
			verify(planBase).removeAll(roleToDeactivate.getPlans());
			verify(injector).uninject(roleToDeactivate.getRoleObject());
			verify(injector).invoke(roleToDeactivate.getRoleObject(), PreDestroy.class, roleToDeactivate.getExtra());
		}
		thenQueueFired(events);
	}

}
