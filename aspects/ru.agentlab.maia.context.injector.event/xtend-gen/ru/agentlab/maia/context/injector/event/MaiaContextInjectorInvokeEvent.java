package ru.agentlab.maia.context.injector.event;

import java.lang.annotation.Annotation;
import java.util.HashMap;
import java.util.Map;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import ru.agentlab.maia.event.IMaiaEvent;

@SuppressWarnings("all")
public class MaiaContextInjectorInvokeEvent implements IMaiaEvent {
  protected final static String KEY_OBJECT = "object";
  
  protected final static String KEY_ANNOTATION = "annotation";
  
  public final static String TOPIC = "ru/agentlab/maia/context/injector/Invoke";
  
  @Accessors
  private final HashMap<String, Object> data = new HashMap<String, Object>();
  
  public MaiaContextInjectorInvokeEvent(final Object object, final Class<? extends Annotation> ann) {
    this.data.put(MaiaContextInjectorInvokeEvent.KEY_OBJECT, object);
    this.data.put(MaiaContextInjectorInvokeEvent.KEY_ANNOTATION, ann);
  }
  
  public String getTopic() {
    return MaiaContextInjectorInvokeEvent.TOPIC;
  }
  
  public Object getObject() {
    return this.data.get(MaiaContextInjectorInvokeEvent.KEY_OBJECT);
  }
  
  public Class<? extends Annotation> getAnnotation() {
    Object _get = this.data.get(MaiaContextInjectorInvokeEvent.KEY_ANNOTATION);
    return ((Class<? extends Annotation>) _get);
  }
  
  @Pure
  public Map<String, Object> getData() {
    return this.data;
  }
}
