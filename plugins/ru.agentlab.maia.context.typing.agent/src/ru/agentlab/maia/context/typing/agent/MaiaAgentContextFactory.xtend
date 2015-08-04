package ru.agentlab.maia.context.typing.agent

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.IMaiaContextInjector

/**
 * Factory for creating Agent contexts
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class MaiaAgentContextFactory implements IMaiaAgentContextFactory {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	IMaiaContextInjector injector

	@Inject
	MaiaAgentProfile profile

	override createAgent() {

		return contextFactory.createChild(context, "MAIA Agent context") => [
			set(IMaiaContext.KEY_TYPE, TYPE)
			profile.implementationKeySet.forEach [ serviceInterface |
				val serviceClass = profile.getImplementation(serviceInterface)
				if (serviceClass != null) {
					val serviceObj = injector.make(serviceClass, it)
					injector.invoke(serviceObj, PostConstruct, it, null)
					set(serviceInterface.name, serviceObj)
				}
			]
		]
	}

}