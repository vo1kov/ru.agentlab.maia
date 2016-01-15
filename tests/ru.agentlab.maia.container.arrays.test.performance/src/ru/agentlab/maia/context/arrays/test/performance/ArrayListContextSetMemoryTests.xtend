package ru.agentlab.maia.context.arrays.test.performance

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.arrays.ArrayContext
import ru.agentlab.maia.context.test.performance.AbstractContextSetMemoryTests

class ArrayListContextSetMemoryTests extends AbstractContextSetMemoryTests {

	@Accessors
	IContext context = new ArrayContext

}