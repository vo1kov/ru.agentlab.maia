package ru.agentlab.maia.behaviour

import java.util.concurrent.atomic.AtomicReference

interface IBehaviourParameter<T> {

	def String getName()

	def T getValue()

	def void setValue(T value)
	
	/**
	 * Can not be <code>null</code>.
	 */
	def AtomicReference<T> getReference()

	def <T> Class<T> getType()

	def boolean isOptional()

	def void link(IBehaviourParameter<T> param)

	def void unlink()
	
}