package ru.agentlab.maia.execution.action.jade

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.action.AbstractAction
import ru.agentlab.maia.execution.tree.IExecutionScheduler

class JadeAction extends AbstractAction {

	@Accessors
	var IExecutionScheduler parentNode
	
	new(Class<?> clazz) {
		super(clazz)
	}
	
	override doInject() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override doUninject() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override doRun() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}