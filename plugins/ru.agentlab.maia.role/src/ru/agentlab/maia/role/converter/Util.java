package ru.agentlab.maia.role.converter;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class Util {

	private static final String FULL_SUFFIX = ">";
	private static final String FULL_PREFIX = "<";
	private static final String VAR_PREFIX = "?";

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

	public static boolean isVariable(String string) {
		return string.startsWith(VAR_PREFIX);
	}

	public static String getVariableName(String string) {
		return string.substring(VAR_PREFIX.length());
	}

	public static boolean isFullIRI(String string) {
		return string.startsWith(FULL_PREFIX) && string.endsWith(FULL_SUFFIX);
	}

	public static String getFullIRI(String string) {
		return string.substring(FULL_PREFIX.length(), string.length() - FULL_SUFFIX.length());
	}

}
