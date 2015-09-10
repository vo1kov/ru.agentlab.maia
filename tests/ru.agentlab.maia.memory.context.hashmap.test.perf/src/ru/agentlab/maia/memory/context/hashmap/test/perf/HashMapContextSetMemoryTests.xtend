package ru.agentlab.maia.memory.context.hashmap.test.perf

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.hashmap.HashMapContext
import ru.agentlab.maia.memory.context.test.perf.AbstractContextSetMemoryTests

class HashMapContextSetMemoryTests extends AbstractContextSetMemoryTests {

	@Accessors
	IMaiaContext context = new HashMapContext

}