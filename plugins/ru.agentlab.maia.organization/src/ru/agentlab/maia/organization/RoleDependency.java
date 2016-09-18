package ru.agentlab.maia.organization;

import ru.agentlab.maia.organization.IRole;
import ru.agentlab.maia.organization.RoleConstraint;

@SuppressWarnings("all")
public class RoleDependency extends RoleConstraint {
  public RoleDependency(final IRole source, final IRole target) {
    super(source, target);
  }
}
