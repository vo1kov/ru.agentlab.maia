package ru.agentlab.maia.execution.action.annotated

import java.lang.reflect.Field
import java.lang.reflect.Method
import java.util.ArrayList
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.context.IMaiaServiceDeployer
import ru.agentlab.maia.execution.MaiaAbstractExecutorAction

class AnnotatedContextAction extends MaiaAbstractExecutorAction {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	Object task
	Class<?> action

	val Method metod
	val inputs = new ArrayList<Field>
	val outputs = new ArrayList<Field>

	new(Class<?> action) {
		this.action = action
		metod = action.methods.findFirst[isAnnotationPresent(Action)]
		if (metod == null) {
			throw new IllegalArgumentException("Action class have no method annotated with @" + Action.simpleName +
				" annotation")
		}
		inputs += action.declaredFields.filter[isAnnotationPresent(TaskInput)]
		outputs += action.declaredFields.filter[isAnnotationPresent(TaskOutput)]
	}

	@PostConstruct
	override void init() {
		super.init()
		task = context.get(IMaiaServiceDeployer).deploy(action, KEY_TASK)
	}

	override run() {
		// Inject inputs 
		val result = injector.invoke(task, Action)
		// Extract outputs
		parentScheduler.remove(this)
		return result
	}

}