package ru.agentlab.maia.execution.scheduler.sequential.test.func

import java.util.ArrayList
import ru.agentlab.maia.execution.IExecutionNode

import static org.mockito.Mockito.*

class SequenceSchedulerTestsExtension {

	def ArrayList<IExecutionNode> getFakeChilds(int size) {
		val childs = new ArrayList<IExecutionNode>
		for (i : 0 ..< size) {
			val action = mock(IExecutionNode)
			childs += action
		}
		return childs
	}

}