package ru.agentlab.maia.role.converter;

import static org.hamcrest.CoreMatchers.anyOf;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.instanceOf;

import java.lang.annotation.Annotation;
import java.util.Map;

import org.hamcrest.Matcher;

public class RoleAnnotation2RoleMatcher {

	public Matcher<?> getMatcher(Annotation annotation, Map<String, Object> variables) {
		Class<?> value = Util.getMethodValue(annotation, "value", Class.class);
		return anyOf(instanceOf(value), equalTo(value));
	}
}
