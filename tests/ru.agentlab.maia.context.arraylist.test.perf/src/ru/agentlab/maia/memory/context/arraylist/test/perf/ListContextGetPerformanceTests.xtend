package ru.agentlab.maia.memory.context.arraylist.test.perf

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.arrays.ArrayContext
import ru.agentlab.maia.memory.context.test.perf.AbstractContextSetPerformanceTests

import static org.mockito.Mockito.*

class ListContextGetPerformanceTests extends AbstractContextSetPerformanceTests {

	@Accessors
	IContext context = spy(new ArrayContext)

}