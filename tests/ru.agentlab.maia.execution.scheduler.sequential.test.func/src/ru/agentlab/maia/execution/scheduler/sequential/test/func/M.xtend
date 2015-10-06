package ru.agentlab.maia.execution.scheduler.sequential.test.func

import de.codecentric.jbehave.junit.monitoring.JUnitReportingRunner
import java.util.Arrays
import org.jbehave.core.io.CodeLocations
import org.jbehave.core.io.StoryFinder
import org.jbehave.core.junit.JUnitStories
import org.junit.runner.RunWith

@RunWith(JUnitReportingRunner)
class M extends JUnitStories {
	override protected storyPaths() {
		val StoryFinder finder = new StoryFinder();
		return finder.findPaths(CodeLocations.codeLocationFromClass(this.getClass()).getFile(),
			Arrays.asList("**/*.story"), Arrays.asList(""));
	}

}