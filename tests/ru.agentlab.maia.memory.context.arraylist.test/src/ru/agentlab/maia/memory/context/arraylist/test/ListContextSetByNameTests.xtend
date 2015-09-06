package ru.agentlab.maia.memory.context.arraylist.test

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.runner.RunWith
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.test.ContextSetByNameAbstractTests
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.arraylist.ListContext

import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class ListContextSetByNameTests extends ContextSetByNameAbstractTests {

	@Accessors
	IMaiaContext context = spy(new ListContext)

}