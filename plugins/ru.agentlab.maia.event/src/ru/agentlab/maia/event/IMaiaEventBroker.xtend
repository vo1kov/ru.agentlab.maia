/** 
 * Copyright (c) 2009, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */
package ru.agentlab.maia.event

import java.util.Dictionary
import java.util.Map

/** 
 * To obtain an instance of the event broker service from the @link {@link IEclipseContext} context,
 * use
 * <pre>
 * (IEventBroker) context.get(IEventBroker.class.getName())
 * </pre>
 * @noimplement This interface is not intended to be implemented by clients.
 */
interface IMaiaEventBroker {
	/** 
	 * The name of the default event attribute used to pass data.
	 */
	public String DATA = "org.eclipse.e4.data"

	// $NON-NLS-1$
	/** 
	 * Publish event synchronously (the method does not return until the event is processed).
	 * <p>
	 * If data is a {@link Map} or a {@link Dictionary}, it is passed as is. Otherwise, a new Map is
	 * constructed and its {@link #DATA} attribute is populated with this value.
	 * </p>
	 * @param topictopic of the event to be published
	 * @param datadata to be published with the event
	 * @return <code>true</code> if this operation was performed successfully; <code>false</code>
	 * otherwise
	 */
	def boolean send(String topic, Object data)

	/** 
	 * Publish event asynchronously (this method returns immediately).
	 * <p>
	 * If data is a {@link Map} or a {@link Dictionary}, it is passed as is. Otherwise, a new Map is
	 * constructed and its {@link #DATA} attribute is populated with this value.
	 * </p>
	 * @param topictopic of the event to be published
	 * @param datadata to be published with the event
	 * @return <code>true</code> if this operation was performed successfully; <code>false</code>
	 * otherwise
	 */
	def boolean post(String topic, Object data)

	/** 
	 * Subscribe for events on the given topic.
	 * <p>
	 * The handler will be called on the UI thread.
	 * </p>
	 * @param topictopic of interest
	 * @param IEventHandlerobject to call when an event of interest arrives
	 * @return <code>true</code> if this operation was performed successfully; <code>false</code>
	 * otherwise
	 */
	def boolean subscribe(String topic, IMaiaEventHandler handler)

	/** 
	 * Subscribe for events on the given topic.
	 * <p>
	 * The handler will be called on the UI thread if "headless" is set to <code>true</code>.
	 * </p>
	 * @param topictopic of interest
	 * @param filterthe LDAP event filter
	 * @param IEventHandlerobject to call when an event of interest arrives
	 * @param headless<code>true</code> if handing of the events does not require UI; <code>false</code>
	 * otherwise
	 * @return <code>true</code> if this operation was performed successfully; <code>false</code>
	 * otherwise
	 */
	def boolean subscribe(String topic, String filter, IMaiaEventHandler handler, boolean headless)

	/** 
	 * Unsubscribe handler previously registered using {@link #subscribe(String, IEventHandler)}.
	 * @param IEventHandlerpreviously registered event handler
	 * @return <code>true</code> if this operation was performed successfully; <code>false</code>
	 * otherwise
	 */
	def boolean unsubscribe(IMaiaEventHandler handler)

}
