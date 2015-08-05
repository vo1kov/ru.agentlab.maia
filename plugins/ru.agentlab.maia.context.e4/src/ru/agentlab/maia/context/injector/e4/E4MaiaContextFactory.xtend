package ru.agentlab.maia.context.injector.e4

import java.util.ArrayList
import java.util.Collection
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.context.initializer.IMaiaContextInitializerService
import ru.agentlab.maia.context.initializer.MaiaContextInitializerService

class E4MaiaContextFactory implements IMaiaContextFactory {

	IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	override createContext() {
		val child = new E4MaiaContext(context.get(IEclipseContext).createChild)
		child.init
		child.set(IMaiaContext.KEY_PARENT_CONTEXT, context)
		context.registerChild(child)
		return child
	}

	def void registerChild(IMaiaContext parent, IMaiaContext child) {
		var childs = parent.getLocal(IMaiaContext.KEY_CHILD_CONTEXTS) as Collection<IMaiaContext>
		if (childs == null) {
			childs = new ArrayList<IMaiaContext>
		}
		childs += child
		context.set(IMaiaContext.KEY_CHILD_CONTEXTS, childs)
	}

	def void init(E4MaiaContext context) {
		context.set(IMaiaContext, context)
		context.set(IMaiaContextInjector, new E4MaiaContextInjector(context))
		context.set(IMaiaContextFactory, new E4MaiaContextFactory(context))
		context.set(IMaiaContextInitializerService, new MaiaContextInitializerService(context))
	}

}