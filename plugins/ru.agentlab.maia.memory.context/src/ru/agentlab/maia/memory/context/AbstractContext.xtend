package ru.agentlab.maia.memory.context

import java.util.Collection
import java.util.Collections
import java.util.HashSet
import java.util.Set
import java.util.UUID
import javax.inject.Provider
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.memory.IMaiaContext

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
		val inLocal = containsInternal(clazz)
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
		val inLocal = containsInternal(name)
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

	override getService(String name) throws NullPointerException {
		if (name == null) {
			throw new NullPointerException
		}
		if (containsInternal(name)) {
			val value = getInternal(name)
			if (value instanceof Provider<?>) {
				return value.get
			} else {
				return value
			}
		} else {
			if (parent != null) {
				return parent.getService(name)
			} else {
				return null
			}
		}
	}

	override <T> getService(Class<T> clazz) throws NullPointerException, ClassCastException {
		if (clazz == null) {
			throw new NullPointerException
		}
		if (containsInternal(clazz)) {
			val value = getInternal(clazz)
			if (value instanceof Provider<?>) {
				return value.get as T
			} else {
				return value as T
			}
		} else {
			if (parent != null) {
				return parent.getService(clazz)
			} else {
				return null
			}
		}
	}

	override getServiceLocal(String name) throws NullPointerException {
		if (name == null) {
			throw new NullPointerException
		}
		val value = getInternal(name)
		if (value instanceof Provider<?>) {
			return value.get
		} else {
			return value
		}
	}

	override <T> getServiceLocal(Class<T> clazz) throws NullPointerException, ClassCastException {
		if (clazz == null) {
			throw new NullPointerException
		}
		val value = getInternal(clazz)
		if (value instanceof Provider<?>) {
			return value.get as T
		} else {
			return value as T
		}
	}

	override getProvider(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		if (containsInternal(name)) {
			val value = getInternal(name)
			if (value instanceof Provider<?>) {
				return value as Provider<?>
			} else {
				return null
			}
		} else {
			if (parent != null) {
				return parent.getProvider(name)
			} else {
				return null
			}
		}
	}

	override <T> getProvider(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		if (containsInternal(clazz)) {
			val value = getInternal(clazz)
			if (value instanceof Provider<?>) {
				return value as Provider<T>
			} else {
				return null
			}
		} else {
			if (parent != null) {
				return parent.getProvider(clazz)
			} else {
				return null
			}
		}
	}

	override <T> getProviderLocal(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		val value = getInternal(clazz)
		if (value instanceof Provider<?>) {
			return value as Provider<T>
		} else {
			return null
		}
	}

	override getProviderLocal(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		val value = getInternal(name)
		if (value instanceof Provider<?>) {
			return value as Provider<?>
		} else {
			return null
		}
	}

	override putService(String name, Object value) {
		if (name == null) {
			throw new NullPointerException
		}
		putInternal(name, value)
	}

	override <T> putService(Class<T> clazz, T value) {
		if (clazz == null) {
			throw new NullPointerException
		}
		putInternal(clazz, value)
	}

	override putProvider(String name, Provider<?> provider) {
		if (name == null) {
			throw new NullPointerException
		}
		putInternal(name, provider)
	}

	override <T> putProvider(Class<T> clazz, Provider<T> provider) {
		if (clazz == null) {
			throw new NullPointerException
		}
		putInternal(clazz, provider)
	}

	override remove(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		removeInternal(name)
	}

	override remove(Class<?> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		removeInternal(clazz)
	}

	override clear() {
		clearInternal()
	}

	override Set<String> getKeySet() {
		return getKeySetInternal
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

	def protected boolean containsInternal(String name)

	def protected boolean containsInternal(Class<?> clazz)

	def protected Object getInternal(String name)

	def protected Object getInternal(Class<?> clazz)

	def protected void putInternal(String name, Object value)

	def protected void putInternal(Class<?> clazz, Object value)

	def protected Object removeInternal(String name)

	def protected Object removeInternal(Class<?> clazz)

	def protected boolean clearInternal()

	def protected Set<String> getKeySetInternal()

}