package ru.agentlab.maia.behaviour.fsm

import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.IBehaviourScheduler
import ru.agentlab.maia.behaviour.Behaviour

interface IBehaviourSchedulerFsm extends IBehaviourScheduler {

//	/**
//	 * Add new Default transition to scheduler.
//	 * 
//	 * @param from - The initial node for transition. Indicates node from 
//	 * where transition should be occurred. If null, then transition 
//	 * considered to be a initial.
//	 * 
//	 * @param to - The node where the scheduler has to move from the initial node.
//	 * If null, then transition considered to be a final.
//	 * 
//	 * @return Newly created Default transition or <code>null</code> scheduler have 
//	 * some transition with same parameters.
//	 */
//	def void addTransition(IExecutionStep from, IExecutionStep to)
	def void addBehaviourTransition(IBehaviour from, IBehaviour to)

	def void addBehaviourTransition(IBehaviour from, IBehaviour.Exception<?> to)

	def void addExceptionTransition(IBehaviour.Exception<?> from, Behaviour to)

	def void addExceptionTransition(IBehaviour.Exception<?> from, IBehaviour.Exception<?> to)

	def void addEventTransition(IBehaviour from, IBehaviour to, String topic)

	def void addEventTransition(IBehaviour from, IBehaviour.Exception<?> to, String topic)

//	def void registerFirstChild(IBehaviour behaviour)
//	/**
//	 * Add new Exception-based transition to scheduler.
//	 * 
//	 * @param from 				the initial node for transition. Indicates node from 
//	 * 							where transition should be occurred. If null, then transition 
//	 * 							considered to be a initial.
//	 * @param to 				the node where the scheduler has to move from the initial node.
//	 * 							If null, then transition considered to be a final.
//	 * @param exception 		the Exception class that indicates transition can be invoked.
//	 * @return 					newly created Exception transition or <code>null</code> if there is 
//	 * 							some transition with same parameters.
//	 */
//	def ExceptionFsmTransition addExceptionTransition(IBehaviour from, IBehaviour to)
//
//	/**
//	 * Add new Event-based transition to scheduler.
//	 * 
//	 * @param from 				the initial node for transition. Indicates node from 
//	 * 							where transition should be occurred. If null, then transition 
//	 * 							considered to be a initial.
//	 * @param to 				the node where the scheduler has to move from the initial node.
//	 * 							If null, then transition considered to be a final.
//	 * @param topic 			topic of interesting event.
//	 * @return 					newly created Event transition or <code>null</code> if there is 
//	 * 							some transition with same parameters.
//	 */
//	def EventFsmTransition addEventTransition(IBehaviour from, IBehaviour to, String topic)
}
