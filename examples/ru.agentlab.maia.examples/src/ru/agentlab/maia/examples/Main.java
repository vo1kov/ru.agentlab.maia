package ru.agentlab.maia.examples;

import java.util.concurrent.ForkJoinPool;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.OWLOntologyManager;

import ru.agentlab.maia.agent.IAgent;
import ru.agentlab.maia.agent.ResolveException;
import ru.agentlab.maia.container.ContainerException;
import ru.agentlab.maia.container.IContainer;
import ru.agentlab.maia.container.InjectorException;
import ru.agentlab.maia.container.impl.Container;

public class Main {

	public static void main(String[] args) throws InjectorException, ContainerException, ResolveException {
		IContainer container = new Container();
		container.put(ForkJoinPool.class, ForkJoinPool.commonPool());
		container.put(String.class, "TEST");
		container.put(OWLOntologyManager.class, OWLManager.createOWLOntologyManager());
		IAgent agent = new ru.agentlab.maia.agent.impl.Agent();
		agent.deployTo(container);
		agent.addRole(Example.class);
	}

}
