package ru.agentlab.maia.annotation;

import ru.agentlab.maia.ConverterContext;
import ru.agentlab.maia.IStateMatcher;

public interface IStateMatcherConverter {

	IStateMatcher getMatcher(ConverterContext context);

}