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

	override getService(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		if (isContainsLocal(name)) {
			return doGetServiceLocal(name)
		} else {
			if (parent != null) {
				return parent.getService(name)
			} else {
				return null
			}
		}
	}

	override <T> getService(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		if (isContainsLocal(clazz)) {
			return doGetServiceLocal(clazz)
		} else {
			if (parent != null) {
				return parent.getService(clazz)
			} else {
				return null
			}
		}
	}

	override getServiceLocal(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		return doGetServiceLocal(name)
	}

	override <T> getServiceLocal(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		return doGetServiceLocal(clazz)
	}

	override getProvider(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		if (isContainsLocal(name)) {
			return doGetProviderLocal(name)
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
		if (isContainsLocal(clazz)) {
			return doGetProviderLocal(clazz)
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
		return doGetProviderLocal(clazz)
	}

	override getProviderLocal(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		if (isContainsLocal(name)) {
			return doGetProviderLocal(name)
		}
	}

	override putService(String name, Object value) {
		if (name == null) {
			throw new NullPointerException
		}
		doPutServiceLocal(name, value)
	}

	override <T> putService(Class<T> clazz, T value) {
		if (clazz == null) {
			throw new NullPointerException
		}
		doPutServiceLocal(clazz, value)
	}

	override putProvider(String name, Provider<?> provider) {
		if (name == null) {
			throw new NullPointerException
		}
		doPutProviderLocal(name, provider)
	}

	override <T> putProvider(Class<T> clazz, Provider<T> provider) {
		if (clazz == null) {
			throw new NullPointerException
		}
		doPutProviderLocal(clazz, provider)
	}

	override remove(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		doRemoveLocal(name)
	}

	override remove(Class<?> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		doRemoveLocal(clazz)
	}
	
	override clear() {
		doClearLocal()
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

	def protected <T> T doGetServiceLocal(String name)

	def protected <T> T doGetServiceLocal(Class<T> clazz)

	def protected Provider<?> doGetProviderLocal(String string)

	def protected <T> Provider<T> doGetProviderLocal(Class<T> clazz)

	def protected void doPutServiceLocal(String name, Object value)

	def protected <T> void doPutServiceLocal(Class<T> clazz, T value)

	def protected void doPutProviderLocal(String name, Provider<?> provider)

	def protected <T> void doPutProviderLocal(Class<T> clazz, Provider<T> provider)

	def protected Object doRemoveLocal(String name)

	def protected Object doRemoveLocal(Class<?> clazz)
	
	def protected boolean doClearLocal()

	def protected Set<String> doGetKeySet()

}