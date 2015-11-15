package ru.agentlab.maia.organization

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class RoleConstraint implements IRoleConstraint {

	var IRole source

	var IRole target

	new(IRole source, IRole target) {
		this.source = source
		this.target = target
	}

}