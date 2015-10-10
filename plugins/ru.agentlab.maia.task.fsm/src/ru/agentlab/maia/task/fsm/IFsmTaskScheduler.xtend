package ru.agentlab.maia.task.fsm

import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler

interface IFsmTaskScheduler extends ITaskScheduler {

	/**
	 * Add new Default transition to scheduler.
	 * 
	 * @param from - The initial node for transition. Indicates node from 
	 * where transition should be occurred. If null, then transition 
	 * considered to be a initial.
	 * 
	 * @param to - The node where the scheduler has to move from the initial node.
	 * If null, then transition considered to be a final.
	 * 
	 * @return Newly created Default transition or <code>null</code> scheduler have 
	 * some transition with same parameters.
	 */
	def DefaultFsmTransition addDefaultTransition(ITask from, ITask to)

	/**
	 * Add new Exception-based transition to scheduler.
	 * 
	 * @param from 				the initial node for transition. Indicates node from 
	 * 							where transition should be occurred. If null, then transition 
	 * 							considered to be a initial.
	 * @param to 				the node where the scheduler has to move from the initial node.
	 * 							If null, then transition considered to be a final.
	 * @param exception 		the Exception class that indicates transition can be invoked.
	 * @return 					newly created Exception transition or <code>null</code> if there is 
	 * 							some transition with same parameters.
	 */
	def ExceptionFsmTransition addExceptionTransition(ITask from, ITask to, Class<? extends RuntimeException> exception)

	/**
	 * Add new Event-based transition to scheduler.
	 * 
	 * @param from 				the initial node for transition. Indicates node from 
	 * 							where transition should be occurred. If null, then transition 
	 * 							considered to be a initial.
	 * @param to 				the node where the scheduler has to move from the initial node.
	 * 							If null, then transition considered to be a final.
	 * @param topic 			topic of interesting event.
	 * @return 					newly created Event transition or <code>null</code> if there is 
	 * 							some transition with same parameters.
	 */
	def EventFsmTransition addEventTransition(ITask from, ITask to, String topic)
}