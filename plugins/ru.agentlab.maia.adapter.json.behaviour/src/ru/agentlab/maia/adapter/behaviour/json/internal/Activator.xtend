package ru.agentlab.maia.adapter.behaviour.json.internal

import java.util.Hashtable
import org.eclipse.xtend.lib.annotations.Accessors
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.adapter.IAdapter
import ru.agentlab.maia.adapter.IModifier
import ru.agentlab.maia.adapter.behaviour.json.BehaviourJsonAdapter
import ru.agentlab.maia.adapter.behaviour.json.BehaviourSchedulerJsonModifier
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourRegistry

class Activator implements BundleActivator {

	@Accessors
	var static BundleContext context

	override start(BundleContext context) throws Exception {
		Activator.context = context

		context.registerBehaviourBehaviourJsonAdapter
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

	def void registerBehaviourBehaviourJsonAdapter(BundleContext context) {
		val reference = context.getServiceReference(IBehaviourRegistry)
		if (reference != null) {
			val registry = context.getService(reference)
			if (registry != null) {
				val properties = new Hashtable<String, Object> => [
					put(IAdapter.KEY_LANGUAGE, BehaviourJsonAdapter.LANGUAGE)
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
					put(IAdapter.KEY_LANGUAGE, BehaviourJsonAdapter.LANGUAGE)
					put(IModifier.KEY_TYPE, "ru.agentlab.maia.behaviour.sequential.SequentialBehaviour")
				]
				context.registerService(IModifier, new BehaviourSchedulerJsonModifier, properties)
			}
		}
	}

	def void registerParallelBehaviourJsonModifier(BundleContext context) {
		val reference = context.getServiceReference(IBehaviourRegistry)
		if (reference != null) {
			val registry = context.getService(reference)
			if (registry != null) {
				val properties = new Hashtable<String, Object> => [
					put(IAdapter.KEY_LANGUAGE, BehaviourJsonAdapter.LANGUAGE)
					put(IModifier.KEY_TYPE, "ru.agentlab.maia.behaviour.parallel.ParallelBehaviour")
				]
				context.registerService(IModifier, new BehaviourSchedulerJsonModifier, properties)
			}
		}
	}

	override stop(BundleContext context) throws Exception {
		Activator.context = null
	}

}