package ru.agentlab.maia.service.event;

import ru.agentlab.maia.service.event.IMaiaEvent;

@SuppressWarnings("all")
public interface IMaiaEventHandler {
  public abstract void handle(final IMaiaEvent event);
}
