package ru.agentlab.maia.behaviour.annotation

import java.lang.annotation.Retention
import java.lang.annotation.Target

/**
 * 
 * @author Dmitry Shishkin
 */
@Target(#[FIELD, METHOD])
@Retention(RUNTIME)
annotation Output {
}