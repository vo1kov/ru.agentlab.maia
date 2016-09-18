package ru.agentlab.maia.organization;

public abstract class RoleConstraint implements IRoleConstraint {

	private IRole source;

	private IRole target;

	public RoleConstraint(final IRole source, final IRole target) {
		this.source = source;
		this.target = target;
	}

	public IRole getSource() {
		return this.source;
	}

	public void setSource(final IRole source) {
		this.source = source;
	}

	public IRole getTarget() {
		return this.target;
	}

	public void setTarget(final IRole target) {
		this.target = target;
	}

}
