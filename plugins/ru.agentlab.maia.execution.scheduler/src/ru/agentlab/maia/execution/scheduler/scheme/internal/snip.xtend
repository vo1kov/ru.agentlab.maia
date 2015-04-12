package ru.agentlab.maia.execution.scheduler.scheme.internal

class snip {

//	def void init() {
//		// index all properties
//		context.runAndTrack(new RunAndTrack {
//
//			override changed(IEclipseContext context) {
//				val actionScheme = context.get(IContextSchedulerScheme)
//				val taskMapping = context.get(IBehaviourTaskMapping)
//				actionScheme => [
//					states.forEach [
//						val task = taskMapping.get(it)
//						if (task != null) {
//							propertyIndex.add(task)
//						}
//					]
//					transitions.forEach [
//						if (it instanceof ContextSchedulerTransitionEvent) {
//							propertyIndex.add(it, "topic")
//						} else if (it instanceof ContextSchedulerTransitionException) {
//							propertyIndex.add(it, "throwable")
//						}
//					]
//				]
//				return true
//			}
//
//		})
	// add event listeners
//		actionScheme.transitions.filter(BehaviourTransitionEvent).forEach [ transition |
//			val topic = propertyMapping.get(transition, "topic") as String
//			eventBroker.subscribe(topic, [
//				if (currentState == transition.fromState) {
//					scheduler.restart(this)
//				}
//			])
//		]
//	}
//	def private void injectInputParameters(Object task) {
//		task.class.declaredFields.filter [
//			val ann = declaredAnnotations.findFirst[annotationType == TaskInput]
//			ann != null
//		].forEach [ field |
//			field.setAccessible(true)
//			val value = propertyMapping.get(task, field.name)
//			println("  inject	" + task + "::" + field.name + " with value " + value)
//			if (!field.type.isPrimitive) {
//				field.set(task, value)
//			} else {
//				if (value != null) {
//					field.set(task, value)
//				}
//			}
//		]
//	}
//	def private void uninjectOutputParameters(Object task) {
//		task.class.declaredFields.filter [
//			val ann = declaredAnnotations.findFirst[annotationType == TaskOutput]
//			ann != null
//		].forEach [ field |
//			field.setAccessible(true)
//			val value = field.get(task)
//			println("uninject	" + task + "::" + field.name + " with value " + value)
//			propertyMapping.put(task, field.name, value)
//		]
//	}
//	def private void handleStart() {
//		currentState = getNextState(null)
//	}
//	def private void handleFinish() {
//		scheduler.remove(this)
//	}
//	def private Object handleCurrent() throws Exception {
//		val task = switch (currentState) {
//			BehaviourStateFinal: {
//				val c = actionScheme.getDefaultTask(currentState)
//				if (c == null) {
//					throw new BehaviourSchemeException("Scheme have no default mapping for [" + currentState +
//						"] state")
//				}
//				c
//			}
//			BehaviourStateImplement: {
//				val c = taskMapping.get(currentState)
//				if (c == null) {
//					throw new BehaviourTaskMappingException("Mapping have no required value for [" + currentState +
//						"] state")
//				}
//				c
//			}
//			BehaviourStateEmpty: {
//				var c = taskMapping.get(currentState)
//				if (c == null) {
//					c = actionScheme.getDefaultTask(currentState)
//				}
//				c
//			}
//		}
//		return task.invokeInternal
//	}
//	def private Object invokeInternal(Object task) throws Exception {
//		task.injectInputParameters
//		val result = ContextInjectionFactory.invoke(task, Action, context)
//		task.uninjectOutputParameters
//		return result
//	}
//	override void action() {
//		if (currentState == actionScheme.initialState) {
//			handleStart
//		} else if (currentState == actionScheme.finalState) {
//			handleFinish
//		} else {
//			val nextState = try {
//				val result = handleCurrent
//				getNextState(result)
//			} catch (Exception e) {
//				getNextExceptionState(e.class)
//			}
//			if (nextState == actionScheme.initialState) {
//				handleStart
//			} else if (nextState == actionScheme.finalState) {
//				handleFinish
//			}
//			if (nextState == null) {
//				throw new IllegalStateException("Action state [" + currentState + "] have no transition to next state")
//			}
//			currentState = nextState
//		}
//	}
//	def private Iterable<IContextSchedulerTransition> getPossibleTransitions() {
//		return schedulingScheme.transitions.filter[fromState == currentState]
//	}
//
//	def private IContextSchedulerState getNextState(Object status) {
//		val transitions = getPossibleTransitions
//		var next = transitions.findFirst[it instanceof ContextSchedulerTransitionStatus]
//		if (next == null) {
//			next = transitions.findFirst[it instanceof ContextSchedulerTransitionEvent]
//			if (next == null) {
//				next = transitions.findFirst[it instanceof ContextSchedulerTransitionDefault]
//			}
//		}
//		return next.toState
//	}
//
//	def private IContextSchedulerState getNextExceptionState(Class<? extends Exception> exceptionClass) {
//		val transition = schedulingScheme.transitions.findFirst [
//			if (it instanceof ContextSchedulerTransitionException) {
//				return exceptionClass.isAssignableFrom(it.throwable) && fromState == currentState
//			} else {
//				return false
//			}
//		]
//		transition?.toState
//	}	
}