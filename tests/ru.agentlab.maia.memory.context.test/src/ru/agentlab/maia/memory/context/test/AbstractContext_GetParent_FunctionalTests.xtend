package ru.agentlab.maia.memory.context.test

import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(Parameterized)
class AbstractContext_GetParent_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context) {
		super(context)
	}
	
	@Test
	def void shouldReturnNull() {
		val parent = context.parent

		assertThat(parent, nullValue)
	}

	@Test @Ignore
	def void shouldReturnParent() {
		val parentCtx = mock(IMaiaContext)

		val parent = context.parent

		assertThat(parent, equalTo(parentCtx))
	}

}