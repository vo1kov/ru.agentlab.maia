package ru.agentlab.maia.memory.context.test

import org.junit.Before
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext

import static org.mockito.Mockito.*

@RunWith(Parameterized)
abstract class AbstractContext_AbstractFunctionalTests {

	protected IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	@Before
	def void before() {
		context.removeAll
	}

	def protected <T> IMaiaContext addParentWithService(IMaiaContext child, T service) {
		val parent = mock(IMaiaContext)
		when(parent.get(service.class)).thenReturn(service)
		when(parent.get(service.class.name)).thenReturn(service)
		child.parent = parent
		return parent
	}

}