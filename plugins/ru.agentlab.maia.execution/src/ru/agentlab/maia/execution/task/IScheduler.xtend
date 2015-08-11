package ru.agentlab.maia.execution.task

import java.util.List

interface IScheduler extends INode {

	def INode getNext()
	
	def List<Link> getLinks()

}