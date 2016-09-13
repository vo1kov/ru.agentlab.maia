package ru.agentlab.maia.admin.bundles;

import java.util.Queue;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.osgi.framework.BundleEvent;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLDataFactory;

import ru.agentlab.maia.admin.bundles.internal.Activator;
import ru.agentlab.maia.agent.annotation.OnEvent;
import ru.agentlab.maia.belief.IBeliefBase;

public class BundleStateSensor {

	@Inject
	IBeliefBase beliefBase;

	@Inject
	OWLDataFactory factory;

	@PostConstruct
	public void init(Queue<Object> eventQueue) {
		Activator.context.addBundleListener(eventQueue::offer);
	}

	@OnEvent(BundleEvent.class)
	public void onBundleChanged(BundleEvent event) {
		String object = "";
		switch (event.getType()) {
		case BundleEvent.INSTALLED:
			object = "osgi:INSTALLED";
		case BundleEvent.LAZY_ACTIVATION:
			object = "osgi:ACTIVE";
		case BundleEvent.RESOLVED:
			object = "osgi:RESOLVED";
		case BundleEvent.STARTED:
			object = "osgi:ACTIVE";
		case BundleEvent.STARTING:
			object = "osgi:STARTING";
		case BundleEvent.STOPPED:
			object = "osgi:RESOLVED";
		case BundleEvent.STOPPING:
			object = "osgi:STOPPING";
		case BundleEvent.UNINSTALLED:
			object = "osgi:UNINSTALLED";
		case BundleEvent.UNRESOLVED:
			object = "osgi:INSTALLED";
		case BundleEvent.UPDATED:
			return;
		}
		String subject = event.getBundle().getSymbolicName();
		OWLAxiom axiom = factory.getOWLObjectPropertyAssertionAxiom(
				factory.getOWLObjectProperty(IRI.create("osgi", "hasState")),
				factory.getOWLNamedIndividual(IRI.create(subject)), factory.getOWLNamedIndividual(IRI.create(object)));
		beliefBase.addBelief(axiom);

	}

}
