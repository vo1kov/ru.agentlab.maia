package ru.agentlab.maia.behaviour

abstract class BehaviourScheduler extends Behaviour implements IBehaviourScheduler {

	override final execute() throws Exception {
		try {
			current.execute
			switch (current.state) {
				case SUCCESS: {
					handleChildSuccess
				}
				case UNKNOWN: {
					handleChildUnknown
				}
				case READY: {
					handleChildReady
				}
				case WORKING: {
					handleChildWorking
				}
				case BLOCKED: {
					handleChildBlocked
				}
				case FAILED: {
					throw new IllegalStateException("State [FAILED] is illegal. Behavior should throw some Exception")
				}
			}
		} catch (Exception e) {
			handleChildFailed(e)
		}
	}

	def protected void handleChildSuccess() {
		state = BehaviourState.SUCCESS
	}

	def protected void handleChildUnknown() {
		state = BehaviourState.UNKNOWN
	}

	def protected void handleChildBlocked() {
		state = BehaviourState.BLOCKED
	}

	def protected void handleChildReady() {
		state = BehaviourState.READY
	}

	def protected void handleChildWorking() {
		state = BehaviourState.WORKING
	}

	def protected void handleChildFailed(Exception e) throws Exception {
		state = BehaviourState.FAILED
		throw e
	}

	def protected IBehaviour getCurrent()

}