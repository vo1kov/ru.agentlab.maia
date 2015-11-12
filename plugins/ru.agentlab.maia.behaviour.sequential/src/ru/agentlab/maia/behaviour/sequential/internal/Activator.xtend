package ru.agentlab.maia.behaviour.sequential.internal

import java.util.Hashtable
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.behaviour.IBehaviourModifier
import ru.agentlab.maia.behaviour.BehaviourOrdered
import ru.agentlab.maia.behaviour.sequential.SequentialBehaviourModifier

class Activator implements BundleActivator {

	override start(BundleContext context) throws Exception {
		val properties = new Hashtable<String, Object> => [
			put(IBehaviourModifier.KEY_TYPE, BehaviourOrdered)
		]
		context.registerService(IBehaviourModifier, new SequentialBehaviourModifier, properties)

	}

	override stop(BundleContext context) throws Exception {
	}

}