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
import ru.agentlab.maia.task.test.blackbox.AbstractTaskSchedulerAddSubtaskSteps
import ru.agentlab.maia.task.test.blackbox.AbstractTaskSchedulerBaseSteps
import ru.agentlab.maia.task.test.blackbox.AbstractTaskSchedulerClearSteps
import ru.agentlab.maia.task.test.blackbox.AbstractTaskSchedulerExecuteSteps
import ru.agentlab.maia.task.test.blackbox.AbstractTaskSchedulerRemoveSubtaskSteps
import ru.agentlab.maia.task.test.blackbox.TaskSchedulerStorage

@RunWith(JUnitReportingRunner)
class SequentialTaskScheduler_BlackboxTests extends JUnitStories {

	override stepsFactory() {
		val storage = new TaskSchedulerStorage
		return new InstanceStepsFactory(
			configuration,
			new AbstractTaskSchedulerBaseSteps(storage, [return new SequentialTaskScheduler]),
			new AbstractTaskSchedulerAddSubtaskSteps(storage),
			new AbstractTaskSchedulerRemoveSubtaskSteps(storage),
			new AbstractTaskSchedulerClearSteps(storage),
			new AbstractTaskSchedulerExecuteSteps(storage)
		)
	}

	override Configuration configuration() {
		return new MostUsefulConfiguration().useStoryLoader(
			new LoadFromClasspath(this.class)
		).useParameterControls(
			new ParameterControls().useDelimiterNamedParameters(true)
		).useStoryReporterBuilder(
			new StoryReporterBuilder().withDefaultFormats.withFormats(Format.CONSOLE, Format.TXT, Format.HTML)
		)
	}

	override protected storyPaths() {
		return Arrays.asList(
			"ru/agentlab/maia/task/test/blackbox/TaskScheduler_addSubtask.story",
			"ru/agentlab/maia/task/test/blackbox/TaskScheduler_clear.story",
			"ru/agentlab/maia/task/test/blackbox/TaskScheduler_removeSubtask.story",
			"ru/agentlab/maia/task/sequential/test/blackbox/SequentalTaskScheduler_execute.story"
		)
	}

}