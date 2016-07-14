package ru.agentlab.maia.annotation;

import org.hamcrest.Matcher;

import ru.agentlab.maia.ConverterContext;

public interface IEventMatcherConverter {

	Matcher<?> getMatcher(ConverterContext context);

}