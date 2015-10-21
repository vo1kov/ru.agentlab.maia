package ru.agentlab.maia.task

abstract class TaskSchedulerOrderedCustom extends OrderedTaskScheduler {

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
				state = TaskState.BLOCKED
			}
			case FAILED: {
				state = TaskState.FAILED
			}
			case SUCCESS: {
				state = TaskState.SUCCESS
			}
			case SCHEDULING: {
				schedule()
			}
			case RESTART: {
				restart()
				state = TaskState.WORKING
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