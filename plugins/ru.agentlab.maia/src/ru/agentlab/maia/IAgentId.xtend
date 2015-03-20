package ru.agentlab.maia

import java.util.List
import java.util.Properties

interface IAgentId {

	def String getPlatformID()

	def void setPlatformID(String platformID)

	def String getName()

	def void setName(String name)

	def List<String> getAddresses()

	def void setAddresses(List<String> addresses)

	def List<IAgentId> getResolvers()

	def void setResolvers(List<IAgentId> resolvers)

	def Properties getUserDefSlots()

	def void setUserDefSlots(Properties userDefSlots)

}