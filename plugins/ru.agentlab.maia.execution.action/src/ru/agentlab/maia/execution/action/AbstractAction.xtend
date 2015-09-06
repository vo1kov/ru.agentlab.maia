package ru.agentlab.maia.execution.action

import javax.annotation.PostConstruct
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.node.AbstractNode
import ru.agentlab.maia.execution.tree.IExecutionAction
import ru.agentlab.maia.memory.IMaiaContextInjector

abstract class AbstractAction extends AbstractNode implements IExecutionAction {

	@Accessors
	val Class<?> actionClass

	var protected Object actionImpl

	new(Class<?> clazz) {
		this.actionClass = clazz
	}

	override final run() {
		if (actionImpl == null) {
			context.get(IMaiaContextInjector) => [
				actionImpl = make(actionClass)
				invoke(actionImpl, PostConstruct, null)
			]
		}
		try {
			doInject()
			doRun()
			doUninject()
		} catch (Exception e) {
			e.printStackTrace
		}
	}

	abstract def void doInject()

	abstract def void doUninject()

	abstract def Object doRun()

}