package ru.agentlab.maia.memory.context.arraylist.test

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.test.ContextRemoveByNameAbstractTests
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.arraylist.ListContext

import static org.mockito.Mockito.*

class ListContextRemoveByNameTests extends ContextRemoveByNameAbstractTests {

	@Accessors
	IMaiaContext context = spy(new ListContext)

}