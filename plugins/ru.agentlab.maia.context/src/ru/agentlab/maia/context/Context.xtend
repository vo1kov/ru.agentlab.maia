package ru.agentlab.maia.context

import java.util.UUID
import java.util.concurrent.atomic.AtomicReference
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

	override get(String key) {
		key.check
		try {
			return getInternal(key)
		} catch (MaiaContextKeyNotFound e) {
			val p = parent.get
			if (p != null) {
				return p.get(key)
			} else {
				throw new MaiaContextKeyNotFound(
					'''Service for key [«key»] did not found in context [«this.toString»] and all their parents'''
				)
			}
		}
	}

	override <T> get(Class<T> key) {
		key.check
		try {
			return getInternal(key) as T
		} catch (MaiaContextKeyNotFound e) {
			val p = parent.get
			if (p != null) {
				return p.get(key)
			} else {
				throw new MaiaContextKeyNotFound(
					'''Service for key [«key»] did not found in context [«this.toString»] and all their parents'''
				)
			}
		}
	}

	override getLocal(String key) {
		key.check
		return getInternal(key)
	}

	override <T> getLocal(Class<T> key) {
		key.check
		return getInternal(key) as T
	}

	override put(String key, Object value) {
		key.check
		return putInternal(key, value)
	}

	override <T> put(Class<T> key, T value) {
		key.check
		return putInternal(key, value)
	}

	override remove(String key) {
		key.check
		return removeInternal(key)
	}

	override remove(Class<?> key) {
		key.check
		return removeInternal(key)
	}

	override IContext setParent(IContext newParent) {
		return parent.getAndSet(newParent)
	}
	
	def private check(String key){
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
	}
	
	def private check(Class<?> key){
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null")
		}
	}

	def protected Object getInternal(String key)

	def protected Object getInternal(Class<?> key)

	def protected Object putInternal(String key, Object value)

	def protected Object putInternal(Class<?> key, Object value)

	def protected Object removeInternal(String key)

	def protected Object removeInternal(Class<?> key)

}
