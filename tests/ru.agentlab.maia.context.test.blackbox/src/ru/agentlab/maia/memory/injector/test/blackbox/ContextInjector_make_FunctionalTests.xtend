package ru.agentlab.maia.memory.injector.test.blackbox

import java.util.Random
import java.util.UUID
import org.junit.Before
import org.junit.Test
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.IInjector
import ru.agentlab.maia.context.Injector
import ru.agentlab.maia.context.exception.MaiaContextKeyNotFound
import ru.agentlab.maia.memory.injector.test.blackbox.doubles.FakeService_constructorsEmpty
import ru.agentlab.maia.memory.injector.test.blackbox.doubles.FakeService_constructorsMany

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class ContextInjector_make_FunctionalTests {

	val static random = new Random

	val static INT_VALUE = random.nextInt

	val static STRING_VALUE = UUID.randomUUID.toString

	IContext context = mock(IContext)

	IInjector injector = new Injector(context)

	@Before
	def void before() {
		reset(context)
	}

	@Test
	def void shouldCallEmptyConstructor() {
		val service = injector.make(FakeService_constructorsEmpty)

		assertThat(service.constructorCalled, equalTo(true))
	}

	@Test
	def void shouldCreateServiceWithEmptyConstructor() {
		val service = injector.make(FakeService_constructorsEmpty)

		assertThat(service, notNullValue(FakeService_constructorsEmpty))
	}

	@Test
	def void shouldCallBiggestConstructor() {
		when(context.get(String)).thenReturn(STRING_VALUE)
		when(context.get(Integer)).thenReturn(INT_VALUE)

		val service = injector.make(FakeService_constructorsMany)

		assertThat(service.firstConstructorCalled, equalTo(false))
		assertThat(service.secondConstructorCalled, equalTo(true))
	}

	@Test
	def void shouldInjectToBiggestConstructor() {
		when(context.get(String)).thenReturn(STRING_VALUE)
		when(context.get(Integer)).thenReturn(INT_VALUE)

		val service = injector.make(FakeService_constructorsMany)

		assertThat(service.stringValue, equalTo(STRING_VALUE))
		assertThat(service.intValue, equalTo(INT_VALUE))
	}

	@Test
	def void shouldCreateServiceByBiggestConstructor() {
		when(context.get(String)).thenReturn(STRING_VALUE)
		when(context.get(Integer)).thenReturn(INT_VALUE)

		val service = injector.make(FakeService_constructorsMany)

		assertThat(service, notNullValue(FakeService_constructorsMany))
	}

	@Test
	def void shouldCallRelevantConstructor() {
		when(context.get(String)).thenReturn(STRING_VALUE)
		when(context.get(Integer)).thenThrow(MaiaContextKeyNotFound)

		val service = injector.make(FakeService_constructorsMany)

		assertThat(service.firstConstructorCalled, equalTo(true))
		assertThat(service.secondConstructorCalled, equalTo(false))
	}

	@Test
	def void shouldCreateServiceByRelevantConstructor() {
		when(context.get(String)).thenReturn(STRING_VALUE)
		when(context.get(Integer)).thenThrow(MaiaContextKeyNotFound)

		val service = injector.make(FakeService_constructorsMany)

		assertThat(service, notNullValue(FakeService_constructorsMany))
	}

}