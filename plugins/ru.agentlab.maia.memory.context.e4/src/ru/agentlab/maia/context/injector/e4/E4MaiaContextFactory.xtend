package ru.agentlab.maia.context.injector.e4

import java.util.ArrayList
import java.util.Collection
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextFactory
import ru.agentlab.maia.memory.IMaiaContextInjector

class E4MaiaContextFactory implements IMaiaContextFactory {

	IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	override createContext() {
		val childContext = new E4MaiaContext(context.get(IEclipseContext).createChild)
		init(childContext)
		registerParent(childContext, context)
		registerChild(context, childContext)
		return childContext
	}

	def protected void registerParent(IMaiaContext context, IMaiaContext parent) {
		context.set(IMaiaContext.KEY_PARENT_CONTEXT, parent)
	}

	def protected void registerChild(IMaiaContext parent, IMaiaContext child) {
		var childs = parent.getLocal(IMaiaContext.KEY_CHILD_CONTEXTS) as Collection<IMaiaContext>
		if (childs == null) {
			childs = new ArrayList<IMaiaContext>
		}
		childs += child
		context.set(IMaiaContext.KEY_CHILD_CONTEXTS, childs)
	}

	def protected void init(E4MaiaContext context) {
		context.set(IMaiaContext, context)
		context.set(IMaiaContextInjector, new E4MaiaContextInjector(context))
		context.set(IMaiaContextFactory, new E4MaiaContextFactory(context))
//		context.set(IMaiaServiceDeployer, new MaiaServiceDeployer(context))
	}

}