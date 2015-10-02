package ru.agentlab.maia.execution.scheduler.sequential

import ru.agentlab.maia.execution.AbstractExecutionScheduler
import ru.agentlab.maia.execution.IExecutionScheduler

/**
 * <p>
 * Sequential implementation of {@link IExecutionScheduler}.
 * Select child nodes in order of adding.
 * <p>Default policies:</p><ul>
 * <li>When any child become {@link State#BLOCKED BLOCKED} then 
 * scheduler become {@link State#BLOCKED BLOCKED};</li>
 * <li>When any child become {@link State#FAILED FAILED} then 
 * scheduler become {@link State#FAILED FAILED};</li>
 * <li>When any child become  {@link State#SUCCESS SUCCESS} then 
 * scheduler scheduling to next child;</li>
 * <li>When all child nodes are executed successfully then 
 * scheduler become {@link State#SUCCESS SUCCESS};</li>
 * </ul>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class SequentialScheduler extends AbstractExecutionScheduler {

	/**
	 * Construct instance of scheduler and set default policies.
	 */
	new() {
		policyOnChildBlocked = Policy.BLOCKED
		policyOnChildFailed = Policy.FAILED
		policyOnChildSuccess = Policy.SCHEDULING
		policyOnChildWorking = Policy.IDLE
		policySomeChildsSkiped = Policy.FAILED
		policyNoChildsSkiped = Policy.SUCCESS
	}

	/**
	 * Increment current index.
	 */
	override getNextIndex() {
		index = index + 1
	}

}