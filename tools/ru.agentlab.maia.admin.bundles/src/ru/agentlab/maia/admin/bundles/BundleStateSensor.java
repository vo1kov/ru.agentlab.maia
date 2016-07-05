package ru.agentlab.maia.admin.bundles;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.osgi.framework.BundleEvent;

import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IEventQueue;
import ru.agentlab.maia.admin.bundles.internal.Activator;
import ru.agentlab.maia.role.AddedExternalEvent;

public class BundleStateSensor {

	@Inject
	IBeliefBase beliefBase;

	@PostConstruct
	public void init(IEventQueue eventQueue) {
		Activator.context.addBundleListener(eventQueue::offer);
	}

	@AddedExternalEvent(BundleEvent.class)
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
		beliefBase.addObjectPropertyAssertion(subject, "osgi:hasState", object);

	}

}
