package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.slf4j.LoggerFactory
import ru.agentlab.maia.naming.IMaiaContextNameFactory

class AgentExample {

	val static LOGGER = LoggerFactory.getLogger(AgentExample)

	@Inject @Named(IMaiaContextNameFactory.KEY_NAME)
	String agentName

//	@Inject
//	extension IBehaviourFactory

//	@Inject
//	IBehaviourSchemeRegistry behaviourSchemeRegistry

	@PostConstruct
	def void setup() {
		LOGGER.info("Setup of: [{}] agent", agentName)

//		val BehaviourSchemeOneShot oneShotScheme = behaviourSchemeRegistry.schemes.findFirst [
//			it instanceof BehaviourSchemeOneShot
//		] as BehaviourSchemeOneShot
//
//		createDefault(null) => [
//			val initService = get(IInitializerService)
//			initService.addInitializer(BehaviourExample)
//		]
		
		
		
		
//		createDefault("second") => [ beh |
//			val mapping = beh.get(IBehaviourTaskMappingFactory).create => [
//				val task = ContextInjectionFactory.make(DumpAgentNameTask, beh)
//				put(BehaviourSchemeOneShot.STATE_MAIN, task)
//			]
//			beh.modify(IBehaviourTaskMapping, mapping)
//		]
//		val port = Integer.parseInt(System.getProperty("port", "8899"))
//		if (port == 8888) {
//			createDefault("send") => [ beh |
//				beh.modify(IBehaviourScheme, oneShotScheme)
//				val mapping = beh.get(IBehaviourTaskMappingFactory).create => [
//					val task = ContextInjectionFactory.make(SendTestMessageTask, beh)
//					put(BehaviourSchemeOneShot.STATE_MAIN, task)
//				]
//				beh.modify(IBehaviourTaskMapping, mapping)
//			]
//		}
//		createFromAnnotation("first2", BehaviourExample) => [
//			get(IContributionService).addContributor(BehaviourExample)
//		]
//		behaviourFactory.createTicker(context, "second", 1000) => [
//			addContributor(BehaviourExample)
//		]
//		LOGGER.info("Agent ID: [{}] ", agentId.name)
	}

}