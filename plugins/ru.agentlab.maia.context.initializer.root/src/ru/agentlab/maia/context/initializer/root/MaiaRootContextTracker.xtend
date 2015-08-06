package ru.agentlab.maia.context.initializer.root

import org.osgi.util.tracker.ServiceTracker
import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceReference
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.initializer.IMaiaContextInitializerService

class MaiaRootContextTracker extends ServiceTracker<IMaiaContext, IMaiaContext> {
	
	Class<?> initializer
	
	new(BundleContext context, Class<?> initializer) {
		super(context, IMaiaContext.name, null)
		this.initializer = initializer
	}
	
	override addingService(ServiceReference<IMaiaContext> reference) {
		super.addingService(reference)
		val ctx = context.getService(reference)
		ctx.get(IMaiaContextInitializerService).initService(initializer)
		return ctx
	}
	
}