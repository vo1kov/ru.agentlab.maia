package ru.agentlab.maia.agent;

import java.util.concurrent.ForkJoinPool;
import java.util.stream.IntStream;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.vocab.Namespaces;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.Option;
import ru.agentlab.maia.agent.doubles.AnnTest;
import ru.agentlab.maia.container.Container;
import ru.agentlab.maia.event.Event;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ResolveException;

public class Agent_AcceptanceTest {

	private static OWLOntologyManager manager = OWLManager.createOWLOntologyManager();

	private static OWLDataFactory factory = manager.getOWLDataFactory();

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static void main(String[] args)
			throws InjectorException, ContainerException, ResolveException, InterruptedException {
		IContainer container = new Container();
		container.put(ForkJoinPool.class, ForkJoinPool.commonPool());
		container.put(String.class, "TEST");
		Agent agent = new Agent();
		agent.deployTo(container);
		agent.addRole(AnnTest.class);
		agent.eventQueue.offer(new Event(factory.getOWLDataPropertyAssertionAxiom(
				factory.getOWLDataProperty(IRI.create(Namespaces.RDF.toString(), "hasProperty")),
				factory.getOWLNamedIndividual(IRI.create(Namespaces.RDF.toString(), "ind")),
				factory.getOWLLiteral(2))) {

			@Override
			public EventType getType() {
				return EventType.ADDED_DATA_PROPERTY_ASSERTION;
			}

		});
		agent.start();
		Thread.sleep(2000);
		System.out.println(agent.state);

		// IntStream.range(0, 3).forEach(i -> {
		// IEvent<?> event = agent.eventQueue.poll();
		// Iterable<Option> options = agent.planBase.getOptions(event);
		// options.forEach(option -> {
		// try {
		// option.getPlanBody().execute(agent.getInjector(),
		// option.getValues());
		// // eventQueue.offer(new PlanFinishedEvent(planBody));
		// } catch (Exception e) {
		// // eventQueue.offer(new PlanFailedEvent(planBody));
		// }
		// });
		// });
	}

}
