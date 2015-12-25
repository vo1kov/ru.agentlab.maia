package ru.agentlab.maia.behaviour.primitive

import java.lang.reflect.Method
import ru.agentlab.maia.behaviour.BehaviourException
import ru.agentlab.maia.behaviour.BehaviourParameter
import ru.agentlab.maia.behaviour.BehaviourPrimitive
import ru.agentlab.maia.behaviour.BehaviourState
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

//	override execute() throws Exception {
//		try {
//			val args = newArrayOfSize(inputs.length)
//			inputs.forEach [ param, index |
//				args.set(index, param.value)
//			]
//			val results = executeInternal(args)
//			results.forEach [ obj, i |
//				save(outputs.get(i), obj)
//			]
//			state = BehaviourState.SUCCESS
//		} catch (Exception e) {
//			state = BehaviourState.FAILED
//			throw e
//		}
//	}
//
//	def protected Object[] executeInternal(Object[] args)
//
//	def protected <T> save(BehaviourParameter<T> output, Object value) {
//		output.value = value as T
//	}

}
