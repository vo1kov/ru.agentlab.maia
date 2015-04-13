package ru.agentlab.maia.e4

import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.osgi.framework.BundleContext
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.injector.IMaiaContextInjector

class E4MaiaContextFactory implements IMaiaContextFactory {

	/**
	 * <p>Create new E4 context.</p>
	 * <p>Register:</p>
	 * <ul>
	 * <li><code>IMaiaContext</code></li>
	 * </ul>
	 */
	override createContext(String id) {
		return new E4MaiaContext(EclipseContextFactory.create(id)) => [
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
		return new E4MaiaContext(parent.get(IEclipseContext).createChild(name)) => [
			set(IMaiaContext, it)
			if (get(IMaiaContextInjector) == null) {
				parent.set(IMaiaContextInjector, new E4MaiaContextInjector)
			}
		]
	}

	override createOsgiContext(BundleContext bundleContext) {
		return new E4MaiaContext(EclipseContextFactory.getServiceContext(bundleContext)) => [
			set(IMaiaContext, it)
			set(IMaiaContextInjector, new E4MaiaContextInjector)
		]
	}

}