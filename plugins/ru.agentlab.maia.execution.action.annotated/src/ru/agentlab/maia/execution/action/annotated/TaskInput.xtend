package ru.agentlab.maia.execution.action.annotated

import java.lang.annotation.ElementType
import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy
import java.lang.annotation.Target

@Target(#[ElementType.FIELD])
@Retention(RetentionPolicy.RUNTIME)
annotation TaskInput {
}