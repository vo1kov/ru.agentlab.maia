package ru.agentlab.maia.agent.organization

interface IRole {

	def IRoleDefinition getDefinition()

	def String getName()

	def IGroup getGroup()

}