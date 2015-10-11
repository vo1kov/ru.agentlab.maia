package ru.agentlab.maia.task.sequential.test.blackbox

import de.codecentric.jbehave.junit.monitoring.JUnitReportingRunner
import java.util.Arrays
import org.jbehave.core.configuration.Configuration
import org.jbehave.core.configuration.MostUsefulConfiguration
import org.jbehave.core.io.LoadFromClasspath
import org.jbehave.core.junit.JUnitStories
import org.jbehave.core.reporters.Format
import org.jbehave.core.reporters.StoryReporterBuilder
import org.jbehave.core.steps.InstanceStepsFactory
import org.jbehave.core.steps.ParameterControls
import org.junit.runner.RunWith
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

@RunWith(JUnitReportingRunner)
class MTests extends JUnitStories {

	override stepsFactory() {
		return new InstanceStepsFactory(configuration(), new MySteps[return new SequentialTaskScheduler]);
	}

	override Configuration configuration() {
		return new MostUsefulConfiguration() // where to find the stories
		.useStoryLoader(new LoadFromClasspath(this.getClass())) // CONSOLE and TXT reporting
		.useParameterControls(new ParameterControls().useDelimiterNamedParameters(true)).useStoryReporterBuilder(
			new StoryReporterBuilder().withDefaultFormats().withFormats(Format.CONSOLE, Format.TXT));
	}

	override protected storyPaths() {
		return Arrays.asList(
			"SequentalTaskScheduler_removeSubtask.story",
			"SequentalTaskScheduler_clear.story",
			"ru/agentlab/maia/task/sequential/test/blackbox/SequentalTaskScheduler_execute.story",
			"SequentalTaskScheduler_addSubtask.story"
		)
	}

}