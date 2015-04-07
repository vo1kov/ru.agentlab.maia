package org.maia.messaging

import org.eclipse.e4.core.contexts.IEclipseContext

interface IMessageDeliveryServiceFactory {

	def IMessageDeliveryService create(IEclipseContext context)

}