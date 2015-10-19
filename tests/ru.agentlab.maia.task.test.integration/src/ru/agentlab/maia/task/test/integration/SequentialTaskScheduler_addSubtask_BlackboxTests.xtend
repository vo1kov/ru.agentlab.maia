package ru.agentlab.maia.task.test.integration

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
import org.jbehave.core.steps.ParameterConverters
import org.jbehave.core.steps.ParameterConverters.StringListConverter
import org.junit.runner.RunWith

@RunWith(JUnitReportingRunner)
class SequentialTaskScheduler_addSubtask_BlackboxTests extends JUnitStories {

	override stepsFactory() {
		return new InstanceStepsFactory(
			configuration,
			new Main
		)
	}

	override Configuration configuration() {
		return new MostUsefulConfiguration().useStoryLoader(
			new LoadFromClasspath(this.class)
		).useParameterControls(
			new ParameterControls().useDelimiterNamedParameters(true)
		).useStoryReporterBuilder(
			new StoryReporterBuilder().withDefaultFormats.withFormats(Format.HTML)
		).useParameterConverters(
			new ParameterConverters().addConverters(new StringListConverter)
		)
	}

	override protected storyPaths() {
		return Arrays.asList(
			"ru/agentlab/maia/task/test/integration/ParallelTaskScheduler_withOthers_execute.story",
			"ru/agentlab/maia/task/test/integration/SequentialTaskScheduler_withOthers_execute.story",
			"ru/agentlab/maia/task/test/integration/Sample.story"
		)
	}

}