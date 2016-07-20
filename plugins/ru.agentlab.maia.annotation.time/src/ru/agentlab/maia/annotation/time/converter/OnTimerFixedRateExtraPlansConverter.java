package ru.agentlab.maia.annotation.time.converter;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;

import javax.inject.Inject;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.annotation.IExtraPlansConverter;
import ru.agentlab.maia.annotation.time.OnTimerFixedRate;
import ru.agentlab.maia.event.AgentStartedEvent;
import ru.agentlab.maia.event.AgentStoppedEvent;

public class OnTimerFixedRateExtraPlansConverter implements IExtraPlansConverter {

	@Inject
	ScheduledExecutorService scheduler;

	@Inject
	IAgent agent;

	@Override
	public Multimap<Class<?>, IPlan> getPlans(Object role, Method method, Annotation annotation,
			Map<String, Object> customData) {
		OnTimerFixedRate onTimerDelay = (OnTimerFixedRate) annotation;

		final UUID eventKey = (UUID) customData.get(OnTimerXXXEventMatcherConverter.EVENT_KEY);
		final ScheduledFuture<?>[] futures = new ScheduledFuture[1];

		Runnable onStartPlan = () -> {
			futures[0] = scheduler.scheduleAtFixedRate(() -> agent.fireExternalEvent(new TimerEvent(eventKey)),
					onTimerDelay.delay(), onTimerDelay.value(), onTimerDelay.unit());
		};

		Runnable onStopPlan = () -> {
			futures[0].cancel(true);
		};

		Multimap<Class<?>, IPlan> result = ArrayListMultimap.create();
		result.put(AgentStartedEvent.class, new Plan(role, onStartPlan));
		result.put(AgentStoppedEvent.class, new Plan(role, onStopPlan));
		return result;
	}

}