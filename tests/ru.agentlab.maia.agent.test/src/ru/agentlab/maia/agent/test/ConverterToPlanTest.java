package ru.agentlab.maia.agent.test;

import java.util.HashMap;
import java.util.Map;

import org.junit.experimental.theories.DataPoints;
import org.junit.experimental.theories.FromDataPoints;
import org.junit.experimental.theories.Theories;
import org.junit.experimental.theories.Theory;
import org.junit.runner.RunWith;

import ru.agentlab.maia.agent.event.BeliefAddedEvent;
import ru.agentlab.maia.agent.event.BeliefRemovedEvent;
import ru.agentlab.maia.agent.event.GoalAddedEvent;
import ru.agentlab.maia.agent.event.GoalFailedEvent;
import ru.agentlab.maia.agent.event.GoalFinishedEvent;
import ru.agentlab.maia.agent.event.GoalRemovedEvent;
import ru.agentlab.maia.agent.event.PlanAddedEvent;
import ru.agentlab.maia.agent.event.PlanFailedEvent;
import ru.agentlab.maia.agent.event.PlanFinishedEvent;
import ru.agentlab.maia.agent.event.PlanRemovedEvent;
import ru.agentlab.maia.agent.event.RoleAddedEvent;
import ru.agentlab.maia.agent.event.RoleRemovedEvent;
import ru.agentlab.maia.agent.event.RoleResolvedEvent;
import ru.agentlab.maia.agent.event.RoleUnresolvedEvent;
import ru.agentlab.maia.agent.test.doubles.BeliefAddedDummy;
import ru.agentlab.maia.annotation.BeliefAdded;
import ru.agentlab.maia.annotation.BeliefRemoved;
import ru.agentlab.maia.annotation.GoalAdded;
import ru.agentlab.maia.annotation.GoalFailed;
import ru.agentlab.maia.annotation.GoalFinished;
import ru.agentlab.maia.annotation.GoalRemoved;
import ru.agentlab.maia.annotation.PlanAdded;
import ru.agentlab.maia.annotation.PlanFailed;
import ru.agentlab.maia.annotation.PlanFinished;
import ru.agentlab.maia.annotation.PlanRemoved;
import ru.agentlab.maia.annotation.RoleAdded;
import ru.agentlab.maia.annotation.RoleRemoved;
import ru.agentlab.maia.annotation.RoleResolved;
import ru.agentlab.maia.annotation.RoleUnresolved;

/**
 * 
 * <p>
 * Test cases:
 * 
 * <pre>
 * ╔════╦════════════════════════════════════════════╦══════════════════════════╗
 * ║    ║                                      input ║                   output ║
 * ║ ## ╠════════════════╦═══════════════════════════╬══════════════════════════╣
 * ║    ║    annotations ║                 parameter ║                   result ║
 * ╚════╩════════════════╩═══════════════════════════╩══════════════════════════╝
 * │  0 │   @BeliefAdded │                        "" │  TemplateFormatException │
 * │  1 │ @BeliefRemoved │                     "one" │  TemplateFormatException │
 * │  2 │     @GoalAdded │                 "one two" │  TemplateFormatException │
 * │  3 │   @GoalRemoved │           "one two three" │   LiteralFormatException │
 * │  4 │    @GoalFailed │            "?a two three" │   LiteralFormatException │
 * │  5 │  @GoalFinished │             "?a ?b three" │   LiteralFormatException │
 * │  6 │                │                "?a ?b ?c" │                    valid │
 * │  7 │                │    "?a <http...#type> ?c" │                    valid │
 * ├────┼────────────────┼───────────────────────────┼──────────────────────────┤
 * │  0 │     @RoleAdded │                byte.class │ IllegalArgumentException │
 * │  1 │   @RoleRemoved │               short.class │ IllegalArgumentException │
 * │  2 │  @RoleResolved │                 int.class │ IllegalArgumentException │
 * │  3 │ @RoleUnesolved │                long.class │ IllegalArgumentException │
 * │  4 │                │               float.class │ IllegalArgumentException │
 * │  5 │                │              double.class │ IllegalArgumentException │
 * │  5 │                │             boolean.class │ IllegalArgumentException │
 * │  5 │                │                char.class │ IllegalArgumentException │
 * │  6 │                │              Object.class │ IllegalArgumentException │
 * │  7 │                │    BeliefAddedDummy.class │                    valid │
 * ├────┼────────────────┼───────────────────────────┼──────────────────────────┤
 * │  0 │     @PlanAdded │                        "" │  TemplateFormatException │
 * │  1 │   @PlanRemoved │ "BeliefAddedDummy::valid" │                    valid │
 * │  2 │    @PlanFailed │  "BeliefAddedDummy::aaaa" │  TemplateFormatException │
 * │  3 │  @PlanFinished │      "BeliefAddedDummy::" │  TemplateFormatException │
 * │  3 │                │                 "::valid" │  TemplateFormatException │
 * └────┴────────────────┴───────────────────────────┴──────────────────────────┘
 *  * - record marked as deleted
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
		return new Class<?>[] {
			BeliefAdded.class,
			BeliefRemoved.class
		};
    }
	
	@DataPoints("goal annotations")
    public static Class<?>[] goalAnnotations() {
		return new Class<?>[] {
			GoalAdded.class,
			GoalRemoved.class,
			GoalFailed.class,
			GoalFinished.class
		};
    }
	
	@DataPoints("plan annotations")
    public static Class<?>[] planAnnotations() {
		return new Class<?>[] {
			PlanAdded.class,
			PlanRemoved.class,
			PlanFailed.class,
			PlanFinished.class
		};
    }
	
	@DataPoints("role annotations")
    public static Class<?>[] roleAnnotations() {
		return new Class<?>[] {
			RoleAdded.class,
			RoleRemoved.class,
			RoleResolved.class,
			RoleUnresolved.class
		};
    }

	@DataPoints("template parameters")
	public static String[] templateParameters() {
		return new String[] {
			"",
			"one",
			"one two",
			"one two three",
			"?a two three",
			"?a two three",
			"?a ?b three",
			"?a ?b ?c",
			"?a <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?c"
		};
	}

	@DataPoints("method reference parameters")
	public static String[] planParameters() {
		return new String[] {
			"",
			"BeliefAddedDummy::valid",
			"BeliefAddedDummy::aaaa",
			"BeliefAddedDummy::",
			"::valid"
		};
	}

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
	public void testBeliefAnnotations(@FromDataPoints("belief annotations") Class<?> annotation,
			@FromDataPoints("template parameters") String parameter) {
		System.out.println(annotation + "   " + parameter);
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

}
