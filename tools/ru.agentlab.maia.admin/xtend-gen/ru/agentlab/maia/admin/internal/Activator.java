package ru.agentlab.maia.admin.internal;

import io.netty.channel.nio.NioEventLoopGroup;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import ru.agentlab.maia.admin.MaiaAdminBootstrap;

@SuppressWarnings("all")
public class Activator implements BundleActivator {
  public static BundleContext context;
  
  private final int port = 9091;
  
  private final NioEventLoopGroup bossGroup = new NioEventLoopGroup();
  
  private final NioEventLoopGroup workerGroup = new NioEventLoopGroup();
  
  static BundleContext getContext() {
    return Activator.context;
  }
  
  /**
   * (non-Javadoc)
   * @see BundleActivator#start(org.osgi.framework.BundleContext)
   */
  public void start(final BundleContext bundleContext) throws Exception {
    Activator.context = bundleContext;
    final MaiaAdminBootstrap serverBootstrap = new MaiaAdminBootstrap(this.bossGroup, this.workerGroup);
    serverBootstrap.bind(this.port);
    InputOutput.<String>println((("Start admin service on " + Integer.valueOf(this.port)) + " port"));
  }
  
  /**
   * (non-Javadoc)
   * @see BundleActivator#stop(org.osgi.framework.BundleContext)
   */
  public void stop(final BundleContext bundleContext) throws Exception {
    Activator.context = null;
    this.bossGroup.shutdownGracefully();
    this.workerGroup.shutdownGracefully();
  }
}
