/** 
 * Copyright (c) 2009, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */
package org.maia.event.osgi.internal

import java.util.Dictionary
import java.util.HashMap
import java.util.Hashtable
import java.util.Map
import javax.annotation.PreDestroy
import org.maia.event.IEventBroker
import org.osgi.framework.ServiceRegistration
import org.osgi.service.event.Event
import org.osgi.service.event.EventConstants
import org.osgi.service.event.EventHandler

class OsgiEventAdminBroker implements IEventBroker {

	// $NON-NLS-1$
	// TBD synchronization
	Map<EventHandler, ServiceRegistration<?>> registrations = new HashMap<EventHandler, ServiceRegistration<?>>()

	// This is a temporary code to ensure that bundle containing
	// EventAdmin implementation is started. This code it to be removed once
	// the proper method to start EventAdmin is added.
//	static final Void static_initializer = {
//		{
//			var EventAdmin eventAdmin = MaiaActivator.getEventAdmin()
//			if (eventAdmin == null) {
//				var Bundle[] bundles = MaiaActivator.getContext().getBundles()
//				for (Bundle bundle : bundles) {
//					if (!"org.eclipse.equinox.event".equals(bundle.getSymbolicName())) /* FIXME Unsupported continue statement: */
//						try {
//							bundle.start(Bundle.START_TRANSIENT)
//						} catch (BundleException e) {
//							e.printStackTrace()
//						}
//				/* FIXME Unsupported BreakStatement: */
//				}
//
//			}
//
//		}
//		null
//	}
	new() {
		// placeholder
	}

	override boolean send(String topic, Object data) {
		var event = constructEvent(topic, data)
		var eventAdmin = MaiaActivator.getEventAdmin()
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
		var eventAdmin = MaiaActivator.getEventAdmin()
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

	override boolean subscribe(String topic, EventHandler eventHandler) {
		return subscribe(topic, null, eventHandler, false)
	}

	override boolean subscribe(String topic, String filter, EventHandler eventHandler, boolean headless) {
		var bundleContext = MaiaActivator.getContext()
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

	override boolean unsubscribe(EventHandler eventHandler) {
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

}