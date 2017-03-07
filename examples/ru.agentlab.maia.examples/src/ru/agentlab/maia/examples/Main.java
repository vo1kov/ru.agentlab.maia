package ru.agentlab.maia.examples;

import java.util.concurrent.ForkJoinPool;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.OWLOntologyManager;

import ru.agentlab.maia.ContainerException;
import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.InjectorException;
import ru.agentlab.maia.ResolveException;
import ru.agentlab.maia.container.Container;

public class Main {

	public static void main(String[] args) throws InjectorException, ContainerException, ResolveException {
		IContainer container = new Container();
		container.put(ForkJoinPool.class, ForkJoinPool.commonPool());
		container.put(String.class, "TEST");
		container.put(OWLOntologyManager.class, OWLManager.createOWLOntologyManager());
		IAgent agent = new ru.agentlab.maia.agent.Agent();
		agent.deployTo(container);
		agent.addRole(Example.class);
	}

}
