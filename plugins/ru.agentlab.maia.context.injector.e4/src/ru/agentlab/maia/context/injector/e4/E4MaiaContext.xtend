package ru.agentlab.maia.context.injector.e4

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import org.eclipse.xtend2.lib.StringConcatenation
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.event.IMaiaEventBroker

class E4MaiaContext implements IMaiaContext {

	var IMaiaEventBroker broker

	package IEclipseContext context

	@Inject
	new(IEclipseContext context, IMaiaEventBroker broker) {
		this.context = context
		this.broker = broker
	}

	override getParent() {
		return context.parent?.get(IMaiaContext)
	}

	override get(String name) {
		if (IEclipseContext.name.equalsIgnoreCase(name)) {
			return context
		}
		return context.get(name)
	}

	override <T> get(Class<T> clazz) {
		if (clazz == IEclipseContext) {
			return context as T
		}
		return context.get(clazz)
	}

	override getLocal(String name) {
		if (IEclipseContext.name.equalsIgnoreCase(name)) {
			return context
		}
		return context.getLocal(name)
	}

	override <T> getLocal(Class<T> clazz) {
		if (clazz == IEclipseContext) {
			return context as T
		}
		return context.getLocal(clazz)
	}

	override remove(String name) {
		context.remove(name)
		broker.post(TOPIC_REMOVE, name)
	}

	override remove(Class<?> clazz) {
		context.remove(clazz)
		broker.post(TOPIC_REMOVE, clazz.name)
	}

	override set(String name, Object value) {
		val old = context.getLocal(name)
		context.set(name, value)
		val eventProperty = new HashMap<String, Object> => [
			put("old", old)
			put("new", value)
		]
		broker.post(TOPIC_SET, eventProperty)
	}

	override <T> set(Class<T> clazz, T value) {
		val old = context.getLocal(clazz)
		context.set(clazz, value)
		val eventProperty = new HashMap<String, Object> => [
			put("old", old)
			put("new", value)
		]
		broker.post(TOPIC_SET, eventProperty)
	}

	override toString() {
		context.toString()
	}

	override String dump() {
		var StringConcatenation result = ''''''
		result.newLine
		var current = this
		while (current != null) {
			result.append("[" + current + "] contains:")
			result.newLine
			val list = (current.context as EclipseContext).localData.keySet.filter [
				it != "org.eclipse.e4.core.internal.contexts.ContextObjectSupplier" &&
					it != "ru.agentlab.maia.context.IMaiaContext" && it != "debugString" && it != "parentContext"
			].sortWith [ a, b |
				a.compareTo(b)
			]
			for (p1 : list) {
				result.append("	[" + p1 + "] -> [" + (current.context as EclipseContext).localData.get(p1) + "]")
				result.newLine
			}
			current = current.parent  as E4MaiaContext
		}
		return result.toString
	}

}