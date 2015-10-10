package ru.agentlab.maia.execution

import java.util.concurrent.atomic.AtomicReference

interface ITaskParameter<T> {

	def String getName()

	def T getValue()

	def void setValue(T value)
	
	/**
	 * Can not be <code>null</code>.
	 */
	def AtomicReference<T> getReference()

	def <T> Class<T> getType()

	def boolean isOptional()

	def void link(ITaskParameter<T> param)

	def void unlink()
	
}