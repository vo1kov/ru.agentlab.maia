package ru.agentlab.maia.examples;

import java.util.concurrent.ForkJoinPool;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLOntologyManager;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IAgentRegistry;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.container.Container;
import ru.agentlab.maia.service.message.impl.AgentRegistry;

public class MyActivator
    implements BundleActivator {

    @Override
    public void start(BundleContext context) throws Exception {
        IContainer container = new Container();
        container.put(ForkJoinPool.class, ForkJoinPool.commonPool());
        container.put(String.class, "TEST");
        container.put(IAgentRegistry.class, new AgentRegistry());

        OWLOntologyManager owlOntologyManager = OWLManager.createOWLOntologyManager();
        container.put(OWLOntologyManager.class, owlOntologyManager);

        container.put(OWLDataFactory.class, owlOntologyManager.getOWLDataFactory());


        IAgent agent = new ru.agentlab.maia.agent.Agent();
        agent.deployTo(container);
        agent.addRole(Example.class);

    }

    @Override
    public void stop(BundleContext context) throws Exception {

    }

}
