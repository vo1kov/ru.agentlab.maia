package ru.agentlab.maia.service.time.annotation.converter;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.UUID;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;

import javax.inject.Inject;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.agent.converter.IPlanExtraConverter;
import ru.agentlab.maia.agent.event.AgentStartedEvent;
import ru.agentlab.maia.agent.event.AgentStoppedEvent;
import ru.agentlab.maia.service.time.TimerEvent;
import ru.agentlab.maia.service.time.annotation.OnTimerFixedRate;

public class OnTimerFixedRateExtraPlansConverter implements IPlanExtraConverter {

	@Inject
	ScheduledExecutorService scheduler;

	@Inject
	Queue<Object> eventQueue;

	@Override
	public List<IPlan<?>> getPlans(Object role, Method method, Annotation annotation, Map<String, Object> customData) {
		OnTimerFixedRate onTimerDelay = (OnTimerFixedRate) annotation;

		final UUID eventKey = (UUID) customData.get(annotation.getClass().getName());
		final ScheduledFuture<?>[] futures = new ScheduledFuture[1];

		Runnable onStartPlan = () -> {
			System.out.println("Register schedule");
			futures[0] = scheduler.scheduleAtFixedRate(
				() -> eventQueue.offer(new TimerEvent(eventKey)),
				onTimerDelay.delay(),
				onTimerDelay.value(),
				onTimerDelay.unit());
		};

		Runnable onStopPlan = () -> {
			System.out.println("Unregister schedule");
			futures[0].cancel(true);
		};

		List<IPlan<?>> result = new ArrayList<>();
		result.add(new Plan<AgentStartedEvent>(AgentStartedEvent.class, onStartPlan)); // AgentStartedEvent.class,
		result.add(new Plan<AgentStoppedEvent>(AgentStoppedEvent.class, onStopPlan)); // AgentStoppedEvent.class,
		return result;
	}

}