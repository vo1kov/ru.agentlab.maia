package ru.agentlab.maia.admin

import io.netty.channel.ChannelHandler
import org.osgi.framework.BundleContext
import org.osgi.util.tracker.ServiceTracker
import org.osgi.framework.ServiceReference
import io.netty.channel.ChannelPipeline

class HandlerTracker extends ServiceTracker<ChannelHandler, ChannelHandler> {

	ChannelPipeline pipeline

	new(BundleContext context, ChannelPipeline pipeline) {
		super(context, ChannelHandler.name, null)
		this.pipeline = pipeline
		open()
	}

	override addingService(ServiceReference<ChannelHandler> reference) {
		val handler = context.getService(reference)
		println("Added " + handler)
		if (pipeline != null) {
			pipeline.addLast(handler)
		}
		return handler
	}
	
	override removedService(ServiceReference<ChannelHandler> reference, ChannelHandler handler) {
		if (pipeline != null) {
			pipeline.remove(handler)
		}
        super.removedService(reference, service)
	}

}