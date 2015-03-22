package ru.agentlab.maia

import java.lang.annotation.ElementType
import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy
import java.lang.annotation.Target

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
annotation ActionTicker {
	
	long period = 0
	
	boolean fixedPeriod = false
	
}