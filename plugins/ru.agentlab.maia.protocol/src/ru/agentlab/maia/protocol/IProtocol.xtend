package ru.agentlab.maia.protocol

import java.util.List

interface IProtocol {
	
	def String getName()
	
	def void setName(String name)
	
	def List<IProtocolRole> getRoles()
	
}