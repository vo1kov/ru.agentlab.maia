package ru.agentlab.maia.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.EventType;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(EventType.MESSAGE_UNHANDLED)
public @interface MessageUnhandled {

	String performative() default "";

	String protocol() default "";

	String sender() default "";

	String replyTo() default "";

	String content() default "";

	String replyWith() default "";

	String inReplyTo() default "";

	String encoding() default "";

	String language() default "";

	String ontology() default "";

	long replyByInMillisec() default -1;

	String conversationId() default "";

	long postTimeStamp() default -1;

}
