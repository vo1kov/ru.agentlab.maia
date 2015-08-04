package ru.agentlab.maia.context.typing.behaviour

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.IMaiaContextInjector

class MaiaBehaviourContextFactory implements IMaiaBehaviourContextFactory {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	MaiaBehaviourProfile profile

	override createBehaviour() {
		return contextFactory.createChild(context, "MAIA Behaviour context") => [
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