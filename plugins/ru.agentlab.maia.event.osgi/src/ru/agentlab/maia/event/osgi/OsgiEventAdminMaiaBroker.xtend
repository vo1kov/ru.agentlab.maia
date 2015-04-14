package ru.agentlab.maia.event.osgi

import java.util.HashMap
import java.util.Hashtable
import java.util.Map
import javax.annotation.PreDestroy
import org.osgi.framework.ServiceRegistration
import org.osgi.service.event.Event
import org.osgi.service.event.EventConstants
import org.osgi.service.event.EventHandler
import ru.agentlab.maia.event.IMaiaEvent
import ru.agentlab.maia.event.IMaiaEventBroker
import ru.agentlab.maia.event.IMaiaEventHandler
import ru.agentlab.maia.event.osgi.internal.Activator

class OsgiEventAdminMaiaBroker implements IMaiaEventBroker {

	Map<IMaiaEventHandler, ServiceRegistration<?>> registrations = new HashMap<IMaiaEventHandler, ServiceRegistration<?>>()

	override boolean send(IMaiaEvent e) {
		var event = new Event(e.topic, e.data)
		var eventAdmin = Activator.getEventAdmin()
		if (eventAdmin == null) {
			// logger.error(NLS.bind(ServiceMessages.NO_EVENT_ADMIN,
			// event.toString()))
			return false
		}
		eventAdmin.sendEvent(event)
		return true
	}

	override boolean post(IMaiaEvent e) {
		var event = new Event(e.topic, e.data)
		var eventAdmin = Activator.getEventAdmin()
		if (eventAdmin == null) {
			// logger.error(NLS.bind(ServiceMessages.NO_EVENT_ADMIN,
			// event.toString()))
			return false
		}
		eventAdmin.postEvent(event)
		return true
	}

	@PreDestroy
	def package void dispose() {
		registrations.values.forEach[it.unregister]
		registrations.clear()
	}

	override subscribe(String topic, IMaiaEventHandler handler) {
		var bundleContext = Activator.getContext()
		if (bundleContext == null) {
			return false
		}
		var d = new Hashtable<String, Object>() => [
			put(EventConstants.EVENT_TOPIC, #[topic])
		]
		if (handler instanceof OsgiEventHandler) {
			val osgiHandler = handler.handler
			val registration = bundleContext.registerService(EventHandler, osgiHandler, d)
			registrations.put(handler, registration)
		}
		return true
	}

	override unsubscribe(IMaiaEventHandler handler) {
		val registration = registrations.remove(handler) as ServiceRegistration<?>
		if (registration == null) {
			return false
		}
		registration.unregister()
		return true
	}

}