package ru.agentlab.maia.context.e4.test

import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.injector.e4.E4MaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(MockitoJUnitRunner)
class E4ContextTests {

	@Spy
	IMaiaContext context = new E4MaiaContext(EclipseContextFactory.create)

	@Test
	def void shouldHaveUuid() {
		context = new E4MaiaContext(EclipseContextFactory.create)
		assertThat(context.uuid, notNullValue)
	}

}