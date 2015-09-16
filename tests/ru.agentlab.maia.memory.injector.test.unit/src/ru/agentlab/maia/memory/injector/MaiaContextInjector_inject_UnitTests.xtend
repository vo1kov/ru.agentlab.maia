package ru.agentlab.maia.memory.injector

import ru.agentlab.maia.memory.IMaiaContext

import static org.mockito.Mockito.*
import org.junit.Test

class MaiaContextInjector_inject_UnitTests {

	val context = mock(IMaiaContext)

	val injector = new MaiaContextInjector(context)
	
	@Test
	def void test(){
//		injector.
	}

}