package ru.agentlab.maia.agent.annotation.converter;

import static ru.agentlab.maia.agent.belief.filter.Matchers.hasClassExpression;
import static ru.agentlab.maia.agent.belief.filter.Matchers.hasIndividual;
import static ru.agentlab.maia.agent.belief.filter.Matchers.isNamedClass;
import static ru.agentlab.maia.agent.belief.filter.Matchers.isNamedIndividual;
import static ru.agentlab.maia.agent.filter.impl.PlanEventFilters.allOf;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

import com.google.common.collect.Lists;

import ru.agentlab.maia.agent.converter.IPlanEventFilterConverter;
import ru.agentlab.maia.agent.converter.Util;
import ru.agentlab.maia.agent.filter.IPlanEventFilter;

public class OWLClassAssertionAxiomTemplateConverter extends TemplateConverter implements IPlanEventFilterConverter {

	@Override
	public IPlanEventFilter<?> getMatcher(Object role, Method method, Annotation annotation,
			Map<String, Object> customData) {
		Annotation ann = annotation;
		String[] realValues = Util.getMethodActualValue(ann, VALUE, String[].class);
		String[] defaultValues = Util.getMethodDefaultValue(ann.annotationType(), VALUE, String[].class);
		String[] args2 = split(realValues);
		String[] args = merge(args2, defaultValues);
		return allOf(
			Lists.newArrayList(
				hasClassExpression(isNamedClass(hasName(args[0]))),
				hasIndividual(isNamedIndividual(hasName(args[1])))));
	}

}
