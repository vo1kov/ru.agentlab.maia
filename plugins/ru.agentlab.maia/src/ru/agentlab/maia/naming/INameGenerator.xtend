package ru.agentlab.maia.naming

import org.eclipse.e4.core.contexts.IEclipseContext

interface INameGenerator {
	
	def String generate(IEclipseContext context)
	
}