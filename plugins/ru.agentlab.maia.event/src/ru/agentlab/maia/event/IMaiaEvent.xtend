package ru.agentlab.maia.event

import java.util.Map

interface IMaiaEvent {

	def String getTopic()

	def Map<String, Object> getData()

}