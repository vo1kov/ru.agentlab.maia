package ru.agentlab.maia;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

public class ConverterContext {

	Object role;

	Method method;

	Annotation annotation;

	IInjector injector;

	Map<String, Object> variables;

	public Map<String, Object> getVariables() {
		return variables;
	}

	public void setVariables(Map<String, Object> variables) {
		this.variables = variables;
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

	public IInjector getInjector() {
		return injector;
	}

	public void setInjector(IInjector injector) {
		this.injector = injector;
	}

}
