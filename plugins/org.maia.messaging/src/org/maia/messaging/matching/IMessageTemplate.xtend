package org.maia.messaging.matching

import org.maia.messaging.IMessage

interface IMessageTemplate {

	def boolean match(IMessage message)

}