package ru.agentlab.maia.annotation.message;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.annotation.EventMatcher;
import ru.agentlab.maia.annotation.message.converter.OnMessageXXXConverter;
import ru.agentlab.maia.event.MessageUnhandledEvent;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(converter = OnMessageXXXConverter.class, eventType = MessageUnhandledEvent.class)
public @interface OnMessageUnhandled {

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

	String replyByInMillisec() default "";

	String conversationId() default "";

	String postTimeStamp() default "";

}
