package ru.agentlab.maia.context.typing.container

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.IMaiaContextInjector

/**
 * Factory for creating Container contexts
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class MaiaContainerContextFactory implements IMaiaContainerContextFactory {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	MaiaContainerProfile profile

	override createContainer() {

		return contextFactory.createChild(context, "MAIA Context context") => [
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