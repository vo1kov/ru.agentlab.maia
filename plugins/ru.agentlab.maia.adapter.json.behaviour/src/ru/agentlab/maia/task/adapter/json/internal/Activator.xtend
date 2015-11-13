package ru.agentlab.maia.task.adapter.json.internal

import java.util.Hashtable
import org.eclipse.xtend.lib.annotations.Accessors
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.adapter.IAdapter
import ru.agentlab.maia.adapter.IModifier
import ru.agentlab.maia.adapter.json.JsonAdapter
import ru.agentlab.maia.adapter.json.behaviour.BehaviourJsonAdapter
import ru.agentlab.maia.adapter.json.behaviour.ParallelBehaviourJsonModifier
import ru.agentlab.maia.adapter.json.behaviour.SequentialBehaviourJsonModifier
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourRegistry

class Activator implements BundleActivator {

	@Accessors
	var static BundleContext context

	override start(BundleContext context) throws Exception {
		Activator.context = context

		context.registerBehaviourJsonAdapter
		context.registerSequentialBehaviourJsonModifier
		context.registerParallelBehaviourJsonModifier
	}
	
	def static IAdapter<String, IBehaviour> getAdapter(String language) {
		val refs = Activator.context.getServiceReferences(
			IAdapter,
			'''(«IAdapter.KEY_LANGUAGE»=«language»)'''
		)
		if (!refs.empty) {
			return Activator.context.getService(refs.get(0))
		} else {
			return null
		}
	}

	def void registerBehaviourJsonAdapter(BundleContext context) {
		val reference = context.getServiceReference(IBehaviourRegistry)
		if (reference != null) {
			val registry = context.getService(reference)
			if (registry != null) {
				val properties = new Hashtable<String, Object> => [
					put(IAdapter.KEY_LANGUAGE, JsonAdapter.LANGUAGE)
				]
				context.registerService(IAdapter, new BehaviourJsonAdapter(registry.map), properties)
			}
		}
	}

	def void registerSequentialBehaviourJsonModifier(BundleContext context) {
		val reference = context.getServiceReference(IBehaviourRegistry)
		if (reference != null) {
			val registry = context.getService(reference)
			if (registry != null) {
				val properties = new Hashtable<String, Object> => [
					put(IAdapter.KEY_LANGUAGE, JsonAdapter.LANGUAGE)
					put(IModifier.KEY_TYPE, "ru.agentlab.maia.behaviour.sequential.SequentialBehaviour")
				]
				context.registerService(IModifier, new SequentialBehaviourJsonModifier, properties)
			}
		}
	}

	def void registerParallelBehaviourJsonModifier(BundleContext context) {
		val reference = context.getServiceReference(IBehaviourRegistry)
		if (reference != null) {
			val registry = context.getService(reference)
			if (registry != null) {
				val properties = new Hashtable<String, Object> => [
					put(IAdapter.KEY_LANGUAGE, JsonAdapter.LANGUAGE)
					put(IModifier.KEY_TYPE, "ru.agentlab.maia.behaviour.parallel.ParallelBehaviour")
				]
				context.registerService(IModifier, new ParallelBehaviourJsonModifier, properties)
			}
		}
	}

	override stop(BundleContext context) throws Exception {
		Activator.context = null
	}

}