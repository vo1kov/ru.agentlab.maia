package ru.agentlab.maia.annotation2.converter;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class Util {

	public static <T> T getMethodValue(Object object, String methodName, Class<T> clazz) {
		try {
			Method valueMethod = object.getClass().getMethod(methodName);
			Object result = valueMethod.invoke(object);
			return clazz.cast(result);
		} catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException
				| InvocationTargetException e) {
			e.printStackTrace();
			return null;
		}
	}

}
