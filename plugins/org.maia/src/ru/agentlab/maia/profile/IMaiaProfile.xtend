package ru.agentlab.maia.profile

import java.util.Collection

interface IMaiaProfile {

	def <T> void put(Class<T> interf, Class<? extends T> impl)
	
	def void remove(Class<?> interf)

	def <T> Class<? extends T> get(Class<T> interf)

	def Collection<Class<?>> getKeySet()

	def Collection<Class<?>> getValues()
	
	def <T> void merge(IMaiaProfile profile)

}