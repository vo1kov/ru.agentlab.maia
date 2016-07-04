package ru.agentlab.maia.agent;

import java.util.concurrent.ForkJoinPool;
import java.util.stream.IntStream;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.inject.Named;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.vocab.Namespaces;

import de.derivo.sparqldlapi.QueryResult;
import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.annotation.event.AddedDataPropertyAssertion;
import ru.agentlab.maia.annotation.state.HaveClassAssertion;
import ru.agentlab.maia.annotation.state.HaveSubClassOf;
import ru.agentlab.maia.container.Container;
import ru.agentlab.maia.event.AddedBeliefEvent;
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
		agent.addRole(TestRole.class);
		IntStream.range(0, 500).forEach(i -> {
			agent.eventQueue.offer(new AddedBeliefEvent(factory.getOWLDataPropertyAssertionAxiom(
					factory.getOWLDataProperty(IRI.create(Namespaces.RDF.toString(), "hasProperty")),
					factory.getOWLNamedIndividual(IRI.create(Namespaces.RDF.toString(), "ind")),
					factory.getOWLLiteral(2))));
		});
		agent.start();
		Thread.sleep(500);
		System.out.println(agent.state);

	}

	public static class TestRole {

		@Inject
		IAgent agent;

		@PostConstruct
		public void init() {
			System.out.println(agent.getUuid());
		}

		@AddedDataPropertyAssertion("rdf:ind rdf:hasProperty 2^^xsd:integer")
		@HaveSubClassOf("owl:Thing rdf:Some")
		@HaveClassAssertion("rdf:Some rdf:ind")
		public void exe() {
			System.out.println("WORKS");

		}

		@AddedDataPropertyAssertion("?ind ?property 2^^xsd:integer")
		@HaveSubClassOf("owl:Thing rdf:Some")
		@HaveClassAssertion("rdf:Some rdf:ind")
		public void exe2(@Named("property") OWLDataProperty property, @Named("ind") OWLIndividual ind,
				QueryResult res) {
			System.out.println("WORKS2" + property.toString());
			System.out.println("WORKS2" + ind.toString());

		}

	}
}
