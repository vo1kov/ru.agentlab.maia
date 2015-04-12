package ru.agentlab.maia.execution.scheduler

import ru.agentlab.maia.IMaiaContext

interface IScheduler {

	def IMaiaContext getNextContext()
	
	def void add(IMaiaContext context)

	/**
	 * Moves a context from the ready queue to the sleeping queue. 
	 */
	def void block(IMaiaContext context)

	def void blockAll()

	/**
	 * Moves a context from the sleeping queue to the ready queue.
	 */
	def void restart(IMaiaContext context)

	/** 
	 * Restarts all contexts. This method simply calls IContext.restart() on
	 * every context. The IContext.restart() method then notifies the agent
	 * (with the Agent.notifyRestarted() method), causing Scheduler.restart() to
	 * be called (this also moves contexts from the blocked queue to the ready
	 * queue --> we must copy all contexts into a temporary buffer to avoid
	 * concurrent modification exceptions). Why not restarting only blocked
	 * contexts? Some ready context can be a ParallelIContext with some of its
	 * children blocked. These children must be restarted too.
	 */
	def void restartAll() 

	/** 
	 * Removes a specified context from the scheduler
	 */
	def void remove(IMaiaContext context) 

	/** 
	 * Removes a specified context from the scheduler
	 */
	def void removeAll()

}