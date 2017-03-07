package ru.agentlab.maia.organization;

import ru.agentlab.maia.organization.IRole;
import ru.agentlab.maia.organization.RoleConstraint;

@SuppressWarnings("all")
public class RoleCorrespondence extends RoleConstraint {
  public RoleCorrespondence(final IRole source, final IRole target) {
    super(source, target);
  }
}
