package ru.agentlab.maia.time.annotation.converter;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.Queue;
import java.util.UUID;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;

import javax.inject.Inject;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.event.AgentStartedEvent;
import ru.agentlab.maia.agent.event.AgentStoppedEvent;
import ru.agentlab.maia.agent.impl.Plan;
import ru.agentlab.maia.converter.IPlanExtraConverter;
import ru.agentlab.maia.time.TimerEvent;
import ru.agentlab.maia.time.annotation.OnTimerFixedRate;

public class OnTimerFixedRateExtraPlansConverter implements IPlanExtraConverter {

	@Inject
	ScheduledExecutorService scheduler;

	@Inject
	Queue<Object> eventQueue;

	@Override
	public Multimap<Class<?>, IPlan> getPlans(Object role, Method method, Annotation annotation,
			Map<String, Object> customData) {
		OnTimerFixedRate onTimerDelay = (OnTimerFixedRate) annotation;

		final UUID eventKey = (UUID) customData.get(annotation.getClass().getName());
		final ScheduledFuture<?>[] futures = new ScheduledFuture[1];

		Runnable onStartPlan = () -> {
			System.out.println("Register schedule");
			futures[0] = scheduler.scheduleAtFixedRate(() -> eventQueue.offer(new TimerEvent(eventKey)),
					onTimerDelay.delay(), onTimerDelay.value(), onTimerDelay.unit());
		};

		Runnable onStopPlan = () -> {
			System.out.println("Unregister schedule");
			futures[0].cancel(true);
		};

		Multimap<Class<?>, IPlan> result = ArrayListMultimap.create();
		result.put(AgentStartedEvent.class, new Plan(role, onStartPlan));
		result.put(AgentStoppedEvent.class, new Plan(role, onStopPlan));
		return result;
	}

}