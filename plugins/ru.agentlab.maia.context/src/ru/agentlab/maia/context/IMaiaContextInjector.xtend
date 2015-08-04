package ru.agentlab.maia.context

import java.lang.annotation.Annotation
import ru.agentlab.maia.context.IMaiaContext

interface IMaiaContextInjector {

	def <T> T make(Class<T> contributorClass, IMaiaContext context)

	def Object invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context)

	def Object invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context, Object defaultValue)

	def void inject(Object service, IMaiaContext toContext)

}