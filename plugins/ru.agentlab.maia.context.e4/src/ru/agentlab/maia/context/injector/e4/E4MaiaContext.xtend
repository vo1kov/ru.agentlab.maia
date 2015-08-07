package ru.agentlab.maia.context.injector.e4

import java.util.ArrayList
import java.util.Collection
import java.util.Set
import java.util.UUID
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext

class E4MaiaContext implements IMaiaContext {

	package IEclipseContext context

	@Accessors
	val String uuid

	@Inject
	new(IEclipseContext context) {
		this.context = context
		uuid = UUID.randomUUID.toString
	}

	override getParent() {
		return get(KEY_PARENT_CONTEXT) as IMaiaContext
	}

	override getChilds() {
		var result = getLocal(KEY_CHILD_CONTEXTS) as Collection<IMaiaContext>
		if (result == null) {
			result = new ArrayList<IMaiaContext>
			set(KEY_CHILD_CONTEXTS, result)
		}
		return result
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
		uuid
	}

	override Set<String> getKeySet() {
		return (context as EclipseContext).localData.keySet
	}

}