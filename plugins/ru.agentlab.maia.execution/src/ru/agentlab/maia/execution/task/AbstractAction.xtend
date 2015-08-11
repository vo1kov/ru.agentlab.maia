package ru.agentlab.maia.execution.task

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContextInjector

abstract class AbstractAction extends AbstractNode implements IAction {

	@Accessors
	val Class<?> actionClass

	var protected Object actionImpl

	@Inject
	var IMaiaContextInjector injector

	new(Class<?> clazz) {
		this.actionClass = clazz
	}

	override run() {
		if (actionImpl == null) {
			actionImpl = injector.make(actionClass)
			injector.invoke(actionImpl, PostConstruct, null)
		}
		try {
			doInject()
			val result = doRun()
			doUninject()
			return result
		} catch (Exception e) {
			e.printStackTrace
			return null
		}
	}

	abstract def void doInject()

	abstract def void doUninject()

	abstract def Object doRun()

}