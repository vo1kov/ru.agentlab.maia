package ru.agentlab.maia.behaviour.primitive.lambda

/**
 * 
 * @author Dmitry Shishkin
 */
@FunctionalInterface
interface IExecutable {

	def Object[] execute(Object[] args)

}