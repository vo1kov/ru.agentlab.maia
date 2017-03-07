package ru.agentlab.maia.agent.annotation.converter;

import static ru.agentlab.maia.agent.belief.filter.Matchers.hasObject;
import static ru.agentlab.maia.agent.belief.filter.Matchers.hasProperty;
import static ru.agentlab.maia.agent.belief.filter.Matchers.hasSubject;
import static ru.agentlab.maia.agent.belief.filter.Matchers.isIndividual;
import static ru.agentlab.maia.agent.belief.filter.Matchers.isNamedIndividual;
import static ru.agentlab.maia.agent.belief.filter.Matchers.isObjectProperty;
import static ru.agentlab.maia.agent.filter.impl.PlanEventFilters.allOf;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

import com.google.common.collect.Lists;

import ru.agentlab.maia.agent.converter.IPlanEventFilterConverter;
import ru.agentlab.maia.agent.converter.Util;
import ru.agentlab.maia.agent.filter.IPlanEventFilter;

public class OWLObjectPropertyAssertionAxiomTemplateConverter extends TemplateConverter
		implements IPlanEventFilterConverter {

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
				hasSubject(isNamedIndividual(hasName(args[0]))),
				hasProperty(isObjectProperty(hasName(args[1]))),
				hasObject(isIndividual(isNamedIndividual(hasName(args[2]))))));
	}

}
