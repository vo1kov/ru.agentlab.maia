package ru.agentlab.maia.behaviour.primitive.lambda

/**
 * 
 * @author Dmitry Shishkin
 */
@FunctionalInterface
interface ILambda {

	def Object[] execute(Object[] args)

}