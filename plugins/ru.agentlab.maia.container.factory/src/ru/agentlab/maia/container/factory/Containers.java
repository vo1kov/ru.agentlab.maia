package ru.agentlab.maia.container.factory;

import static java.util.concurrent.ForkJoinPool.defaultForkJoinWorkerThreadFactory;

import java.util.concurrent.Executors;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.ScheduledExecutorService;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLOntologyManager;

import io.netty.channel.nio.NioEventLoopGroup;
import ru.agentlab.maia.agent.IAgentRegistry;
import ru.agentlab.maia.container.IContainer;
import ru.agentlab.maia.container.impl.Container;
import ru.agentlab.maia.message.IMessageDeliveryService;
import ru.agentlab.maia.message.impl.AgentRegistry;
import ru.agentlab.maia.message.impl.HttpMessageDeliveryService;

public class Containers {

	private static final boolean ASYNC_MODE = true;

	public static IContainer createEmpty() {
		return new Container();
	}

	public static IContainer createDefault() {
		IContainer container = createEmpty();
		populateExecution(container);
		populateTiming(container);
		populateMessaging(container);
		return container;
	}

	public static IContainer createDefaultBDI() {
		IContainer container = createDefault();
		populateBDI(container);
		return container;
	}

	public static void populateExecution(IContainer container) {
		container.put(ForkJoinPool.class, new ForkJoinPool(Runtime.getRuntime().availableProcessors(),
				defaultForkJoinWorkerThreadFactory, null, ASYNC_MODE));
	}

	public static void populateTiming(IContainer container) {
		container.put(ScheduledExecutorService.class, Executors.newScheduledThreadPool(1));
	}

	public static void populateMessaging(IContainer container) {
		container.put("worker-group", new NioEventLoopGroup(3));
		container.put("boss-group", new NioEventLoopGroup(1));
		container.getInjector().deploy(AgentRegistry.class, IAgentRegistry.class);
		container.getInjector().deploy(HttpMessageDeliveryService.class, IMessageDeliveryService.class);
	}

	public static void populateBDI(IContainer container) {
		OWLOntologyManager manager = OWLManager.createConcurrentOWLOntologyManager();
		OWLDataFactory factory = manager.getOWLDataFactory();
		container.put(OWLOntologyManager.class, manager);
		container.put(OWLDataFactory.class, factory);
	}

}