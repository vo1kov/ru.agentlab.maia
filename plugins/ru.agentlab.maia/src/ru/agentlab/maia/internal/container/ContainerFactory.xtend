package ru.agentlab.maia.internal.container

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.slf4j.LoggerFactory
import ru.agentlab.maia.container.IContainer
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.container.IContainerIdFactory
import ru.agentlab.maia.container.IContainerNameGenerator
import ru.agentlab.maia.platform.IPlatform

class ContainerFactory implements IContainerFactory {

	val static LOGGER = LoggerFactory.getLogger(ContainerFactory)

	@Inject
	IContainerNameGenerator nameGenerator

	@Inject
	IContainerIdFactory containerIdFactory

	override create(IPlatform platform, String id, Class<?> contributorClass) {
		LOGGER.info("Prepare Container Name...")
		val name = if (id != null) {
				id
			} else {
				nameGenerator.generateName(platform)
			}

		LOGGER.info("Prepare Container Context...")
		val platformContext = platform.context
		val containerContext = platformContext.createChild("Container [" + name + "] Context") => [
			set(IContainer.KEY_NAME, name)
		]

		LOGGER.info("Prepare ContainerID in Context...")
		val containerId = containerIdFactory.create(platform.id, name, null)
		containerContext.set(IContainerId, containerId)

		LOGGER.info("Prepare Container Instance in Context...")
		val container = ContextInjectionFactory.make(Container, containerContext)
		ContextInjectionFactory.invoke(container, PostConstruct, containerContext, null)
		containerContext.set(IContainer, container)

		LOGGER.info("Prepare Container Contributor in Context...")
		if (contributorClass != null) {
			val contributor = ContextInjectionFactory.make(contributorClass, containerContext)
			ContextInjectionFactory.invoke(contributor, PostConstruct, containerContext, null)
			containerContext.set(IContainer.KEY_CONTRIBUTOR, container)
		}

		return container
	}

}