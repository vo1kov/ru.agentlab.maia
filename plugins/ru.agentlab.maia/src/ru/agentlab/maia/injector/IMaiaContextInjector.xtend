package ru.agentlab.maia.injector

import java.lang.annotation.Annotation
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.IMaiaContextListener

interface IMaiaContextInjector {

	def <T> T make(Class<T> contributorClass, IMaiaContext context)
	
	def Object invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context)

	def Object invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context, Object defaultValue)

	def void inject(Object service, IMaiaContext toContext)

	def void addListener(IMaiaContext context, String key, IMaiaContextListener listener)

	def void addListener(IMaiaContext context, Class<?> key, IMaiaContextListener listener)

}