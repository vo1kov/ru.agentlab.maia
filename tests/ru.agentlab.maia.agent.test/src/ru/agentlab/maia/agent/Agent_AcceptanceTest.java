package ru.agentlab.maia.agent;

import java.util.concurrent.ForkJoinPool;
import java.util.stream.IntStream;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.vocab.Namespaces;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.agent.doubles.AnnTest;
import ru.agentlab.maia.container.Container;
import ru.agentlab.maia.event.AddedDataPropertyAssertionEvent;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ResolveException;

public class Agent_AcceptanceTest {

	private static OWLOntologyManager manager = OWLManager.createOWLOntologyManager();

	private static OWLDataFactory factory = manager.getOWLDataFactory();

	public static void main(String[] args)
			throws InjectorException, ContainerException, ResolveException, InterruptedException {
		IContainer container = new Container();
		ForkJoinPool fjp = new ForkJoinPool(4, ForkJoinPool.defaultForkJoinWorkerThreadFactory, null, false);
		container.put(ForkJoinPool.class, fjp);
		container.put(String.class, "TEST");
		Agent agent = new Agent();
		agent.deployTo(container);
		agent.addRole(AnnTest.class);
		IntStream.range(0, 500).forEach(i -> {
			agent.eventQueue.offer(new AddedDataPropertyAssertionEvent(factory.getOWLDataPropertyAssertionAxiom(
					factory.getOWLDataProperty(IRI.create(Namespaces.RDF.toString(), "hasProperty")),
					factory.getOWLNamedIndividual(IRI.create(Namespaces.RDF.toString(), "ind")),
					factory.getOWLLiteral(2))));
		});
		agent.start();
		Thread.sleep(500);
		System.out.println(agent.state);

	}

}
