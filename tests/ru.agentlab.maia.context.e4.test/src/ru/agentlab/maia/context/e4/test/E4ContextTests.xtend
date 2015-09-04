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
import ru.agentlab.maia.context.injector.e4.E4MaiaContextFactory

@RunWith(MockitoJUnitRunner)
class E4ContextTests {

	@Spy
	IMaiaContext context = new E4MaiaContext(EclipseContextFactory.create)

	@Test
	def void shouldHaveUuid() {
		context = new E4MaiaContext(EclipseContextFactory.create)
		
		val uuid = context.uuid
		
		assertThat(uuid, notNullValue)
	}
	
	@Test
	def void shouldReturnParent(){
		val parent  = new E4MaiaContext(EclipseContextFactory.create)
		val contextFactory = new E4MaiaContextFactory(parent)
		
		val child = contextFactory.createContext
		
		assertThat(child.parent, equalTo(parent))
	}

}