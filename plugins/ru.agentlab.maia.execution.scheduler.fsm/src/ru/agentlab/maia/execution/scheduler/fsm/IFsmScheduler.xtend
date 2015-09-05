package ru.agentlab.maia.execution.scheduler.fsm

import ru.agentlab.maia.execution.scheduler.fsm.impl.DefaultFsmTransition
import ru.agentlab.maia.execution.scheduler.fsm.impl.EventFsmTransition
import ru.agentlab.maia.execution.scheduler.fsm.impl.ExceptionFsmTransition
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

interface IFsmScheduler extends IExecutionScheduler {

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
	def DefaultFsmTransition addDefaultTransition(IExecutionNode from, IExecutionNode to)

	/**
	 * Add new Exception-based transition to scheduler.
	 * 
	 * @param from - The initial node for transition. Indicates node from 
	 * where transition should be occurred. If null, then transition 
	 * considered to be a initial.
	 * 
	 * @param to - The node where the scheduler has to move from the initial node.
	 * If null, then transition considered to be a final.
	 * 
	 * @param exception - The Exception class that indicates transition can be invoked.
	 * 
	 * @return Newly created Exception transition or <code>null</code> if there is some transition 
	 * with same parameters.
	 */
	def ExceptionFsmTransition addExceptionTransition(IExecutionNode from, IExecutionNode to,
		Class<? extends RuntimeException> exception)

	/**
	 * Add new Event-based transition to scheduler.
	 * 
	 * @param from - The initial node for transition. Indicates node from 
	 * where transition should be occurred. If null, then transition 
	 * considered to be a initial.
	 * 
	 * @param to - The node where the scheduler has to move from the initial node.
	 * If null, then transition considered to be a final.
	 * 
	 * @param topic - Topic of interesting event.
	 * 
	 * @return Newly created Event transition or <code>null</code> if there is some transition 
	 * with same parameters.
	 */
	def EventFsmTransition addEventTransition(IExecutionNode from, IExecutionNode to, String topic)
}