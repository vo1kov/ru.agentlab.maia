package ru.agentlab.maia.memory.context.hashmap.test.perf

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.hashmap.HashMapContext
import ru.agentlab.maia.memory.context.test.perf.AbstractContextSetMemoryTests

class HashMapContextSetMemoryTests extends AbstractContextSetMemoryTests {

	@Accessors
	IContext context = new HashMapContext

}