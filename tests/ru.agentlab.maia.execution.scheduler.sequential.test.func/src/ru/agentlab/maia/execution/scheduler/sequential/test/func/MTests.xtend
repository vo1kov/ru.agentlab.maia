package ru.agentlab.maia.execution.scheduler.sequential.test.func

import de.codecentric.jbehave.junit.monitoring.JUnitReportingRunner
import java.io.File
import org.jbehave.core.configuration.Configuration
import org.jbehave.core.configuration.MostUsefulConfiguration
import org.jbehave.core.io.CodeLocations
import org.jbehave.core.io.LoadFromClasspath
import org.jbehave.core.io.StoryFinder
import org.jbehave.core.junit.JUnitStories
import org.jbehave.core.reporters.Format
import org.jbehave.core.reporters.StoryReporterBuilder
import org.jbehave.core.steps.InstanceStepsFactory
import org.junit.runner.RunWith

@RunWith(JUnitReportingRunner)
class MTests extends JUnitStories {

	override stepsFactory() {
		return new InstanceStepsFactory(configuration(), new MySteps());
	}

	override Configuration configuration() {
		return new MostUsefulConfiguration() // where to find the stories
				.useStoryLoader(new LoadFromClasspath(this.getClass()))
		// CONSOLE and TXT reporting
		.useStoryReporterBuilder(
			new StoryReporterBuilder().withDefaultFormats().withFormats(Format.CONSOLE, Format.TXT));
	}

	override protected storyPaths() {
		val StoryFinder finder = new StoryFinder();
		val list = finder.findPaths(
			CodeLocations.codeLocationFromClass(this.getClass()).getFile(),
			"**/*.story",
			""
		);
		println("STORIES LOC: " + CodeLocations.codeLocationFromClass(this.getClass()).getFile())
		println("STORIES LOC: " + CodeLocations.codeLocationFromClass(this.getClass()).path)
		println("STORIES LOC: " + new File(CodeLocations.codeLocationFromClass(this.getClass()).toURI).exists)
		println("STORIES LIST: " + list)
		return list
	}

}