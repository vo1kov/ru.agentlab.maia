package ru.agentlab.maia.behaviour.annotation

import java.lang.annotation.Retention
import java.lang.annotation.Target

/**
 * Annotation indicates method to be executed when action running.
 * <pre>
 * <code>
 * &#64;Execute
 * public Object execute(Object param) {
 *   return null;
 * }
 * </code>
 * </pre>
 * @author Dmitry Shishkin
 */
@Target(METHOD)
@Retention(RUNTIME)
annotation Execute {
}