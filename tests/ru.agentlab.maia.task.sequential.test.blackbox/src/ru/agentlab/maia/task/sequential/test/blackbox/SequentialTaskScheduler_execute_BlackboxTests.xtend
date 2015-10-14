package ru.agentlab.maia.task.sequential.test.blackbox

import de.codecentric.jbehave.junit.monitoring.JUnitReportingRunner
import java.util.Arrays
import javax.inject.Provider
import org.jbehave.core.configuration.Configuration
import org.jbehave.core.configuration.MostUsefulConfiguration
import org.jbehave.core.io.LoadFromClasspath
import org.jbehave.core.junit.JUnitStories
import org.jbehave.core.reporters.Format
import org.jbehave.core.reporters.StoryReporterBuilder
import org.jbehave.core.steps.InstanceStepsFactory
import org.jbehave.core.steps.ParameterControls
import org.junit.runner.RunWith
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler
import ru.agentlab.maia.task.sequential.test.blackbox.step.SequentialTaskScheduler_execute_Steps

@RunWith(JUnitReportingRunner)
class SequentialTaskScheduler_execute_BlackboxTests extends JUnitStories {

	override stepsFactory() {
		val Provider<ITaskScheduler> provider = [
			return new SequentialTaskScheduler
		]
		return new InstanceStepsFactory(
			configuration,
			new SequentialTaskScheduler_execute_Steps(provider)
		)
	}

	override Configuration configuration() {
		return new MostUsefulConfiguration().useStoryLoader(
			new LoadFromClasspath(SequentialTaskScheduler_execute_Steps)
		).useParameterControls(
			new ParameterControls().useDelimiterNamedParameters(true)
		).useStoryReporterBuilder(
			new StoryReporterBuilder().withDefaultFormats.withFormats(Format.CONSOLE, Format.TXT)
		)
	}

	override protected storyPaths() {
		return Arrays.asList(
//			"ru/agentlab/maia/task/test/blackbox/TaskScheduler_removeSubtask.story",
//			"ru/agentlab/maia/task/test/blackbox/TaskScheduler_clear.story",
//			"ru/agentlab/maia/task/test/blackbox/TaskScheduler_addSubtask.story",
//			"ru/agentlab/maia/task/test/blackbox/SequentalTaskScheduler_removeSubtask.story",
//			"ru/agentlab/maia/task/test/blackbox/SequentalTaskScheduler_clear.story",
//			"ru/agentlab/maia/task/test/blackbox/SequentalTaskScheduler_addSubtask.story",
			"ru/agentlab/maia/task/sequential/test/blackbox/SequentalTaskScheduler_execute.story"
		)
	}

}