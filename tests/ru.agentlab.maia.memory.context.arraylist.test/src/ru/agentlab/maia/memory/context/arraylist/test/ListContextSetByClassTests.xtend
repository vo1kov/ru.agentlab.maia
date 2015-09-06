package ru.agentlab.maia.memory.context.arraylist.test

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.runner.RunWith
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.test.ContextSetByClassAbstractTests
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.arraylist.ListContext

import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class ListContextSetByClassTests extends ContextSetByClassAbstractTests {

	@Accessors
	IMaiaContext context = spy(new ListContext)

}