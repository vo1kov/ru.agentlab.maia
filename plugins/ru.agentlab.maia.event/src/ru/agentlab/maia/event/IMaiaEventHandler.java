package ru.agentlab.maia.event;

import ru.agentlab.maia.event.IMaiaEvent;

@SuppressWarnings("all")
public interface IMaiaEventHandler {
  public abstract void handle(final IMaiaEvent event);
}
