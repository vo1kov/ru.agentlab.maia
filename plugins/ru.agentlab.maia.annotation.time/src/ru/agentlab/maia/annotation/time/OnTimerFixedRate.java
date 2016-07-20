package ru.agentlab.maia.annotation.time;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.util.concurrent.TimeUnit;

import ru.agentlab.maia.annotation.EventMatcher;
import ru.agentlab.maia.annotation.ExtraPlans;
import ru.agentlab.maia.annotation.time.converter.OnTimerFixedRateExtraPlansConverter;
import ru.agentlab.maia.annotation.time.converter.OnTimerXXXEventMatcherConverter;
import ru.agentlab.maia.annotation.time.converter.TimerEvent;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(converter = OnTimerXXXEventMatcherConverter.class, eventType = TimerEvent.class)
@ExtraPlans(converter = OnTimerFixedRateExtraPlansConverter.class)
public @interface OnTimerFixedRate {

	long value();

	long delay() default 0;

	TimeUnit unit() default TimeUnit.MILLISECONDS;
	
}
