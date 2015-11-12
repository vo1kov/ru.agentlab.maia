package ru.agentlab.maia.adapter

/**
 * @param <F> 			target object type 
 * @param <T>			result object type
 */
interface IIssue {

	def Object resolve(Object target)

	def String getTarget()

	def String getResult()

}