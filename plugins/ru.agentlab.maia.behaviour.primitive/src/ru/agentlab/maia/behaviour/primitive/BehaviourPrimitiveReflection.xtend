package ru.agentlab.maia.behaviour.primitive

import java.lang.reflect.Method
import ru.agentlab.maia.behaviour.BehaviourException
import ru.agentlab.maia.behaviour.BehaviourPrimitive
import ru.agentlab.maia.behaviour.annotation.Execute

/**
 * 
 * @author Dmitry Shishkin
 */
abstract class BehaviourPrimitiveReflection extends BehaviourPrimitive implements IBehaviourPrimitiveReflection {

	var protected Method method

	var protected Object implementation

	override void setImplementation(Object impl) {
		implementation = impl
		method = impl.class.declaredMethods.findFirst[isAnnotationPresent(Execute)]
		if (method == null) {
			throw new IllegalArgumentException("Task have no method annotated with @" + Execute.simpleName)
		}
		method.exceptionTypes.forEach [
			addException(new BehaviourException(it))
		]
	}

}
