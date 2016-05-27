package ru.agentlab.maia.agent;

import static org.hamcrest.Matchers.contains;
import static org.hamcrest.Matchers.iterableWithSize;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.hamcrest.Matcher;
import org.hamcrest.Matchers;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IConverter;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.event.BeliefClassificationAddedEvent;
import ru.agentlab.maia.event.BeliefDataPropertyAddedEvent;
import ru.agentlab.maia.event.BeliefObjectPropertyAddedEvent;
import ru.agentlab.maia.event.GoalClassificationAddedEvent;
import ru.agentlab.maia.event.GoalDataPropertyAddedEvent;
import ru.agentlab.maia.event.GoalObjectPropertyAddedEvent;
import ru.agentlab.maia.event.RoleAddedEvent;
import ru.agentlab.maia.event.RoleResolvedEvent;
import ru.agentlab.maia.event.RoleUnresolvedEvent;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.ConverterException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ResolveException;

/**
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
@SuppressWarnings("rawtypes")
public class Agent_internalAddRole_Test {

	// --------------- Injector variants----------------
	private static final Class<ContainerException> CONTAIN_EXC = ContainerException.class;
	private static final Class<InjectorException> INJECT_EXC = InjectorException.class;
	private static final Object ROLE_MOCK = mock(Object.class);

	// --------------- Converter plans variants----------------
	private static final Class<ConverterException> CONVERT_EXC = ConverterException.class;
	private static final IPlan plan1 = mock(IPlan.class);
	private static final IPlan plan2 = mock(IPlan.class);
	private static final IPlan plan3 = mock(IPlan.class);
	private static final EventType event1 = EventType.BELIEF_CLASSIFICATION_ADDED;
	private static final EventType event2 = EventType.BELIEF_DATA_PROPERTY_REMOVED;
	private static final EventType event3 = EventType.GOAL_CLASSIFICATION_ADDED;
	private static final Map<IPlan, EventType> PLANS_EMPTY = Collections.emptyMap();
	private static final Map<IPlan, EventType> PLANS_3 = ImmutableMap.of(plan1, event1, plan2, event2, plan3, event3);

	// --------------- Converter initial beliefs variants----------------
	private static final OWLClassAssertionAxiom beliefAxiom1 = mock(OWLClassAssertionAxiom.class);
	private static final OWLDataPropertyAssertionAxiom beliefAxiom2 = mock(OWLDataPropertyAssertionAxiom.class);
	private static final OWLObjectPropertyAssertionAxiom beliefAxiom3 = mock(OWLObjectPropertyAssertionAxiom.class);
	private static final List<OWLAxiom> INITIAL_BELIEFS_EMPTY = Collections.emptyList();
	private static final List<OWLAxiom> INITIAL_BELIEFS_3 = ImmutableList.of(beliefAxiom1, beliefAxiom2, beliefAxiom3);

	// --------------- Converter initial goals variants----------------
	private static final OWLClassAssertionAxiom goalAxiom1 = mock(OWLClassAssertionAxiom.class);
	private static final OWLDataPropertyAssertionAxiom goalAxiom2 = mock(OWLDataPropertyAssertionAxiom.class);
	private static final OWLObjectPropertyAssertionAxiom goalAxiom3 = mock(OWLObjectPropertyAssertionAxiom.class);
	private static final List<OWLAxiom> INITIAL_GOALS_EMPTY = Collections.emptyList();
	private static final List<OWLAxiom> INITIAL_GOALS_3 = ImmutableList.of(goalAxiom1, goalAxiom2, goalAxiom3);

	// --------------- Event Queue variants----------------
	// @formatter:off
	private static final IEvent[] ADD_RESOLVE_EVENTS = new IEvent[] { 
		new RoleAddedEvent(ROLE_MOCK),
		new RoleResolvedEvent(ROLE_MOCK) 
	};
	private static final IEvent[] ADD_RESOLVE_BELIEFS_EVENTS = new IEvent[] {
		new RoleAddedEvent(ROLE_MOCK),
		new BeliefClassificationAddedEvent(beliefAxiom1),
		new BeliefDataPropertyAddedEvent(beliefAxiom2),
		new BeliefObjectPropertyAddedEvent(beliefAxiom3),
		new RoleResolvedEvent(ROLE_MOCK),
	};
	private static final IEvent[] ADD_RESOLVE_BELIEFS_GOALS_EVENTS = new IEvent[] {
		new RoleAddedEvent(ROLE_MOCK),
		new BeliefClassificationAddedEvent(beliefAxiom1),
		new BeliefDataPropertyAddedEvent(beliefAxiom2),
		new BeliefObjectPropertyAddedEvent(beliefAxiom3),
		new GoalClassificationAddedEvent(goalAxiom1),
		new GoalDataPropertyAddedEvent(goalAxiom2),
		new GoalObjectPropertyAddedEvent(goalAxiom3),
		new RoleResolvedEvent(ROLE_MOCK),
	};
	private static final IEvent[] ADD_RESOLVE_GOALS_EVENTS = new IEvent[] {
		new RoleAddedEvent(ROLE_MOCK),
		new GoalClassificationAddedEvent(goalAxiom1),
		new GoalDataPropertyAddedEvent(goalAxiom2),
		new GoalObjectPropertyAddedEvent(goalAxiom3),
		new RoleResolvedEvent(ROLE_MOCK),
	};
	private static final IEvent[] UNRESOLVE_EVENT = new IEvent[] { 
		new RoleUnresolvedEvent(Object.class) 
	};
	// @formatter:on

	@Parameters
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* ----------------------------------------------------------------------------------------------------------------
		 *|  	| IInjector     | IConverter                                             | Event Queue                     |
		/*  ##  -----------------------------------------------------------------------------------------------------------
		 *|  	| make          | getPlans   | getInitialBeliefs    | getInitialGoals    | events                          |
		 *----------------------------------------------------------------------------------------------------------------*/
		/*  0 */ { ROLE_MOCK,   PLANS_3,     INITIAL_BELIEFS_3,     INITIAL_GOALS_3,     ADD_RESOLVE_BELIEFS_GOALS_EVENTS },
		/*  1 */ { ROLE_MOCK,   PLANS_3,     INITIAL_BELIEFS_EMPTY, INITIAL_GOALS_3,     ADD_RESOLVE_GOALS_EVENTS },
		/*  2 */ { ROLE_MOCK,   PLANS_3,     INITIAL_BELIEFS_3,     INITIAL_GOALS_EMPTY, ADD_RESOLVE_BELIEFS_EVENTS },
		/*  3 */ { ROLE_MOCK,   PLANS_3,     INITIAL_BELIEFS_EMPTY, INITIAL_GOALS_EMPTY, ADD_RESOLVE_EVENTS },
		/*  4 */ { ROLE_MOCK,   PLANS_EMPTY, INITIAL_BELIEFS_EMPTY, INITIAL_GOALS_EMPTY, ADD_RESOLVE_EVENTS },
		// Negative tests
		/*  5 */ { ROLE_MOCK,   PLANS_3,     INITIAL_BELIEFS_3,     CONVERT_EXC,         UNRESOLVE_EVENT },
		/*  6 */ { ROLE_MOCK,   PLANS_3,     CONVERT_EXC,           INITIAL_GOALS_3,     UNRESOLVE_EVENT },
		/*  7 */ { ROLE_MOCK,   CONVERT_EXC, INITIAL_BELIEFS_3,     INITIAL_GOALS_3,     UNRESOLVE_EVENT },
		/*  8 */ { INJECT_EXC,  PLANS_3,     INITIAL_BELIEFS_3,     INITIAL_GOALS_3,     UNRESOLVE_EVENT },
		/*  9 */ { CONTAIN_EXC, PLANS_3,     INITIAL_BELIEFS_3,     INITIAL_GOALS_3,     UNRESOLVE_EVENT },
		// @formatter:on
		});
	}

	@Rule
	public LoggerRule rule = new LoggerRule();

	@Parameter(0)
	public Object injectorResult;

	@Parameter(1)
	public Object plans;

	@Parameter(2)
	public Object initialBeliefs;

	@Parameter(3)
	public Object initialGoals;

	@Parameter(4)
	public IEvent[] events;

	@Test
	public void testCase() throws InjectorException, ContainerException, ConverterException {
		// Given
		Agent agent = new Agent();
		agent.container = mockContainer(mockInjector());
		agent.converter = mockConverter();

		// When
		try {
			agent.internalAddRole(Object.class, Collections.emptyMap());
		} catch (ResolveException e) {
		}

		// Then
		agent.eventQueue.stream().forEach(System.out::println);
		assertThat(agent.eventQueue, iterableWithSize(events.length));
		List<Matcher<? super IEvent<?>>> matchers = Stream.of(events).map(Matchers::equalTo)
				.collect(Collectors.toList());
		assertThat(agent.eventQueue, contains(matchers));
	}

	@SuppressWarnings("unchecked")
	public IConverter mockConverter() throws ConverterException {
		IConverter converter = mock(IConverter.class);
		if (plans instanceof Class) {
			when(converter.getPlans(ROLE_MOCK)).thenThrow((Class<? extends Exception>) plans);
		} else {
			when(converter.getPlans(ROLE_MOCK)).thenReturn((Map<IPlan, EventType>) plans);
		}
		if (initialBeliefs instanceof Class) {
			when(converter.getInitialBeliefs(ROLE_MOCK)).thenThrow((Class<? extends Exception>) initialBeliefs);
		} else {
			when(converter.getInitialBeliefs(ROLE_MOCK)).thenReturn((List<OWLAxiom>) initialBeliefs);
		}
		if (initialGoals instanceof Class) {
			when(converter.getInitialGoals(ROLE_MOCK)).thenThrow((Class<? extends Exception>) initialGoals);
		} else {
			when(converter.getInitialGoals(ROLE_MOCK)).thenReturn((List<OWLAxiom>) initialGoals);
		}
		return converter;
	}

	public IContainer mockContainer(IInjector injector) {
		IContainer container = mock(IContainer.class);
		when(container.getInjector()).thenReturn(injector);
		return container;
	}

	@SuppressWarnings("unchecked")
	public IInjector mockInjector() throws InjectorException, ContainerException {
		IInjector injector = mock(IInjector.class);
		if (injectorResult instanceof Class) {
			when(injector.make(Object.class)).thenThrow((Class<? extends Exception>) injectorResult);
		} else {
			when(injector.make(Object.class)).thenReturn(injectorResult);
		}
		return injector;
	}

}