package ru.agentlab.maia.agent.match;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.Map;

import org.junit.experimental.theories.DataPoints;
import org.junit.experimental.theories.FromDataPoints;
import org.junit.experimental.theories.Theories;
import org.junit.experimental.theories.Theory;
import org.junit.runner.RunWith;
import org.mockito.Mockito;

import ru.agentlab.maia.agent.converter.Converter;
import ru.agentlab.maia.agent.test.doubles.BeliefAddedDummy;
import ru.agentlab.maia.annotation.PlanAdded;
import ru.agentlab.maia.annotation.PlanFailed;
import ru.agentlab.maia.annotation.PlanFinished;
import ru.agentlab.maia.annotation.PlanRemoved;
import ru.agentlab.maia.annotation.RoleAdded;
import ru.agentlab.maia.annotation.RoleRemoved;
import ru.agentlab.maia.annotation.RoleResolved;
import ru.agentlab.maia.annotation.RoleUnresolved;
import ru.agentlab.maia.event.PlanAddedEvent;
import ru.agentlab.maia.event.PlanFailedEvent;
import ru.agentlab.maia.event.PlanFinishedEvent;
import ru.agentlab.maia.event.PlanRemovedEvent;
import ru.agentlab.maia.event.RoleAddedEvent;
import ru.agentlab.maia.event.RoleRemovedEvent;
import ru.agentlab.maia.event.RoleResolvedEvent;
import ru.agentlab.maia.event.RoleUnresolvedEvent;

/**
 * 
 * <p>
 * Test cases:
 * 
 * <pre>
 * ╔════╦══════════════════════════════════════════════════════════╦═══════════╗
 * ║    ║                                                    input ║    output ║
 * ║ ## ╠══════════════════════════════╦═══════════════════════════╬═══════════╣
 * ║    ║                  annotations ║                 parameter ║    result ║
 * ╚════╩══════════════════════════════╩═══════════════════════════╩═══════════╝
 * │  0 │   @BeliefClassificationAdded │                        "" │ Exception │
 * │  1 │ @BeliefClassificationRemoved │                     "one" │ Exception │
 * │  2 │     @BeliefDataPropertyAdded │                 "one two" │ Exception │
 * │  3 │   @BeliefDataPropertyRemoved │           "one two three" │ Exception │
 * │  4 │   @BeliefObjectPropertyAdded │            "?a two three" │ Exception │
 * │  5 │ @BeliefObjectPropertyRemoved │             "?a ?b three" │ Exception │
 * │  6 │                              │                "?a ?b ?c" │   Matcher │
 * │  7 │                              │    "?a <http...#type> ?c" │   Matcher │
 * ├────┼──────────────────────────────┼───────────────────────────┼───────────┤
 * │  8 │     @GoalClassificationAdded │                        "" │ Exception │
 * │  9 │    @GoalClassificationFailed │                     "one" │ Exception │
 * │ 10 │  @GoalClassificationFinished │                 "one two" │ Exception │
 * │ 11 │   @GoalClassificationRemoved │           "one two three" │ Exception │
 * │ 12 │       @GoalDataPropertyAdded │            "?a two three" │ Exception │
 * │ 13 │      @GoalDataPropertyFailed │             "?a ?b three" │ Exception │
 * │ 14 │    @GoalDataPropertyFinished │                "?a ?b ?c" │   Matcher │
 * │ 15 │     @GoalDataPropertyRemoved │    "?a <http...#type> ?c" │   Matcher │
 * │ 16 │     @GoalObjectPropertyAdded │                           │           │
 * │ 17 │    @GoalObjectPropertyFailed │                           │           │
 * │ 18 │  @GoalObjectPropertyFinished │                           │           │
 * │ 19 │   @GoalObjectPropertyRemoved │                           │           │
 * ├────┼──────────────────────────────┼───────────────────────────┼───────────┤
 * │ 20 │                   @RoleAdded │                byte.class │ Exception │
 * │ 21 │                 @RoleRemoved │               short.class │ Exception │
 * │ 22 │                @RoleResolved │                 int.class │ Exception │
 * │ 23 │               @RoleUnesolved │                long.class │ Exception │
 * │ 24 │                              │               float.class │ Exception │
 * │ 25 │                              │              double.class │ Exception │
 * │ 26 │                              │             boolean.class │ Exception │
 * │ 27 │                              │                char.class │ Exception │
 * │ 28 │                              │              Object.class │ Exception │
 * │ 29 │                              │    BeliefAddedDummy.class │   Matcher │
 * ├────┼──────────────────────────────┼───────────────────────────┼───────────┤
 * │ 30 │                   @PlanAdded │                        "" │ Exception │
 * │ 31 │                 @PlanRemoved │ "BeliefAddedDummy::valid" │   Matcher │
 * │ 32 │                  @PlanFailed │  "BeliefAddedDummy::aaaa" │ Exception │
 * │ 33 │                @PlanFinished │      "BeliefAddedDummy::" │ Exception │
 * │ 34 │                              │                 "::valid" │ Exception │
 * └────┴──────────────────────────────┴───────────────────────────┴───────────┘
 * </pre>
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Theories.class)
public class ConverterToPlanTest {

	static Map<Class<?>, Class<?>> annotation2event = new HashMap<>();
	static {
		annotation2event.put(BeliefAdded.class, BeliefAddedEvent.class);
		annotation2event.put(BeliefRemoved.class, BeliefRemovedEvent.class);
		annotation2event.put(GoalAdded.class, GoalAddedEvent.class);
		annotation2event.put(GoalRemoved.class, GoalRemovedEvent.class);
		annotation2event.put(GoalFailed.class, GoalFailedEvent.class);
		annotation2event.put(GoalFinished.class, GoalFinishedEvent.class);
		annotation2event.put(PlanAdded.class, PlanAddedEvent.class);
		annotation2event.put(PlanRemoved.class, PlanRemovedEvent.class);
		annotation2event.put(PlanFailed.class, PlanFailedEvent.class);
		annotation2event.put(PlanFinished.class, PlanFinishedEvent.class);
		annotation2event.put(RoleAdded.class, RoleAddedEvent.class);
		annotation2event.put(RoleRemoved.class, RoleRemovedEvent.class);
		annotation2event.put(RoleResolved.class, RoleResolvedEvent.class);
		annotation2event.put(RoleUnresolved.class, RoleUnresolvedEvent.class);
	}

	// @formatter:off
	@DataPoints("belief annotations")
	public static Class<?>[] beliefAnnotations() {
		return new Class<?>[] { BeliefAdded.class, BeliefRemoved.class };
	}

	@DataPoints("goal annotations")
	public static Class<?>[] goalAnnotations() {
		return new Class<?>[] { GoalAdded.class, GoalRemoved.class, GoalFailed.class, GoalFinished.class };
	}

	@DataPoints("plan annotations")
	public static Class<?>[] planAnnotations() {
		return new Class<?>[] { PlanAdded.class, PlanRemoved.class, PlanFailed.class, PlanFinished.class };
	}

	@DataPoints("role annotations")
	public static Class<?>[] roleAnnotations() {
		return new Class<?>[] { RoleAdded.class, RoleRemoved.class, RoleResolved.class, RoleUnresolved.class };
	}

	@DataPoints("template parameters")
	public static String[] templateParameters() {
		return new String[] { "", "one", "one two", "one two three", "?a two three", "?a two three", "?a ?b three",
				"?a ?b ?c", "?a <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?c" };
	}

	@DataPoints("method reference parameters")
	public static String[] planParameters() {
		return new String[] { "", "BeliefAddedDummy::valid", "BeliefAddedDummy::aaaa", "BeliefAddedDummy::",
				"::valid" };
	}

	private static Map<String, IEventMatcher<?>> 

	@DataPoints("class parameters")
	public static Class<?>[] classParameters() {
		return new Class<?>[] {
			byte.class,
			short.class,
			int.class,
			long.class,
			float.class,
			double.class,
			boolean.class,
			char.class,
			Object.class,
			BeliefAddedDummy.class
		};
	}
	// @formatter:on

	@Theory
	public void testBeliefAdded(@FromDataPoints("template parameters") String parameter) {
		System.out.println("@BeliefAdded(\"" + parameter + "\")");
		BeliefAdded ann = Mockito.mock(BeliefAdded.class);
		Mockito.when(ann.value()).thenReturn(parameter);
		IEventMatcher<?> matcher = Converter.toMatcher(ann);
		assertNotNull(matcher);
		assertTrue(matcher instanceof BeliefBaseEventMatcher);
		BeliefBaseEventMatcher typedMatcher = (BeliefBaseEventMatcher) matcher;
		assertTrue(typedMatcher.getSubject());
	}

	@Theory
	public void testGoalAnnotations(@FromDataPoints("goal annotations") Class<?> annotation,
			@FromDataPoints("template parameters") String parameter) {
		System.out.println(annotation + "   " + parameter);
	}

	@Theory
	public void testPlanAnnotations(@FromDataPoints("plan annotations") Class<?> annotation,
			@FromDataPoints("method reference parameters") String parameter) {
		System.out.println(annotation + "   " + parameter);
	}

	@Theory
	public void testRoleAnnotations(@FromDataPoints("role annotations") Class<?> annotation,
			@FromDataPoints("class parameters") Class<?> parameter) {
		System.out.println(annotation + "   " + parameter);
	}

	class Triple {

	}

}
