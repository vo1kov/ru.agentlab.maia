package ru.agentlab.maia.context.hashmap.test.performance

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.IContainer
import ru.agentlab.maia.container.hashmap.HashMapContext
import ru.agentlab.maia.context.test.performance.AbstractContextSetMemoryTests

class HashMapContextSetMemoryTests extends AbstractContextSetMemoryTests {

	@Accessors
	IContainer context = new HashMapContext

}
