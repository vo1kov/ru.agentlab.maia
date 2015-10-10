package ru.agentlab.maia.memory.context.arraylist.test.perf

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.arrays.ArrayContext
import ru.agentlab.maia.memory.context.test.perf.AbstractContextSetMemoryTests

class ArrayListContextSetMemoryTests extends AbstractContextSetMemoryTests {

	@Accessors
	IContext context = new ArrayContext

}