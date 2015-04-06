package ru.agentlab.maia.context

import java.util.Collection

interface IProfile {

	def <T> void set(Class<T> interf, Class<? extends T> impl)

	def <T> Class<? extends T> get(Class<T> interf)

	def Collection<Class<?>> getKeys()

	def Collection<Class<?>> getValues()

}