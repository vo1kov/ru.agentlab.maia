package ru.agentlab.maia.service.event.osgi.internal;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.osgi.service.event.EventAdmin;

import ru.agentlab.maia.service.event.IMaiaEventBroker;
import ru.agentlab.maia.service.event.osgi.OsgiEventBroker;

public class Activator implements BundleActivator {

	private static BundleContext context;

	public static BundleContext getContext() {
		return Activator.context;
	}

	@Override
	public void start(final BundleContext context) throws Exception {
		Activator.context = context;
		OsgiEventBroker _osgiEventBroker = new OsgiEventBroker();
		context.registerService(IMaiaEventBroker.class, _osgiEventBroker, null);
	}

	@Override
	public void stop(final BundleContext context) throws Exception {
		final ServiceReference<?> ref = context.getServiceReference(IMaiaEventBroker.class);
		if (ref != null) {
			context.ungetService(ref);
		}
		Activator.context = null;
	}

	public static EventAdmin getEventAdmin() {
		final ServiceReference<EventAdmin> ref = Activator.context.<EventAdmin>getServiceReference(EventAdmin.class);
		if (ref != null) {
			return Activator.context.<EventAdmin>getService(ref);
		}
		return null;
	}
}
