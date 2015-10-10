package ru.agentlab.maia.context

import java.util.UUID
import java.util.concurrent.atomic.AtomicReference
import javax.inject.Provider
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.exception.MaiaContextKeyNotFound

/**
 * <p>
 * Abstract {@link IMaiaContext} implementation.
 * </p>
 * <p>Implementation guarantee that:
 * </p>
 * <ul>
 * <li>Context can have parent;</li>
 * <li>Context have unique UUID;</li>
 * <li>Context redirect service searching to parent if can't find it;</li>
 * <li>Context disable <code>null</code> keys for storing services;</li>
 * </ul>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
abstract class Context implements IContext {

	@Accessors
	val private uuid = UUID.randomUUID.toString

	var protected parent = new AtomicReference<IContext>(null)

	override getParent() {
		return parent.get
	}

	override getService(String key) throws MaiaContextKeyNotFound {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		try {
			return getInternal(key).extractServiceFromObject
		} catch (MaiaContextKeyNotFound e) {
			val p = parent.get
			if (p != null) {
				return p.getService(key)
			} else {
				throw new MaiaContextKeyNotFound(
					'''Service for key [«key»] did not found in context [«this.toString»] and all their parents'''
				)
			}
		}
	}

	override <T> getService(Class<T> key) throws MaiaContextKeyNotFound {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		try {
			return getInternal(key).extractServiceFromObject
		} catch (MaiaContextKeyNotFound e) {
			val p = parent.get
			if (p != null) {
				return p.getService(key)
			} else {
				throw new MaiaContextKeyNotFound(
					'''Service for key [«key»] did not found in context [«this.toString»] and all their parents'''
				)
			}
		}
	}

	override getServiceLocal(String key) throws MaiaContextKeyNotFound {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return getInternal(key).extractServiceFromObject
	}

	override <T> getServiceLocal(Class<T> key) throws MaiaContextKeyNotFound {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return getInternal(key).extractServiceFromObject
	}

	override getProvider(String key) throws MaiaContextKeyNotFound {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		try {
			return getInternal(key).extractProviderFromObject
		} catch (MaiaContextKeyNotFound e) {
			val p = parent.get
			if (p != null) {
				return p.getProvider(key)
			} else {
				throw new MaiaContextKeyNotFound(
					'''Provider for key [«key»] did not found in context [«this.toString»] and all their parents'''
				)
			}
		}
	}

	override <T> getProvider(Class<T> key) throws MaiaContextKeyNotFound {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		try {
			return getInternal(key).extractProviderFromObject
		} catch (MaiaContextKeyNotFound e) {
			val p = parent.get
			if (p != null) {
				return p.getProvider(key)
			} else {
				throw new MaiaContextKeyNotFound(
					'''Provider for key [«key»] did not found in context [«this.toString»] and all their parents'''
				)
			}
		}
	}

	override getProviderLocal(String key) throws MaiaContextKeyNotFound {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return getInternal(key).extractProviderFromObject
	}

	override <T> getProviderLocal(Class<T> key) throws MaiaContextKeyNotFound {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return getInternal(key).extractProviderFromObject
	}

	override putService(String key, Object value) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return putInternal(key, value)
	}

	override <T> putService(Class<T> key, T value) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return putInternal(key, value)
	}

	override putProvider(String key, Provider<?> provider) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return putInternal(key, provider)
	}

	override <T> putProvider(Class<T> key, Provider<T> provider) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return putInternal(key, provider)
	}

	override remove(String key) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return removeInternal(key)
	}

	override remove(Class<?> key) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
		return removeInternal(key)
	}

	override IContext setParent(IContext newParent) {
		return parent.getAndSet(newParent)
	}

	def private <T> T extractServiceFromObject(Object value) {
		if (value instanceof Provider<?>) {
			return value.get as T
		} else {
			return value as T
		}
	}

	def private <T> Provider<T> extractProviderFromObject(Object value) {
		if (value instanceof Provider<?>) {
			return value as Provider<T>
		} else {
			return null
		}
	}

	def protected Object getInternal(String key) throws MaiaContextKeyNotFound

	def protected Object getInternal(Class<?> key) throws MaiaContextKeyNotFound

	def protected Object putInternal(String key, Object value)

	def protected Object putInternal(Class<?> key, Object value)

	def protected Object removeInternal(String key)

	def protected Object removeInternal(Class<?> key)

}