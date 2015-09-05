package ru.agentlab.maia.context.e4.test

import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.injector.e4.E4MaiaContext
import ru.agentlab.maia.context.test.AbstractContextGetKeySetTests

import static org.mockito.Mockito.*

class E4ContextGetKeySetTests extends AbstractContextGetKeySetTests {

	@Accessors
	IMaiaContext context = spy(new E4MaiaContext(EclipseContextFactory.create))

}