package ru.agentlab.maia.execution.scheduler.parallel

import ru.agentlab.maia.execution.AbstractExecutionScheduler
import ru.agentlab.maia.execution.IExecutionScheduler

/**
 * <p>
 * Parallel implementation of {@link IExecutionScheduler}.
 * Execute until all nodes are performed.  
 * Select child nodes in order of adding.
 * <p>Default policies:</p><ul>
 * <li>When any child become {@link State#BLOCKED BLOCKED} then 
 * scheduler skip it and select next;</li>
 * <li>When any child become {@link State#FAILED FAILED} then 
 * scheduler skip it and select next;</li>
 * <li>When any child become {@link State#SUCCESS SUCCESS} then 
 * scheduler scheduling to next child;</li>
 * <li>When all child nodes are executed successfully then 
 * scheduler become {@link State#SUCCESS SUCCESS};</li>
 * </ul>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class ParallelScheduler extends AbstractExecutionScheduler {

	/**
	 * Construct instance of scheduler and set default policies.
	 */
	new() {
		policyOnChildBlocked = Policy.SKIP
		policyOnChildFailed = Policy.SCHEDULING
		policyOnChildSuccess = Policy.SKIP
		policyOnChildWorking = Policy.SCHEDULING
		policyOnAllChildsBlocked = Policy.BLOCKED
		policyOnAllChildsSuccess = Policy.SUCCESS
		numRetriesMax = 1
	}

	/**
	 * Increment current index.
	 */
	override getNextIndex() {
		index = index + 1
	}

}