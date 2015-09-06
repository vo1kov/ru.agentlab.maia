package ru.agentlab.maia.memory.context.hashmap.test

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.test.ContextRemoveByClassAbstractTests
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.hashmap.HashMapContext

import static org.mockito.Mockito.*

class HashMapContextRemoveByClassTests extends ContextRemoveByClassAbstractTests {

	@Accessors
	IMaiaContext context = spy(new HashMapContext)

}