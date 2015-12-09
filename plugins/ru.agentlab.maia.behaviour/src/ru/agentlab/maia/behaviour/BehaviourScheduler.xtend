package ru.agentlab.maia.behaviour

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * <p>Abstract {@link IBehaviourScheduler} implementation.</p>
 * 
 * <p>Implementation guarantee:</p>
 * 
 * <ul>
 * <li>execution of {@code run()} method will be redirected to one of child 
 * nodes. What exactly child node should be chosen depends of concrete
 * implementation.</li>
 * <li>when child node will notify about state change then appropriate policy 
 * will be handled.</li>
 * <li>when all retries will be exhausted then appropriate policy 
 * will be handled.</li>
 * </ul>
 * 
 * <p>Concrete implementations must implement algorithm of retrieving next 
 * child node. Additionally concrete implementation can change policies for
 * satisfying behavior requirements.</p>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
@Accessors
abstract class BehaviourScheduler extends Behaviour implements IBehaviourScheduler {

	override notifyChildBlocked() {
		setBlockedState
	}

//	override notifyChildSuccess() {
//		if (finished) {
//			setSuccessState
//		} else {
//			schedule()
//			setWorkingState
//		}
//	}
	override notifyChildFailed(IBehaviourException exception) {
		setFailedState(exception)
	}

	override notifyChildWorking() {
		setWorkingState
	}

	override notifyChildReady(IBehaviour node) {
		if (childs.exists[it == node]) {
			setReadyState
		} else {
			throw new IllegalArgumentException("Node doesn't contains in the scheduler")
		}
	}

	override execute() {
		getCurrent().execute
	}

	def protected IBehaviour getCurrent()

//	def protected boolean finished()
//	def protected void schedule()
}
