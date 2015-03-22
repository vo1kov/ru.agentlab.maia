package ru.agentlab.maia

import java.lang.annotation.ElementType
import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy
import java.lang.annotation.Target
import ru.agentlab.maia.behaviour.IBehaviour

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
annotation Action {

	String type = IBehaviour.TYPE_DEFAULT

}
