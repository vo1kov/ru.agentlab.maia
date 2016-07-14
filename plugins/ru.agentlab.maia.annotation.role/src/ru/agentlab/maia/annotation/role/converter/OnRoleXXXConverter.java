package ru.agentlab.maia.annotation.role.converter;

import static org.hamcrest.CoreMatchers.anyOf;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.instanceOf;

import java.lang.annotation.Annotation;

import org.hamcrest.Matcher;

import ru.agentlab.maia.ConverterContext;
import ru.agentlab.maia.annotation.IEventMatcherConverter;
import ru.agentlab.maia.annotation.Util;

public class OnRoleXXXConverter implements IEventMatcherConverter {

	@Override
	public Matcher<?> getMatcher(ConverterContext context) {
		Annotation annotation = context.getAnnotation();
		Class<?> value = Util.getMethodValue(annotation, "value", Class.class);
		return anyOf(instanceOf(value), equalTo(value));
	}
}
