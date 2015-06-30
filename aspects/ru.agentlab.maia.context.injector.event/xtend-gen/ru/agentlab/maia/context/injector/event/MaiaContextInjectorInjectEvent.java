package ru.agentlab.maia.context.injector.event;

import java.util.HashMap;
import java.util.Map;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import ru.agentlab.maia.event.IMaiaEvent;

@SuppressWarnings("all")
public class MaiaContextInjectorInjectEvent implements IMaiaEvent {
  protected final static String KEY_OBJECT = "object";
  
  public final static String TOPIC = "ru/agentlab/maia/context/injector/Inject";
  
  @Accessors
  private final HashMap<String, Object> data = new HashMap<String, Object>();
  
  public MaiaContextInjectorInjectEvent(final Object object) {
    this.data.put(MaiaContextInjectorInjectEvent.KEY_OBJECT, object);
  }
  
  public String getTopic() {
    return MaiaContextInjectorInjectEvent.TOPIC;
  }
  
  public Object getObject() {
    return this.data.get(MaiaContextInjectorInjectEvent.KEY_OBJECT);
  }
  
  @Pure
  public Map<String, Object> getData() {
    return this.data;
  }
}
