package ru.agentlab.maia

import java.lang.annotation.ElementType
import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy
import java.lang.annotation.Target

/**
 * <p>Annotation indicated method that returns true when behaviour is done and
 * false otherwise. Method should return boolean.</p>
 * <p>Example of using annotation:</p>
 * <pre>
 * public class OneShotExample {
 * 
 *   &#64;Action
 *   public void action() {
 *     System.out.println("On Action...");
 *   }
 * 
 *   &#64;ActionDone
 *   public boolean actionDone() {
 *     return true;
 *   }
 * 
 * }</pre>
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
annotation ActionDone {
}