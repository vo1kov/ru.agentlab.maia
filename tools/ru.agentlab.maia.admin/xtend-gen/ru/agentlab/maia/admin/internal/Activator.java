package ru.agentlab.maia.admin.internal;

import org.eclipse.xtext.xbase.lib.InputOutput;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import ru.agentlab.maia.admin.WsAdminServer;

@SuppressWarnings("all")
public class Activator implements BundleActivator {
  public static BundleContext context;
  
  static BundleContext getContext() {
    return Activator.context;
  }
  
  /**
   * (non-Javadoc)
   * @see BundleActivator#start(org.osgi.framework.BundleContext)
   */
  public void start(final BundleContext bundleContext) throws Exception {
    Activator.context = bundleContext;
    InputOutput.<String>println(("start admin service " + Integer.valueOf(9091)));
    WsAdminServer _wsAdminServer = new WsAdminServer();
    _wsAdminServer.main();
  }
  
  /**
   * (non-Javadoc)
   * @see BundleActivator#stop(org.osgi.framework.BundleContext)
   */
  public void stop(final BundleContext bundleContext) throws Exception {
    Activator.context = null;
  }
}
