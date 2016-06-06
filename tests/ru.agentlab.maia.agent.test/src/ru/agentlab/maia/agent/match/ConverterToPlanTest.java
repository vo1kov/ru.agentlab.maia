package ru.agentlab.maia.agent.match;

import org.junit.experimental.theories.Theories;
import org.junit.runner.RunWith;

import ru.agentlab.maia.agent.converter.AnnotationFormatException;
import ru.agentlab.maia.annotation.BeliefClassificationAdded;
import ru.agentlab.maia.annotation.BeliefClassificationRemoved;
import ru.agentlab.maia.annotation.BeliefDataPropertyAdded;
import ru.agentlab.maia.annotation.BeliefDataPropertyRemoved;
import ru.agentlab.maia.annotation.BeliefObjectPropertyAdded;
import ru.agentlab.maia.annotation.BeliefObjectPropertyRemoved;
import ru.agentlab.maia.annotation.GoalClassificationAdded;
import ru.agentlab.maia.annotation.GoalClassificationFailed;
import ru.agentlab.maia.annotation.GoalClassificationFinished;
import ru.agentlab.maia.annotation.GoalClassificationRemoved;
import ru.agentlab.maia.annotation.GoalDataPropertyAdded;
import ru.agentlab.maia.annotation.GoalDataPropertyFailed;
import ru.agentlab.maia.annotation.GoalDataPropertyFinished;
import ru.agentlab.maia.annotation.GoalDataPropertyRemoved;
import ru.agentlab.maia.annotation.GoalObjectPropertyAdded;
import ru.agentlab.maia.annotation.GoalObjectPropertyFailed;
import ru.agentlab.maia.annotation.GoalObjectPropertyFinished;
import ru.agentlab.maia.annotation.GoalObjectPropertyRemoved;
import ru.agentlab.maia.annotation.PlanAdded;
import ru.agentlab.maia.annotation.PlanFailed;
import ru.agentlab.maia.annotation.PlanFinished;
import ru.agentlab.maia.annotation.PlanRemoved;
import ru.agentlab.maia.annotation.event.AddedRole;
import ru.agentlab.maia.annotation.event.ResolvedRole;
import ru.agentlab.maia.annotation.event.UnresolvedRole;

/**
 * 
 * Test cases:
 * URI = http://www.agentlab.ru/test/ontology#
 * <!-- @formatter:off -->
 * <table border="thin single black collapse">
 * 	<thead>
 * 		<tr><th rowspan="2">##<th colspan="2">Input<th colspan="2">Output
 * 		<tr><th>Annotations<th>Parameter<th>Result<th>Fields
 * 	<thead>
 * 	<tbody>
 * 		<tr><td colspan="5">Negative tests
 * 		<tr><td>0  <td rowspan="5">
 * 			{@link BeliefClassificationAdded @BeliefClassificationAdded}<br>
 * 			{@link BeliefClassificationRemoved @BeliefClassificationRemoved}<br>
 * 			{@link GoalClassificationAdded @GoalClassificationAdded}<br>
 * 			{@link GoalClassificationFailed @GoalClassificationFailed}<br>
 * 			{@link GoalClassificationFinished @GoalClassificationFinished}<br>
 * 			{@link GoalClassificationRemoved @GoalClassificationRemoved}<br>
 * 				   <td>"" 						<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>1  <td>"a" 						<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>2  <td>"a b c" 					<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>1  <td>"?a" 					<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>2  <td>"?a ?b ?c" 				<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>0  <td rowspan="6">
 * 			{@link GoalClassificationAdded @GoalClassificationAdded}<br>
 * 			{@link GoalClassificationFailed @GoalClassificationFailed}<br>
 * 			{@link GoalClassificationFinished @GoalClassificationFinished}<br>
 * 			{@link GoalClassificationRemoved @GoalClassificationRemoved}<br>
 * 				   <td>"?a b" 					<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>2  <td>"a ?b" 					<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>2  <td>"?a ?b" 					<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>2  <td>"?a &lt;http://www.w3.org/2002/07/owl#Class&gt;" 		<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>2  <td>"&lt;http://www.agentlab.ru/test/ontology#a&gt; ?b" 		<td>{@link AnnotationFormatException}		<td>
 * 		<tr><td>2  <td>"?a ?b" 					<td>{@link AnnotationFormatException}		<td>
 * 
 * 		<tr><td>8  <td rowspan="4">
 * 			{@link BeliefDataPropertyAdded @BeliefDataPropertyAdded}<br>
 * 			{@link BeliefDataPropertyRemoved @BeliefDataPropertyRemoved}<br>
 * 			{@link BeliefObjectPropertyAdded @BeliefObjectPropertyAdded}<br>
 * 			{@link BeliefObjectPropertyRemoved @BeliefObjectPropertyRemoved}<br>
 * 			{@link GoalDataPropertyAdded @GoalDataPropertyAdded}<br>
 * 			{@link GoalDataPropertyFailed @GoalDataPropertyFailed}<br>
 * 			{@link GoalDataPropertyFinished @GoalDataPropertyFinished}<br>
 * 			{@link GoalDataPropertyRemoved @GoalDataPropertyRemoved}<br>
 * 			{@link GoalObjectPropertyAdded @GoalObjectPropertyAdded}<br>
 * 			{@link GoalObjectPropertyFailed @GoalObjectPropertyFailed}<br>
 * 			{@link GoalObjectPropertyFinished @GoalObjectPropertyFinished}<br>
 * 			{@link GoalObjectPropertyRemoved @GoalObjectPropertyRemoved}<br>
 * 				   <td>"" 						<td>{@link AnnotationFormatException}	<td>
 * 		<tr><td>9  <td>"a" 					<td>{@link AnnotationFormatException}	<td>
 * 		<tr><td>10 <td>"a b" 				<td>{@link AnnotationFormatException}	<td>
 * 		<tr><td>11 <td>"a b c d" 			<td>Exception	<td>
 * 
 * 		<tr><td colspan="5">Positive tests
 * 		<tr><td>3  <td rowspan="6">
 * 			{@link BeliefClassificationAdded @BeliefClassificationAdded}<br>
 * 			{@link BeliefClassificationRemoved @BeliefClassificationRemoved}<br>
 * 				   <td>"a b" 					<td>{@link OWLClassAssertionAxiomMatcher}	<td>
 * 		<tr><td>4  <td>"?a b" 					<td>{@link OWLClassAssertionAxiomMatcher}	<td>
 * 		<tr><td>5  <td>"a ?b" 					<td>{@link OWLClassAssertionAxiomMatcher}	<td>
 * 		<tr><td>6  <td>"?a ?b" 					<td>{@link OWLClassAssertionAxiomMatcher}	<td>
 * 		<tr><td>7  <td>"?a &lt;http://www.w3.org/2002/07/owl#Class&gt;" 	<td>{@link OWLClassAssertionAxiomMatcher}	<td>
 * 		<tr><td>8  <td>"a &lt;http://www.w3.org/2002/07/owl#Class&gt;" 		<td>{@link OWLClassAssertionAxiomMatcher}	<td>
 * 
 * 		<tr><td>8  <td rowspan="8">
 * 			{@link BeliefDataPropertyAdded @BeliefDataPropertyAdded}<br>
 * 			{@link BeliefDataPropertyRemoved @BeliefDataPropertyRemoved}<br>
 * 			{@link BeliefObjectPropertyAdded @BeliefObjectPropertyAdded}<br>
 * 			{@link BeliefObjectPropertyRemoved @BeliefObjectPropertyRemoved}<br>
 * 			{@link GoalDataPropertyAdded @GoalDataPropertyAdded}<br>
 * 			{@link GoalDataPropertyFailed @GoalDataPropertyFailed}<br>
 * 			{@link GoalDataPropertyFinished @GoalDataPropertyFinished}<br>
 * 			{@link GoalDataPropertyRemoved @GoalDataPropertyRemoved}<br>
 * 			{@link GoalObjectPropertyAdded @GoalObjectPropertyAdded}<br>
 * 			{@link GoalObjectPropertyFailed @GoalObjectPropertyFailed}<br>
 * 			{@link GoalObjectPropertyFinished @GoalObjectPropertyFinished}<br>
 * 			{@link GoalObjectPropertyRemoved @GoalObjectPropertyRemoved}<br>
 * 				   <td>"" 						<td>{@link AnnotationFormatException}	<td>
 * 		<tr><td>9  <td>"one" 					<td>{@link AnnotationFormatException}	<td>
 * 		<tr><td>10 <td>"one two" 				<td>{@link AnnotationFormatException}	<td>
 * 		<tr><td>11 <td>"one two three" 			<td>Exception	<td>
 * 		<tr><td>12 <td>"?a two three" 			<td>Exception	<td>
 * 		<tr><td>13 <td>"?a ?b three" 			<td>Exception	<td>
 * 		<tr><td>14 <td>"?a ?b ?c" 				<td>Matcher	<td>
 * 		<tr><td>15 <td>"?a http...#type ?c" 	<td>Matcher	<td>
 * 
 * 		<tr><td>16  <td rowspan="4">
 * 			{@link PlanAdded @PlanAdded}<br>
 * 			{@link PlanFailed @PlanFailed}<br>
 * 			{@link PlanFinished @PlanFinished}<br>
 * 			{@link PlanRemoved @PlanRemoved}<br>
 * 				   <td>"" 						<td>Exception	<td>
 * 		<tr><td>17 <td>"::"						<td>Exception	<td>
 * 		<tr><td>18 <td>"::valid" 				<td>Exception	<td>
 * 		<tr><td>19 <td>"BeliefAddedDummy::"		<td>Exception	<td>
 * 
 * 		<tr><td>16  <td rowspan="10">
 * 			{@link AddedRole @RoleAdded}<br>
 * 			{@link ResolvedRole @RoleResolved}<br>
 * 			{@link ResolvedRole @RoleFinished}<br>
 * 			{@link UnresolvedRole @RoleUnresolved}<br>
 * 				   <td>byte.class 				<td>Exception	<td>
 * 		<tr><td>18 <td>short.class 				<td>Exception	<td>
 * 		<tr><td>19 <td>int.class 				<td>Exception	<td>
 * 		<tr><td>20 <td>long.class 				<td>Exception	<td>
 * 		<tr><td>21 <td>float.class 				<td>Exception	<td>
 * 		<tr><td>22 <td>double.class 			<td>Exception	<td>
 * 		<tr><td>23 <td>boolean.class		 	<td>Exception	<td>
 * 		<tr><td>24 <td>char.class 				<td>Exception	<td>
 * 		<tr><td>25 <td>Object.class		 		<td>Exception	<td>
 * 		<tr><td>26 <td>BeliefAddedDummy.class	<td>JavaClassMatcher	<td>
 * 
 * 	</tbody>
 * </table>
 * <!-- @formatter:on -->
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Theories.class)
public class ConverterToPlanTest {

	// static Map<Class<?>, Class<?>> annotation2event = new HashMap<>();
	// static {
	// annotation2event.put(BeliefClassificationAdded.class,
	// BeliefClassificationAddedEvent.class);
	// annotation2event.put(BeliefClassificationRemoved.class,
	// BeliefClassificationRemovedEvent.class);
	// annotation2event.put(GoalAdded.class, GoalAddedEvent.class);
	// annotation2event.put(GoalRemoved.class, GoalRemovedEvent.class);
	// annotation2event.put(GoalFailed.class, GoalFailedEvent.class);
	// annotation2event.put(GoalFinished.class, GoalFinishedEvent.class);
	// annotation2event.put(PlanAdded.class, PlanAddedEvent.class);
	// annotation2event.put(PlanRemoved.class, PlanRemovedEvent.class);
	// annotation2event.put(PlanFailed.class, PlanFailedEvent.class);
	// annotation2event.put(PlanFinished.class, PlanFinishedEvent.class);
	// annotation2event.put(RoleAdded.class, RoleAddedEvent.class);
	// annotation2event.put(RoleRemoved.class, RoleRemovedEvent.class);
	// annotation2event.put(RoleResolved.class, RoleResolvedEvent.class);
	// annotation2event.put(RoleUnresolved.class, RoleUnresolvedEvent.class);
	// }
	//
//	// @formatter:off
//	@DataPoints("belief annotations")
//	public static Class<?>[] beliefAnnotations() {
//		return new Class<?>[] { BeliefAdded.class, BeliefRemoved.class };
//	}
//
//	@DataPoints("goal annotations")
//	public static Class<?>[] goalAnnotations() {
//		return new Class<?>[] { GoalAdded.class, GoalRemoved.class, GoalFailed.class, GoalFinished.class };
//	}
//
//	@DataPoints("plan annotations")
//	public static Class<?>[] planAnnotations() {
//		return new Class<?>[] { PlanAdded.class, PlanRemoved.class, PlanFailed.class, PlanFinished.class };
//	}
//
//	@DataPoints("role annotations")
//	public static Class<?>[] roleAnnotations() {
//		return new Class<?>[] { RoleAdded.class, RoleRemoved.class, RoleResolved.class, RoleUnresolved.class };
//	}
//
//	@DataPoints("template parameters")
//	public static String[] templateParameters() {
//		return new String[] { "", "one", "one two", "one two three", "?a two three", "?a two three", "?a ?b three",
//				"?a ?b ?c", "?a <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?c" };
//	}
//
//	@DataPoints("method reference parameters")
//	public static String[] planParameters() {
//		return new String[] { "", "BeliefAddedDummy::valid", "BeliefAddedDummy::aaaa", "BeliefAddedDummy::",
//				"::valid" };
//	}
//
//	private static Map<String, IEventMatcher<?>> 
//
//	@DataPoints("class parameters")
//	public static Class<?>[] classParameters() {
//		return new Class<?>[] {
//			byte.class,
//			short.class,
//			int.class,
//			long.class,
//			float.class,
//			double.class,
//			boolean.class,
//			char.class,
//			Object.class,
//			BeliefAddedDummy.class
//		};
//	}
//	// @formatter:on
	//
	// @Theory
	// public void testBeliefAdded(@FromDataPoints("template parameters") String
	// parameter) {
	// System.out.println("@BeliefAdded(\"" + parameter + "\")");
	// BeliefAdded ann = Mockito.mock(BeliefAdded.class);
	// Mockito.when(ann.value()).thenReturn(parameter);
	// IEventMatcher<?> matcher = Converter.toMatcher(ann);
	// assertNotNull(matcher);
	// assertTrue(matcher instanceof BeliefBaseEventMatcher);
	// BeliefBaseEventMatcher typedMatcher = (BeliefBaseEventMatcher) matcher;
	// assertTrue(typedMatcher.getSubject());
	// }
	//
	// @Theory
	// public void testGoalAnnotations(@FromDataPoints("goal annotations")
	// Class<?> annotation,
	// @FromDataPoints("template parameters") String parameter) {
	// System.out.println(annotation + " " + parameter);
	// }
	//
	// @Theory
	// public void testPlanAnnotations(@FromDataPoints("plan annotations")
	// Class<?> annotation,
	// @FromDataPoints("method reference parameters") String parameter) {
	// System.out.println(annotation + " " + parameter);
	// }
	//
	// @Theory
	// public void testRoleAnnotations(@FromDataPoints("role annotations")
	// Class<?> annotation,
	// @FromDataPoints("class parameters") Class<?> parameter) {
	// System.out.println(annotation + " " + parameter);
	// }
	//
	// class Triple {
	//
	// }

}
