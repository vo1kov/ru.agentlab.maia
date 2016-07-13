package ru.agentlab.maia.container.simple;

import static java.util.concurrent.ForkJoinPool.defaultForkJoinWorkerThreadFactory;

import java.util.concurrent.Executors;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.ScheduledExecutorService;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLOntologyManager;

import io.netty.channel.nio.NioEventLoopGroup;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.container.Container;

public class SimpleContainerFactory {

	private static SimpleContainerFactory instance = new SimpleContainerFactory();

	private SimpleContainerFactory() {
		super();
	}

	public static SimpleContainerFactory getInstance() {
		return instance;
	}

	public IContainer get() {
		IContainer container = new Container();
		OWLOntologyManager manager = OWLManager.createConcurrentOWLOntologyManager();
		OWLDataFactory factory = manager.getOWLDataFactory();
		container.put(ForkJoinPool.class, new ForkJoinPool(4, defaultForkJoinWorkerThreadFactory, null, true));
		container.put(OWLOntologyManager.class, manager);
		container.put(OWLDataFactory.class, factory);
		container.put(ScheduledExecutorService.class, Executors.newScheduledThreadPool(1));
		container.put("worker-group", new NioEventLoopGroup(3));
		container.put("boss-group", new NioEventLoopGroup(1));
		return container;
	}

}
