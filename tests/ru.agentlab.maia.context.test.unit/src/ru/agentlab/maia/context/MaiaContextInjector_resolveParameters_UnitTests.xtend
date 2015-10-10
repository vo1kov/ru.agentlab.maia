package ru.agentlab.maia.context

import org.junit.Test
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.Injector

import static org.mockito.Mockito.*

class MaiaContextInjector_resolveParameters_UnitTests {

	val context = mock(IContext)

	val injector = new Injector(context)

	@Test
	def void test() {
	}
}