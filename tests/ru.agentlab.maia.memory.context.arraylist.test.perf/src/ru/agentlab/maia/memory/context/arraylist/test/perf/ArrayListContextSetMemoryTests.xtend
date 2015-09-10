package ru.agentlab.maia.memory.context.arraylist.test.perf

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.arraylist.ListContext
import ru.agentlab.maia.memory.context.test.perf.AbstractContextSetMemoryTests

import static org.mockito.Mockito.*

class ArrayListContextSetMemoryTests extends AbstractContextSetMemoryTests {

	@Accessors
	IMaiaContext context = new ListContext

}