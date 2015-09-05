package ru.agentlab.maia.context.e4.test

import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.injector.e4.E4MaiaContext
import ru.agentlab.maia.context.injector.e4.E4MaiaContextFactory
import ru.agentlab.maia.context.test.AbstractContextTests

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class E4ContextTests extends AbstractContextTests {

	IMaiaContext context = spy(new E4MaiaContext(EclipseContextFactory.create))

	@Test @Ignore
	def void shouldReturnParent() {
		val parent = new E4MaiaContext(EclipseContextFactory.create)
		val contextFactory = new E4MaiaContextFactory(parent)

		val child = contextFactory.createContext

		assertThat(child.parent, equalTo(parent))
	}

	override getContext() {
		return context
	}

}