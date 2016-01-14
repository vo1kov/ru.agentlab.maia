package ru.agentlab.maia

import java.util.Collection

interface IGroup {

	def Collection<IRole> getRoles()

	def Collection<IAgent> getAgentsPlaysRole(IRole role)

}
