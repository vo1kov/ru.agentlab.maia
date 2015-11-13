package ru.agentlab.maia.adapter

import ru.agentlab.maia.adapter.internal.Activator

abstract class Adapter<F, T> implements IAdapter<F, T> {

	/**
	 * <p>Retrieve registered {@code ITaskModifier} by language and target object type.</p>
	 * 
	 * @param language				language of registered modifier, e.g. json, xml, jade...
	 * @param type					type name of target object.
	 * @return 						object modifier for specified language and task type. 
	 */
	def protected IModifier<T> getModifier(String language, String type) {
		val refs = Activator.context.getServiceReferences(
			IModifier,
			'''(&(«IAdapter.KEY_LANGUAGE»=«language»)(«IModifier.KEY_TYPE»=«type»))'''
		)
		if (!refs.empty) {
			return Activator.context.getService(refs.get(0))
		} else {
			return null
		}
	}

}