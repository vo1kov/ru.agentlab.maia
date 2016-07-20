package ru.agentlab.maia;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

public class ConverterContext {

	Object role;

	Method method;

	Annotation annotation;

	Map<String, Object> customData;

	public Map<String, Object> getCustomData() {
		return customData;
	}

	public void setCustomData(Map<String, Object> variables) {
		this.customData = variables;
	}

	public Object getRole() {
		return role;
	}

	public void setRole(Object role) {
		this.role = role;
	}

	public Method getMethod() {
		return method;
	}

	public void setMethod(Method method) {
		this.method = method;
	}

	public Annotation getAnnotation() {
		return annotation;
	}

	public void setAnnotation(Annotation annotation) {
		this.annotation = annotation;
	}

}
