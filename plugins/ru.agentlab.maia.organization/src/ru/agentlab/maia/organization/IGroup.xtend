package ru.agentlab.maia.organization

import java.util.Collection

interface IGroup {

	def IGroupDefinition getDefinition()

	def Collection<IRole> getRoles()

	def void registerAgentPlaysRole(IAgent agent, IRole role, IAuthorization authorization)

	def Collection<IAgent> getAgentsPlaysRole(IRole role)

}