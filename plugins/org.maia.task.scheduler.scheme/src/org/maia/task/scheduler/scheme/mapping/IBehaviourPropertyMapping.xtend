package org.maia.task.scheduler.scheme.mapping

interface IBehaviourPropertyMapping {

	def void put(Object task, String parameter, Object value)

	def Object get(Object task, String parameter)

	def void link(Object fromTask, String outputParameter, Object toTask, String inputParameter)

}