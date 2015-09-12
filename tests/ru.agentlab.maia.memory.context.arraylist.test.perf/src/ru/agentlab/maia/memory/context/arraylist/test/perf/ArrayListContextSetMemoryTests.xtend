package ru.agentlab.maia.memory.context.arraylist.test.perf

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.test.perf.AbstractContextSetMemoryTests
import ru.agentlab.maia.memory.context.arraylist.ArrayListContext

class ArrayListContextSetMemoryTests extends AbstractContextSetMemoryTests {

	@Accessors
	IMaiaContext context = new ArrayListContext

}