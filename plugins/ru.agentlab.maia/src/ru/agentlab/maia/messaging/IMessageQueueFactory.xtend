package ru.agentlab.maia.messaging

import org.eclipse.e4.core.contexts.IEclipseContext

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
	def IMessageQueue createMessageQueue()

	/**
	 * Create new IMessageQueue in specified context.
	 * 
	 * @param context - context where <code>IMessageQueue</code> will be created
	 * @return New <code>IMessageQueue</code> object in specified context. 
	 * Implementation depends on concrete factory.
	 */
	def IMessageQueue createMessageQueue(IEclipseContext context)

}
