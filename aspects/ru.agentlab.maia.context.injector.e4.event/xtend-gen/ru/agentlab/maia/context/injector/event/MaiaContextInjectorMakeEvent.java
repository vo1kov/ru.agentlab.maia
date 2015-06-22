package ru.agentlab.maia.context.injector.event;

import java.util.HashMap;
import java.util.Map;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import ru.agentlab.maia.event.IMaiaEvent;

@SuppressWarnings("all")
public class MaiaContextInjectorMakeEvent implements IMaiaEvent {
  protected final static String KEY_CLASS = "class";
  
  protected final static String KEY_OBJECT = "object";
  
  public final static String TOPIC = "ru/agentlab/maia/context/injector/Make";
  
  @Accessors
  private final HashMap<String, Object> data = new HashMap<String, Object>();
  
  public MaiaContextInjectorMakeEvent(final Class<?> clazz, final Object object) {
    this.data.put(MaiaContextInjectorMakeEvent.KEY_CLASS, clazz);
    this.data.put(MaiaContextInjectorMakeEvent.KEY_OBJECT, object);
  }
  
  public String getTopic() {
    return MaiaContextInjectorMakeEvent.TOPIC;
  }
  
  public Object getObject() {
    return this.data.get(MaiaContextInjectorMakeEvent.KEY_OBJECT);
  }
  
  public Object getObjectClass() {
    return this.data.get(MaiaContextInjectorMakeEvent.KEY_CLASS);
  }
  
  @Pure
  public Map<String, Object> getData() {
    return this.data;
  }
}
