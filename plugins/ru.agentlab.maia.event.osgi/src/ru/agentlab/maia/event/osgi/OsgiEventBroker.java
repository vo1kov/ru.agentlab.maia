package ru.agentlab.maia.event.osgi;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.annotation.PreDestroy;

import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;
import org.osgi.service.event.EventAdmin;
import org.osgi.service.event.EventConstants;
import org.osgi.service.event.EventHandler;

import ru.agentlab.maia.event.IMaiaEvent;
import ru.agentlab.maia.event.IMaiaEventBroker;
import ru.agentlab.maia.event.IMaiaEventHandler;
import ru.agentlab.maia.event.osgi.internal.Activator;

public class OsgiEventBroker implements IMaiaEventBroker {

	private Map<IMaiaEventHandler, ServiceRegistration<?>> registrations = new HashMap<IMaiaEventHandler, ServiceRegistration<?>>();

	@Override
	public boolean send(final IMaiaEvent e) {
		OsgiEvent event = new OsgiEvent(e);
		EventAdmin eventAdmin = Activator.getEventAdmin();
		if (eventAdmin == null) {
			return false;
		}
		eventAdmin.sendEvent(event);
		return true;
	}

	@Override
	public boolean post(final IMaiaEvent e) {
		OsgiEvent event = new OsgiEvent(e);
		EventAdmin eventAdmin = Activator.getEventAdmin();
		if (eventAdmin == null) {
			return false;
		}
		eventAdmin.postEvent(event);
		return true;
	}

	@PreDestroy
	void dispose() {
		registrations.values().forEach(ServiceRegistration::unregister);
		registrations.clear();
	}

	@Override
	public boolean subscribe(final String topic, final IMaiaEventHandler handler) {
		BundleContext bundleContext = Activator.getContext();
		if (bundleContext == null) {
			return false;
		}
		Hashtable<String, Object> _hashtable = new Hashtable<String, Object>();
		_hashtable.put(EventConstants.EVENT_TOPIC, new String[] { topic });
		OsgiEventHandler _osgiEventHandler = new OsgiEventHandler(handler);
		final ServiceRegistration<EventHandler> registration = bundleContext
			.<EventHandler>registerService(EventHandler.class, _osgiEventHandler, _hashtable);
		this.registrations.put(handler, registration);
		return true;
	}

	@Override
	public boolean unsubscribe(final IMaiaEventHandler handler) {
		final ServiceRegistration<?> registration = this.registrations.remove(handler);
		if (registration == null) {
			return false;
		} else {
			registration.unregister();
			return true;
		}
	}
}
