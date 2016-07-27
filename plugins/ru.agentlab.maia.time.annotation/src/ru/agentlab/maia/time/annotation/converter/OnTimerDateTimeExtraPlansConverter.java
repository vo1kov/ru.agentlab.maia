package ru.agentlab.maia.time.annotation.converter;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import javax.inject.Inject;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

import ru.agentlab.maia.agent.IAgent;
import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.event.AgentStartedEvent;
import ru.agentlab.maia.agent.event.AgentStoppedEvent;
import ru.agentlab.maia.agent.impl.Plan;
import ru.agentlab.maia.converter.IPlanExtraConverter;
import ru.agentlab.maia.time.TimerEvent;
import ru.agentlab.maia.time.annotation.OnTimerDateTime;

public class OnTimerDateTimeExtraPlansConverter implements IPlanExtraConverter {

	@Inject
	ScheduledExecutorService scheduler;

	@Inject
	IAgent agent;

	@Override
	public Multimap<Class<?>, IPlan> getPlans(Object role, Method method, Annotation annotation,
			Map<String, Object> customData) {
		OnTimerDateTime onTimerDelay = (OnTimerDateTime) annotation;

		final UUID eventKey = (UUID) customData.get(annotation.getClass().getName());
		final ScheduledFuture<?>[] futures = new ScheduledFuture[1];
		LocalDateTime dateTime = LocalDateTime.parse(onTimerDelay.value(),
				DateTimeFormatter.ofPattern(onTimerDelay.pattern()));

		Runnable onStartPlan = () -> {
			LocalDateTime now = LocalDateTime.now();
			long delay = ChronoUnit.MILLIS.between(now, dateTime);
			System.out.println("Register schedule in " + delay + " ms");
			futures[0] = scheduler.schedule(() -> agent.fireExternalEvent(new TimerEvent(eventKey)), delay,
					TimeUnit.MILLISECONDS);
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