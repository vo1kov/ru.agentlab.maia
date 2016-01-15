package ru.agentlab.maia.context.arrays.test.performance

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.arrays.ArrayContext
import ru.agentlab.maia.context.test.performance.AbstractContextSetPerformanceTests

import static org.mockito.Mockito.*

class ListContextGetPerformanceTests extends AbstractContextSetPerformanceTests {

	@Accessors
	IContext context = spy(new ArrayContext)

}