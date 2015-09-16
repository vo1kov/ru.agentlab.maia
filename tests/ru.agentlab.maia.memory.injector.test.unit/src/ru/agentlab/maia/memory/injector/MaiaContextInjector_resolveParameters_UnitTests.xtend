package ru.agentlab.maia.memory.injector

import org.junit.Test
import ru.agentlab.maia.memory.IMaiaContext

import static org.mockito.Mockito.*

class MaiaContextInjector_resolveParameters_UnitTests {

	val context = mock(IMaiaContext)

	val injector = new MaiaContextInjector(context)

	@Test
	def void test() {
	}
}