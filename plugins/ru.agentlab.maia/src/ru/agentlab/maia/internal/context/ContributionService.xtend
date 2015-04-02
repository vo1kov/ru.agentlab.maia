package ru.agentlab.maia.internal.context

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.di.annotations.Optional
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IContributionService

class ContributionService implements IContributionService {

	val static LOGGER = LoggerFactory.getLogger(ContributionService)

	@Inject @Optional
	IEclipseContext context

	@PostConstruct
	def void init() {
		context.declareModifiable(IContributionService.KEY_CONTRIBUTOR)
	}

	override addContributor(Class<?> contributorClass) {
		if (context == null) {
			throw new IllegalArgumentException(
				"Unknown context, use [createMessageQueue(IEclipseContext ctx)] method instead")
		}
		return context.addContributor(contributorClass)
	}
	
	override addContributor(IEclipseContext ctx, Class<?> contributorClass) {
		LOGGER.info("Create Contributor...")
		if (contributorClass == null) {
			throw new NullPointerException("Contributor class is null")
		}
		val contributor = ContextInjectionFactory.make(contributorClass, ctx)
		LOGGER.debug("	Put [{}]->[{}] to [{}] context...", KEY_CONTRIBUTOR, contributor, ctx)
		ctx.modify(KEY_CONTRIBUTOR, contributor)
		ContextInjectionFactory.invoke(contributor, PostConstruct, ctx, null)
		return contributor
	}

}