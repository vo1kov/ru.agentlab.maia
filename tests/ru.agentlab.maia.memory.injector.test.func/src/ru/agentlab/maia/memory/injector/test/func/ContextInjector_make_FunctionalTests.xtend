package ru.agentlab.maia.memory.injector.test.func

import java.util.Random
import java.util.UUID
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.doubles.constructors.DummyServiceWithEmptyConstructor
import ru.agentlab.maia.memory.doubles.constructors.DummyServiceWithManyConstructors
import ru.agentlab.maia.memory.injector.MaiaContextInjector

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class ContextInjector_make_FunctionalTests {

	val static random = new Random

	val static INT_VALUE = random.nextInt

	val static STRING_VALUE = UUID.randomUUID.toString

	@Mock
	IMaiaContext context

	@Spy @InjectMocks
	MaiaContextInjector injector

	@Test
	def void shouldCallEmptyConstructor() {
		val service = injector.make(DummyServiceWithEmptyConstructor)

		assertThat(service.constructorCalled, equalTo(true))
	}

	@Test
	def void shouldCreateServiceWithEmptyConstructor() {
		val service = injector.make(DummyServiceWithEmptyConstructor)

		assertThat(service, notNullValue(DummyServiceWithEmptyConstructor))
	}

	@Test
	def void shouldCallBiggestConstructor() {
		context.addService(STRING_VALUE)
		context.addService(INT_VALUE)
		
		
		assertThat(context.getService(Integer), equalTo(INT_VALUE))
		assertThat(injector.context, equalTo(context))

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service.firstConstructorCalled, equalTo(false))
		assertThat(service.secondConstructorCalled, equalTo(true))
	}

	@Test
	def void shouldInjectToBiggestConstructor() {
		context.addService(STRING_VALUE)
		context.addService(INT_VALUE)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service.stringValue, equalTo(STRING_VALUE))
		assertThat(service.intValue, equalTo(INT_VALUE))
	}

	@Test
	def void shouldCreateServiceByBiggestConstructor() {
		context.addService(STRING_VALUE)
		context.addService(INT_VALUE)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service, notNullValue(DummyServiceWithManyConstructors))
	}

	@Test
	def void shouldCallRelevantConstructor() {
		context.addService(STRING_VALUE)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service.firstConstructorCalled, equalTo(true))
		assertThat(service.secondConstructorCalled, equalTo(false))
	}

	@Test
	def void shouldCreateServiceByRelevantConstructor() {
		context.addService(STRING_VALUE)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service, notNullValue(DummyServiceWithManyConstructors))
	}
	
	def private void addService(IMaiaContext ctx, Object service){
		when(ctx.getService(service.class)).thenReturn(service)
		when(ctx.getService(service.class.name)).thenReturn(service)
		when(ctx.contains(service.class.name)).thenReturn(ctx)
		when(ctx.contains(service.class)).thenReturn(ctx)
	} 

}