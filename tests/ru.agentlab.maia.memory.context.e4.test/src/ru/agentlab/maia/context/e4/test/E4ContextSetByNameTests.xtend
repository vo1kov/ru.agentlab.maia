package ru.agentlab.maia.context.e4.test

import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.runner.RunWith
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.injector.e4.E4MaiaContext
import ru.agentlab.maia.context.test.ContextSetByNameAbstractTests
import ru.agentlab.maia.memory.IMaiaContext

import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class E4ContextSetByNameTests extends ContextSetByNameAbstractTests {

	@Accessors
	IMaiaContext context = spy(new E4MaiaContext(EclipseContextFactory.create))

}