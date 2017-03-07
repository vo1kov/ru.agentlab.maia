package ru.agentlab.maia.organization;

import ru.agentlab.maia.organization.IGroup;
import ru.agentlab.maia.organization.IRoleDefinition;

@SuppressWarnings("all")
public interface IRole {
  public abstract IRoleDefinition getDefinition();
  
  public abstract String getName();
  
  public abstract IGroup getGroup();
}
