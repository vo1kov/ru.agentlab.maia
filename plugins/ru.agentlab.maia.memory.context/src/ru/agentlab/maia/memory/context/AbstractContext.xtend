package ru.agentlab.maia.memory.context

import java.util.Collection
import java.util.Collections
import java.util.HashSet
import java.util.Set
import java.util.UUID
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.memory.IMaiaContext
import javax.inject.Provider

/**
 * <p>
 * Abstract {@link IMaiaContext} implementation.
 * </p>
 * <p>Implementation guarantee that:
 * </p>
 * <ul>
 * <li>Context can be in hierarchy (have parent and childs);</li>
 * <li>Context will have unique UUID;</li>
 * <li>Context redirect service searching to parent if can't find it;</li>
 * <li>Context disable <code>null</code> keys for storing services;</li>
 * </ul>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
abstract class AbstractContext implements IMaiaContext {

	@Accessors
	val String uuid = UUID.randomUUID.toString

	@Accessors
	var volatile IMaiaContext parent

	@Accessors
	val Collection<IMaiaContext> childs = Collections.synchronizedSet(new HashSet)

	/**
	 * <p>
	 * Abstract implementation for {@link IMaiaContext#contains(Class) 
	 * IMaiaContext.contains(Class)}.
	 * </p><p>
	 * Implementation try to find clazz in own context and if context have
	 * no value than try to find in parent
	 * </p>
	 */
	override contains(Class<?> clazz) {
		val inLocal = isContainsLocal(clazz)
		if (inLocal) {
			return this
		} else {
			if (parent != null) {
				return parent.contains(clazz)
			} else {
				return null
			}
		}
	}

	override contains(String name) {
		val inLocal = isContainsLocal(name)
		if (inLocal) {
			return this
		} else {
			if (parent != null) {
				return parent.contains(name)
			} else {
				return null
			}
		}
	}

	override get(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		if (keySet.contains(name)) {
			return doGetLocal(name)
		} else {
			if (parent != null) {
				return parent.get(name)
			} else {
				return null
			}
		}
	}

	override <T> get(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		if (keySet.contains(clazz.name)) {
			return doGetLocal(clazz)
		} else {
			if (parent != null) {
				return parent.get(clazz)
			} else {
				return null
			}
		}
	}

	override getLocal(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		return doGetLocal(name)
	}

	override <T> getLocal(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		return doGetLocal(clazz)
	}

	override remove(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		doRemoveLocal(name)
	}

	override <T> remove(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		doRemoveLocal(clazz)
	}

	override <T> set(String name, T value) {
		if (name == null) {
			throw new NullPointerException
		}
		try {
			val clazz = Class.forName(name) as Class<T>
			doSetLocal(clazz, value)
		} catch (ClassNotFoundException e) {
			doSetLocal(name, value)
		} catch (ClassCastException e) {
			doSetLocal(name, value)
		}
	}

	override <T> set(Class<T> clazz, T value) {
		if (clazz == null) {
			throw new NullPointerException
		}
		doSetLocal(clazz, value)
	}
	
	override <T> set(String name, Provider<T> provider) {
		if (name == null) {
			throw new NullPointerException
		}
		doSetLocal(name, provider)
	}
	
	override <T> set(Class<T> clazz, Provider<T> provider) {
		if (clazz == null) {
			throw new NullPointerException
		}
		doSetLocal(clazz, provider)
	}

	override toString() {
		uuid
	}

	override Set<String> getKeySet() {
		return doGetKeySet
	}

	override addChild(IMaiaContext child) {
		childs += child
	}

	override removeChild(IMaiaContext child) {
		childs -= child
	}

	override void setParent(IMaiaContext newParent) {
		parent?.removeChild(this)
		parent = newParent
		parent.addChild(this)
	}

	def protected boolean isContainsLocal(String name)

	def protected boolean isContainsLocal(Class<?> clazz)

	def protected <T> T doGetLocal(String name)

	def protected <T> T doGetLocal(Class<T> clazz)

	def protected <T> void doSetLocal(String name, T value)

	def protected <T> void doSetLocal(Class<T> clazz, T value)
	
	def protected <T> void doSetLocal(String name, Provider<T> provider)
	
	def protected <T> void doSetLocal(Class<T> clazz, Provider<T> provider)

	def protected <T> T doRemoveLocal(String name)

	def protected <T> T doRemoveLocal(Class<T> clazz)

	def protected Set<String> doGetKeySet()

}