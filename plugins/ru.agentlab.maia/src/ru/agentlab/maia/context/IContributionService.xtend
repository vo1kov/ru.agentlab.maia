package ru.agentlab.maia.context

import org.eclipse.e4.core.contexts.IEclipseContext

interface IContributionService {

	val static String KEY_CONTRIBUTOR = "context.contributor"

	def void addContributor(IEclipseContext context, Class<?> contributorClass)

}