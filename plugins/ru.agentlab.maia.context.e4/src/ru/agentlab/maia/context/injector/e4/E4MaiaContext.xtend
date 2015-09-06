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

@Accessors
class E4MaiaContext implements IMaiaContext {

	@Accessors(NONE)
	package IEclipseContext context

	val String uuid

	var volatile IMaiaContext parent

	val Collection<IMaiaContext> childs = new ArrayList

	@Inject
	new(IEclipseContext context) {
		this.context = context
		uuid = UUID.randomUUID.toString
	}

	override get(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		if (IEclipseContext.name.equalsIgnoreCase(name)) {
			return context
		}
		if (keySet.contains(name)) {
			return context.getLocal(name)
		} else {
			if (getParent != null) {
				return getParent.get(name)
			} else {
				return null
			}
		}
	}

	override <T> get(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		if (clazz == IEclipseContext) {
			return context as T
		}
		if (keySet.contains(clazz.name)) {
			return context.getLocal(clazz)
		} else {
			if (getParent != null) {
				return getParent.get(clazz)
			} else {
				return null
			}
		}
	}

	override getLocal(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		if (IEclipseContext.name.equalsIgnoreCase(name)) {
			return context
		}
		return context.getLocal(name)
	}

	override <T> getLocal(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		if (clazz == IEclipseContext) {
			return context as T
		}
		return context.getLocal(clazz)
	}

	override remove(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		context.remove(name)
	}

	override remove(Class<?> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		context.remove(clazz)
	}

	override set(String name, Object value) {
		if (name == null) {
			throw new NullPointerException
		}
		context.set(name, value)
	}

	override <T> set(Class<T> clazz, T value) {
		if (clazz == null) {
			throw new NullPointerException
		}
		context.set(clazz, value)
	}

	override toString() {
		uuid
	}

	override Set<String> getKeySet() {
		return (context as EclipseContext).localData.keySet
	}
	
	override addChild(IMaiaContext child) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override removeChild(IMaiaContext child) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}