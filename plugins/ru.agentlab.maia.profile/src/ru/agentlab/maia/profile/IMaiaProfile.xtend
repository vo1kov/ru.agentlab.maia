package ru.agentlab.maia.profile

import java.util.Collection

interface IMaiaProfile {

	def <T> void putImplementation(Class<T> interf, Class<? extends T> impl)

	def <T> void putFactory(Class<T> interf, Class<?> factory)

	def <T> Class<T> getImplementation(Class<T> interf)

	def <T> Class<?> getFactory(Class<T> interf)

	def void removeImplementation(Class<?> interf)

	def void removeFactory(Class<?> interf)

	def Collection<Class<?>> getFactoryKeySet()

	def Collection<Class<?>> getImplementationKeySet()

}