package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.launcher.task.ContextDumpTask
import ru.agentlab.maia.launcher.task.IncrementTask

class BehaviourExample {

	val static LOGGER = LoggerFactory.getLogger(BehaviourExample)

	@Inject
	IEclipseContext context

	@Inject
	IBehaviourTaskMappingFactory behaviourTaskMappingFactory

	@PostConstruct
	def void init() {
		LOGGER.info("Modify action scheme...")
		context.modify(IBehaviourScheme, new CustomScheme)

		LOGGER.info("Modify task mapping...")
		val task1 = ContextInjectionFactory.make(IncrementTask, context)
		val task2 = ContextInjectionFactory.make(IncrementTask, context)
		val task3 = ContextInjectionFactory.make(ContextDumpTask, context)
		val mapping = behaviourTaskMappingFactory.create => [
			put(CustomScheme.STATE_MAIN, task1)
			put(CustomScheme.STATE_MAIN2, task2)
			put(CustomScheme.STATE_MAIN3, task3)
		]
		context.modify(IBehaviourTaskMapping, mapping)

		LOGGER.info("Modify property mapping...")
		val propertyMapping = ContextInjectionFactory.make(BehaviourPropertyMapping, context) => [
			link(task1, "i2", task2, "i")
			put(task1, "i", 20)
		]
		context.set(IBehaviourPropertyMapping, propertyMapping)
	}

}

/**
 * 
 * INITIAL =====> STATE_MAIN --e--> STATE_MAIN2 =====> FINISH 
 * 
 */
class CustomScheme extends BehaviourScheme {

	val public static STATE_MAIN = new BehaviourStateImplement("MAIN")

	val public static STATE_MAIN2 = new BehaviourStateImplement("MAIN2")

	val public static STATE_MAIN3 = new BehaviourStateImplement("MAIN3")

	val public static TRANSITION_START = new BehaviourTransitionDefault("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_EVENT = new BehaviourTransitionEvent("START2", STATE_MAIN, STATE_MAIN2)

	val public static TRANSITION_EVENT2 = new BehaviourTransitionEvent("START2", STATE_MAIN2, STATE_MAIN3)

	val public static TRANSITION_FINISH = new BehaviourTransitionDefault("FINISH", STATE_MAIN3, STATE_FINAL)

	override protected void init() {
		super.init
		states += STATE_MAIN
		states += STATE_MAIN2
		states += STATE_MAIN3

		transitions += TRANSITION_START
		transitions += TRANSITION_EVENT
		transitions += TRANSITION_EVENT2
		transitions += TRANSITION_FINISH
	}

}