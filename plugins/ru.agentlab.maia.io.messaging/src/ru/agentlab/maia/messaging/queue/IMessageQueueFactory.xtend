package ru.agentlab.maia.messaging.queue

import ru.agentlab.maia.IMaiaContext

/**
 * Factory for creating <code>IMessageQueue</code> objects.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> 
 * 		- Initial contribution.
 */
interface IMessageQueueFactory {

	/**
	 * Create new <code>IMessageQueue</code> in context where this factory located.
	 * 
	 * @return New <code>IMessageQueue</code> object in context where this factory 
	 * located. Implementation depends on concrete factory.
	 */
	def IMessageQueue createMessageQueue(IMaiaContext ctx)

}
