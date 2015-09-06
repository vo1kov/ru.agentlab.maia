package ru.agentlab.maia.memory.context

import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextFactory

/**
 * <p>Abstract {@link IMaiaContextFactory} implementation.</p>
 * 
 * <p>Implementation guarantee that:</p>
 * <ul>
 * <li>Context will register in context as child;</li>
 * <li>Context will register parent;</li>
 * </ul>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
abstract class AbstractContextFactory implements IMaiaContextFactory {

	IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	override createContext() {
		val newContext = doCreateContext
		context.childs += newContext
		newContext.parent = context
		return newContext
	}

	def IMaiaContext doCreateContext()

}