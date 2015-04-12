package ru.agentlab.maia.event.osgi

import java.util.Dictionary
import java.util.HashMap
import java.util.Hashtable
import java.util.Map
import javax.annotation.PreDestroy
import org.osgi.framework.ServiceRegistration
import org.osgi.service.event.Event
import org.osgi.service.event.EventConstants
import org.osgi.service.event.EventHandler
import ru.agentlab.maia.event.IEventBroker
import ru.agentlab.maia.event.IEventHandler
import ru.agentlab.maia.event.osgi.internal.Activator

class OsgiEventAdminBroker implements IEventBroker {

	Map<EventHandler, ServiceRegistration<?>> registrations = new HashMap<EventHandler, ServiceRegistration<?>>()

	override boolean send(String topic, Object data) {
		var event = constructEvent(topic, data)
		var eventAdmin = Activator.getEventAdmin()
		if (eventAdmin == null) {
			// logger.error(NLS.bind(ServiceMessages.NO_EVENT_ADMIN,
			// event.toString()))
			return false
		}
		eventAdmin.sendEvent(event)
		return true
	}

	override boolean post(String topic, Object data) {
		var event = constructEvent(topic, data)
		var eventAdmin = Activator.getEventAdmin()
		if (eventAdmin == null) {
			// logger.error(NLS.bind(ServiceMessages.NO_EVENT_ADMIN,
			// event.toString()))
			return false
		}
		eventAdmin.postEvent(event)
		return true
	}

	def private Event constructEvent(String topic, Object data) {
		return if (data instanceof Dictionary<?, ?>) {
			new Event(topic, data as Dictionary<String, ?>)
		} else if (data instanceof Map<?, ?>) {
			new Event(topic, data as Map<String, ?>)
		} else {
			var Dictionary<String, Object> d = new Hashtable<String, Object>(2)
			d.put(EventConstants.EVENT_TOPIC, topic)
			if(data != null) d.put(DATA, data)
			new Event(topic, d)
		}
	}

	def boolean subscribe(String topic, EventHandler eventHandler) {
		return subscribe(topic, null, eventHandler, false)
	}

	def boolean subscribe(String topic, String filter, EventHandler eventHandler, boolean headless) {
		var bundleContext = Activator.getContext()
		if (bundleContext == null) {
			// logger.error(NLS.bind(ServiceMessages.NO_BUNDLE_CONTEXT, topic))
			return false
		}
		var d = new Hashtable<String, Object>() => [
			put(EventConstants.EVENT_TOPIC, #[topic])
			if (filter != null) {
				put(EventConstants.EVENT_FILTER, filter)
			}
		]
		val registration = bundleContext.registerService(EventHandler, eventHandler, d)
		registrations.put(eventHandler, registration)
		return true
	}

	def boolean unsubscribe(EventHandler eventHandler) {
		val registration = registrations.remove(eventHandler) as ServiceRegistration<?>
		if (registration == null) {
			return false
		}
		registration.unregister()
		return true
	}

	@PreDestroy
	def package void dispose() {
		registrations.values.forEach[it.unregister]
		registrations.clear()
	}
	
	override subscribe(String topic, IEventHandler IEventHandler) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override subscribe(String topic, String filter, IEventHandler IEventHandler, boolean headless) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override unsubscribe(IEventHandler IEventHandler) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}