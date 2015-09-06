package ru.agentlab.maia.memory.context.arraylist.test

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.test.ContextRemoveByClassAbstractTests
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.arraylist.ListContext

import static org.mockito.Mockito.*

class ListContextRemoveByClassTests extends ContextRemoveByClassAbstractTests {

	@Accessors
	IMaiaContext context = spy(new ListContext)

}