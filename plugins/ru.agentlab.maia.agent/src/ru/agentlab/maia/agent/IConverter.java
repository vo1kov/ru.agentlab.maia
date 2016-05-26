package ru.agentlab.maia.agent;

import java.util.Map;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.converter.ConverterException;

public interface IConverter {

	Map<IPlan, EventType> getPlans(Object role) throws ConverterException;

}