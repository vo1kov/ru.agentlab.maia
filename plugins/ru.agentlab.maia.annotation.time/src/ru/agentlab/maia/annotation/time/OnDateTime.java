package ru.agentlab.maia.annotation.time;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface OnDateTime {

	String value();

	String pattern() default "yyyy.MM.dd hh:mm:ss";

}
