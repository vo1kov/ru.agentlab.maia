package ru.agentlab.maia.memory.context.arraylist.test

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.test.ContextGetKeySetAbstractTests
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.arraylist.ListContext

import static org.mockito.Mockito.*

class ListContextGetKeySetTests extends ContextGetKeySetAbstractTests {

	@Accessors
	IMaiaContext context = spy(new ListContext)

}