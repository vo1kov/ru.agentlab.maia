package ru.agentlab.maia.execution

abstract class TaskSchedulerOrderedCustom extends TaskSchedulerOrdered {

	var protected Policy policyOnChildFailed = Policy.FAILED

	var protected Policy policyOnChildSuccess = Policy.SKIP

	var protected Policy policyOnChildBlocked = Policy.BLOCKED

	var protected Policy policyOnChildWorking = Policy.IDLE

	var protected Policy policyOnAllChildsBlocked = Policy.BLOCKED

	var protected Policy policyOnAllChildsSuccess = Policy.SUCCESS

	override notifySubtaskBlocked() {
		policyOnChildBlocked.handlePolicy
	}

	override notifySubtaskFailed() {
		policyOnChildFailed.handlePolicy
	}

	override notifySubtaskSuccess() {
		policyOnChildSuccess.handlePolicy
	}

	override notifySubtaskWorking() {
		policyOnChildWorking.handlePolicy
	}

	def protected void handlePolicy(Policy policy) {
		switch (policy) {
			case BLOCKED: {
				setStateBlocked()
			}
			case FAILED: {
				setStateFailed()
			}
			case SUCCESS: {
				setStateSuccess()
			}
			case SCHEDULING: {
				schedule()
			}
			case RESTART: {
				restart()
				parent.get?.notifySubtaskWorking
			}
			case SKIP: {
//				blockedChilds.add(childs.get(index))
				schedule()
			}
			case IDLE: {
				idle()
			}
			case DELETED: {
				val p = parent.get
				if (p != null) {
					p.removeSubtask(this)
					p.notifySubtaskWorking
				}
			}
		}
	}

}