package ru.agentlab.maia.annotation.time;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.annotation.EventMatcher;
import ru.agentlab.maia.annotation.ExtraPlans;
import ru.agentlab.maia.annotation.time.converter.OnTimerDateTimeExtraPlansConverter;
import ru.agentlab.maia.annotation.time.converter.OnTimerXXXEventMatcherConverter;
import ru.agentlab.maia.time.TimerEvent;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(converter = OnTimerXXXEventMatcherConverter.class, eventType = TimerEvent.class)
@ExtraPlans(converter = OnTimerDateTimeExtraPlansConverter.class)
public @interface OnTimerDateTime {

	String value();

	String pattern() default "yyyy.MM.dd hh:mm:ss";

}
