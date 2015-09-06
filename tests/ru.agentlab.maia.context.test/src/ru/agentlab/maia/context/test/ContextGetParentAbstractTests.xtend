package ru.agentlab.maia.context.test

import org.junit.Ignore
import org.junit.Test
import ru.agentlab.maia.context.IMaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

abstract class ContextGetParentAbstractTests extends ContextAbstractTests {

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