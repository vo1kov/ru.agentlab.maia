package ru.agentlab.maia.context.hashmap.test.performance

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.hashmap.HashMapContext
import ru.agentlab.maia.context.test.performance.AbstractContextSetMemoryTests

class HashMapContextSetMemoryTests extends AbstractContextSetMemoryTests {

	@Accessors
	IContext context = new HashMapContext

}