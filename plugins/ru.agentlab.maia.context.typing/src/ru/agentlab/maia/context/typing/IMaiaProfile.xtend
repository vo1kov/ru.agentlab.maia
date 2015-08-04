package ru.agentlab.maia.context.typing

import java.util.Collection

interface IMaiaProfile {

	def <T> void putImplementation(Class<T> interf, Class<? extends T> impl)

	def <T> Class<T> getImplementation(Class<T> interf)

	def void removeImplementation(Class<?> interf)

	def Collection<Class<?>> getImplementationKeySet()

}