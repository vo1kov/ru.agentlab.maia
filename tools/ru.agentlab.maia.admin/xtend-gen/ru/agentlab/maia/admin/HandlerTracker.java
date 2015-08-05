package ru.agentlab.maia.admin;

import com.google.common.base.Objects;
import io.netty.channel.ChannelHandler;
import io.netty.channel.ChannelPipeline;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;

@SuppressWarnings("all")
public class HandlerTracker extends ServiceTracker<ChannelHandler, ChannelHandler> {
  private ChannelPipeline pipeline;
  
  public HandlerTracker(final BundleContext context, final ChannelPipeline pipeline) {
    super(context, ChannelHandler.class.getName(), null);
    this.pipeline = pipeline;
    this.open();
  }
  
  public ChannelHandler addingService(final ServiceReference<ChannelHandler> reference) {
    final ChannelHandler handler = this.context.<ChannelHandler>getService(reference);
    InputOutput.<String>println(("Added " + handler));
    boolean _notEquals = (!Objects.equal(this.pipeline, null));
    if (_notEquals) {
      this.pipeline.addLast(handler);
    }
    return handler;
  }
  
  public void removedService(final ServiceReference<ChannelHandler> reference, final ChannelHandler handler) {
    boolean _notEquals = (!Objects.equal(this.pipeline, null));
    if (_notEquals) {
      this.pipeline.remove(handler);
    }
    ChannelHandler _service = this.getService();
    super.removedService(reference, _service);
  }
}
