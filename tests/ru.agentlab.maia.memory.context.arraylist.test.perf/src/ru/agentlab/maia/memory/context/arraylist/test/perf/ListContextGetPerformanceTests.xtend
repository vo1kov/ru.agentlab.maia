package ru.agentlab.maia.memory.context.arraylist.test.perf

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.test.perf.AbstractContextSetPerformanceTests

import static org.mockito.Mockito.*
import ru.agentlab.maia.memory.context.arraylist.ArrayListContext

class ListContextGetPerformanceTests extends AbstractContextSetPerformanceTests {

	@Accessors
	IMaiaContext context = spy(new ArrayListContext)

}