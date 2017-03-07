package ru.agentlab.maia.service.time.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.util.concurrent.TimeUnit;

import ru.agentlab.maia.agent.converter.PlanEventFilterConverter;
import ru.agentlab.maia.agent.converter.PlanEventType;
import ru.agentlab.maia.agent.converter.PlanExtraConverter;
import ru.agentlab.maia.service.time.TimerEvent;
import ru.agentlab.maia.service.time.annotation.converter.OnTimerFixedPeriodExtraPlansConverter;
import ru.agentlab.maia.service.time.annotation.converter.OnTimerXXXEventMatcherConverter;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@PlanEventType(TimerEvent.class)
@PlanEventFilterConverter(OnTimerXXXEventMatcherConverter.class)
@PlanExtraConverter(OnTimerFixedPeriodExtraPlansConverter.class)
public @interface OnTimerFixedPeriod {

	long value();

	long delay() default 0;

	TimeUnit unit() default TimeUnit.MILLISECONDS;

}
