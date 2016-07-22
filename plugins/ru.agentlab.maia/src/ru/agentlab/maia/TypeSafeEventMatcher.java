package ru.agentlab.maia;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Map;

@SuppressWarnings("unchecked")
public abstract class TypeSafeEventMatcher<T> implements IEventMatcher<T> {

	final private Class<?> expectedType;

	public TypeSafeEventMatcher() {
		Type genericSuperclass2 = getClass().getGenericSuperclass();
		ParameterizedType genericSuperclass = (ParameterizedType) genericSuperclass2;
		Type type = genericSuperclass.getActualTypeArguments()[0];
		if (type instanceof ParameterizedType) {
			Type ownerType = ((ParameterizedType) type).getRawType();
			this.expectedType = (Class<T>) ownerType;
		} else {
			this.expectedType = (Class<T>) type;
		}
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		return item != null && expectedType.isInstance(item) && matchesSafely((T) item, values);
	}

	/**
	 * Subclasses should implement this. The item will already have been checked
	 * for the specific type and will never be null.
	 */
	protected abstract boolean matchesSafely(T item, Map<String, Object> values);

}
