package ru.agentlab.maia.agent;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.instanceOf;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.spy;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Map;

import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;
import org.mockito.Mockito;

import ru.agentlab.maia.AgentState;
import ru.agentlab.maia.agent.doubles.DummyService;
import ru.agentlab.maia.annotation2.converter.Converter;
import ru.agentlab.maia.exception.ResolveException;
import ru.agentlab.maia.test.util.LoggerRule;

/**
 * <p>
 * Test side-effects of {@link Agent#internalAddRole(Class, Map)}.
 * <p>
 * Test converted initial beliefs, goals and plans are added into corresponding
 * agent bases. After all role object should be added into role base.
 * <p>
 * If some exception will be thrown while method execution then no belief, goal
 * or plan should be added.
 * 
 * @see #testCases()
 * @see #evaluateTestCase()
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class Agent_addRole_Test {

	private static final DummyService ROLE_MOCK = mock(DummyService.class);
	@SuppressWarnings("unchecked")
	private static final Map<String, Object> PARAMETERS_MOCK = mock(Map.class);
	private static final Map<String, Object> PARAMETERS_EMPTY = Collections.emptyMap();

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* -------------------------------------------------------------------------------------------------
		 *|      | Inputs                                 | State              | Outputs                    |
		 *|  ##  |------------------------------------------------------------------------------------------|
		 *|      | Role class           | Parameters      | Agent state        | Result                     |
		 *-------------------------------------------------------------------------------------------------*/
		/*  0 */ { DummyService.class,  PARAMETERS_MOCK,   AgentState.IDLE,     ROLE_MOCK },
		/*  1 */ { DummyService.class,  PARAMETERS_EMPTY,  AgentState.IDLE,     ROLE_MOCK },
		/*  2 */ { DummyService.class,  null,              AgentState.IDLE,     ROLE_MOCK },
		// Negative tests
		/*  3 */ { DummyService.class,  PARAMETERS_MOCK,   AgentState.UNKNOWN,  IllegalStateException.class },
		/*  4 */ { DummyService.class,  PARAMETERS_MOCK,   AgentState.ACTIVE,   IllegalStateException.class },
		/*  5 */ { DummyService.class,  PARAMETERS_MOCK,   AgentState.STOPPING, IllegalStateException.class },
		/*  6 */ { DummyService.class,  PARAMETERS_MOCK,   AgentState.WAITING,  IllegalStateException.class },
		/*  7 */ { DummyService.class,  PARAMETERS_MOCK,   AgentState.TRANSIT,  IllegalStateException.class },
		/*  8 */ { null,                PARAMETERS_MOCK,   AgentState.IDLE,     NullPointerException.class },
		// @formatter:on
		});
	}

	@Rule
	public LoggerRule rule = new LoggerRule(this);

	@Parameter(0)
	public Class<?> roleClass;

	@Parameter(1)
	public Map<String, Object> parameters;

	@Parameter(2)
	public AgentState state;

	@Parameter(3)
	public Object result;

	@Test
	public void evaluateTestCase() throws ResolveException {
		// Given
		Agent agent = spy(new Agent());
		agent.state = state;
		doReturn(ROLE_MOCK).when(agent).internalAddRole(Mockito.any(), Mockito.any(), Mockito.any());

		try {
			// When
			Object role = agent.addRole(roleClass, Converter.class, parameters);

			// Then
			if (result instanceof Class) {
				Assert.fail("Expected [" + result + "], but was: [" + role + "]");
			}
			verify(agent).internalAddRole(roleClass, Converter.class, parameters);
			assertThat(role, equalTo(result));
		} catch (Exception e) {
			// Then
			if (!(result instanceof Class)) {
				Assert.fail("Expected [" + result + "], but was: [" + e + "]");
			}
			assertThat(e, instanceOf((Class<?>) result));
			verify(agent, times(0)).internalAddRole(roleClass, Converter.class, parameters);
		}
	}

}