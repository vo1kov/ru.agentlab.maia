package ru.agentlab.maia.e4

import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import org.eclipse.xtend2.lib.StringConcatenation
import ru.agentlab.maia.IMaiaContext

class E4MaiaContext implements IMaiaContext {

	package IEclipseContext context

	new(IEclipseContext context) {
		this.context = context
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
	}

	override remove(Class<?> clazz) {
		context.remove(clazz)
	}

	override set(String name, Object value) {
		context.set(name, value)
	}

	override <T> set(Class<T> clazz, T value) {
		context.set(clazz, value)
	}

	override toString() {
		context.toString()
	}

	override String dump() {
		var StringConcatenation result = ''''''
		result.newLine
		var current = this
		while (current != null) {
			result.append("[" + current + "] consist of:")
			result.newLine
			val list = (current.context as EclipseContext).localData.keySet.filter [
				it != "org.eclipse.e4.core.internal.contexts.ContextObjectSupplier" &&
				it != "ru.agentlab.maia.IMaiaContext" && 
				it != "debugString" &&
				it != "parentContext"
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