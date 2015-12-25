package ru.agentlab.maia.behaviour

abstract class BehaviourScheduler extends Behaviour implements IBehaviourScheduler {

	override final execute() throws java.lang.Exception {
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
					throw new IllegalStateException("State [FAILED] is illegal. Failed behavior should throw some Exception")
				}
			}
		} catch (java.lang.Exception e) {
			handleChildFailed(e)
		}
	}

	def protected void handleChildSuccess() {
		state = State.SUCCESS
	}

	def protected void handleChildUnknown() {
		state = State.UNKNOWN
	}

	def protected void handleChildBlocked() {
		state = State.BLOCKED
	}

	def protected void handleChildReady() {
		state = State.READY
	}

	def protected void handleChildWorking() {
		state = State.WORKING
	}

	def protected void handleChildFailed(java.lang.Exception e) throws java.lang.Exception {
		state = State.FAILED
		throw e
	}

	def protected IBehaviour getCurrent()

}