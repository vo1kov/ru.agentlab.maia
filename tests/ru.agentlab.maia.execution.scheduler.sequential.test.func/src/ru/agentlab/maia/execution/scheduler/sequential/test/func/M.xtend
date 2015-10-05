package ru.agentlab.maia.execution.scheduler.sequential.test.func

import de.codecentric.jbehave.junit.monitoring.JUnitReportingRunner
import org.jbehave.core.junit.JUnitStories
import org.junit.runner.RunWith

@RunWith(JUnitReportingRunner)
class M extends JUnitStories {

	override protected storyPaths() {
		return #["Sample.story"]
	}

}