package ru.agentlab.maia.context

import java.lang.annotation.Annotation

interface IMaiaContextInjector {

	def <T> T make(Class<T> contributorClass)

	def Object invoke(Object object, Class<? extends Annotation> ann)

	def Object invoke(Object object, Class<? extends Annotation> ann, Object defaultValue)

	def void inject(Object service)

}