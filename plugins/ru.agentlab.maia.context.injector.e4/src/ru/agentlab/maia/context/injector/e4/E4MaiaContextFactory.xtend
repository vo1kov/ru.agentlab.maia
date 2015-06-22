package ru.agentlab.maia.context.injector.e4

import java.util.ArrayList
import java.util.Collection
import javax.inject.Inject
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.osgi.framework.BundleContext
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.event.MaiaContextFactoryCreateEvent
import ru.agentlab.maia.context.injector.IMaiaContextInjector
import ru.agentlab.maia.event.IMaiaEventBroker
import ru.agentlab.maia.context.event.MaiaContextFactoryCreateChildEvent

class E4MaiaContextFactory implements IMaiaContextFactory {

//	var IMaiaEventBroker broker
//
//	@Inject
//	new(IMaiaEventBroker broker) {
//		this.broker = broker
//	}

	/**
	 * <p>Create new E4 context.</p>
	 * <p>Register:</p>
	 * <ul>
	 * <li><code>IMaiaContext</code></li>
	 * </ul>
	 */
	override createContext(String id) {
		val result = new E4MaiaContext(EclipseContextFactory.create(id))
//		broker.post(new MaiaContextFactoryCreateEvent(result))
		return result => [
			set(IMaiaContext, it)
			set(IMaiaContextInjector, new E4MaiaContextInjector)
		]
	}

	/**
	 * <p>Create E4 child context.</p>
	 * <p>Register:</p>
	 * <ul>
	 * <li><code>IMaiaContext</code></li>
	 * <li><code>IMaiaContextInjector</code></li> - if parent context have not any.
	 * </ul>
	 */
	override createChild(IMaiaContext parent, String name) {
		val result = new E4MaiaContext(parent.get(IEclipseContext).createChild(name))
//		broker.post(new MaiaContextFactoryCreateChildEvent(parent, result))
		return result => [
			set(IMaiaContext, it)
			if (get(IMaiaContextInjector) == null) {
				parent.set(IMaiaContextInjector, new E4MaiaContextInjector)
			}
			set(IMaiaContext.KEY_PARENT_CONTEXT, parent)
			var childs = parent.getLocal(IMaiaContext.KEY_CHILD_CONTEXTS) as Collection<IMaiaContext>
			if (childs == null) {
				childs = new ArrayList<IMaiaContext>
			}
			childs += it
			parent.set(IMaiaContext.KEY_CHILD_CONTEXTS, childs)
		]
	}

	/**
	 * 
	 */
	@Deprecated
	override createOsgiContext(BundleContext bundleContext) {
		val result = new E4MaiaContext(EclipseContextFactory.getServiceContext(bundleContext))
//		broker.post(new MaiaContextFactoryCreateEvent(result))
		return result => [
			set(IMaiaContext, it)
			set(IMaiaContextInjector, new E4MaiaContextInjector)
		]
	}

}