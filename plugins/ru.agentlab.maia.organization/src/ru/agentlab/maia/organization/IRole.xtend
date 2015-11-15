package ru.agentlab.maia.organization

interface IRole {

	def IRoleDefinition getDefinition()

	def String getName()

	def IGroup getGroup()

}