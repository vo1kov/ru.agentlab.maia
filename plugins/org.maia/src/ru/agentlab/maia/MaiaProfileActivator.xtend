package ru.agentlab.maia

import org.eclipse.xtend.lib.annotations.Accessors
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.profile.IMaiaProfile
import ru.agentlab.maia.profile.MaiaProfile

@Accessors
abstract class MaiaProfileActivator implements BundleActivator {

	static BundleContext context

	def static getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		MaiaProfileActivator.context = context
		registeredProfile.merge(profile)
	}

	override stop(BundleContext context) throws Exception {
		MaiaProfileActivator.context = null
		profile.keySet.forEach [
			registeredProfile.remove(it)
		]
	}

	def IMaiaProfile getProfile()

	def protected IMaiaProfile getRegisteredProfile() {
		val ref = context.getServiceReference(IMaiaProfile)
		return if (ref != null) {
			context.getService(ref)
		} else {
			val profile = new MaiaProfile
			context.registerService(IMaiaProfile, profile, null)
			profile
		}
	}

	def protected <T> void registerOsgiService(Class<T> interf, T service) {
		context.registerService(interf, service, null)
	}

	def protected <T> T getOsgiService(Class<T> interf) {
		val ref = context.getServiceReference(interf)
		if (ref != null) {
			return context.getService(ref)
		}
		return null
	}

}
