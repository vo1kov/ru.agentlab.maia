package ru.agentlab.maia.task.pattern

interface IPatternScheme {

	def void addDefaultTransition(IPatternState from, IPatternState to)

	def void addExceptionTransition(IPatternState from, IPatternState to, Class<? extends RuntimeException> exc)

	def void addEventTransition(IPatternState from, IPatternState to, String topic)
	
}