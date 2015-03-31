package ru.agentlab.maia.internal.context

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IContributionService

class ContributionService implements IContributionService {

	val static LOGGER = LoggerFactory.getLogger(ContributionService)

	@Inject
	IEclipseContext context

	@PostConstruct
	def void init() {
		context.declareModifiable(IContributionService.KEY_CONTRIBUTOR)
	}

	override void addContributor(Class<?> contributorClass) {
		if (contributorClass != null) {
			LOGGER.info("Create Contributor...")
			val contributor = ContextInjectionFactory.make(contributorClass, context)
			LOGGER.debug("	Put [{}]->[{}] to [{}] context...", KEY_CONTRIBUTOR, contributor, context)
			context.modify(KEY_CONTRIBUTOR, contributor)
			ContextInjectionFactory.invoke(contributor, PostConstruct, context, null)
		} else {
			LOGGER.info("Contributor class is empty...")
		}
	}

}