package ru.agentlab.maia.memory.injector.test

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
class ContextInjectorMakeTests {

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
		val string = STRING_VALUE
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)
		val integer = INT_VALUE
		when(context.get(Integer)).thenReturn(integer)
		when(context.get(Integer.name)).thenReturn(integer)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service.firstConstructorCalled, equalTo(false))
		assertThat(service.secondConstructorCalled, equalTo(true))
	}

	@Test
	def void shouldInjectToBiggestConstructor() {
		val string = STRING_VALUE
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)
		val integer = INT_VALUE
		when(context.get(Integer)).thenReturn(integer)
		when(context.get(Integer.name)).thenReturn(integer)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service.stringValue, equalTo(string))
		assertThat(service.intValue, equalTo(integer))
	}

	@Test
	def void shouldCreateServiceByBiggestConstructor() {
		val string = STRING_VALUE
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)
		val intValue = INT_VALUE
		when(context.get(Integer)).thenReturn(intValue)
		when(context.get(Integer.name)).thenReturn(intValue)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service, notNullValue(DummyServiceWithManyConstructors))
	}

	@Test
	def void shouldCallRelevantConstructor() {
		val string = STRING_VALUE
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service.firstConstructorCalled, equalTo(true))
		assertThat(service.secondConstructorCalled, equalTo(false))
	}

	@Test
	def void shouldCreateServiceByRelevantConstructor() {
		val string = STRING_VALUE
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service, notNullValue(DummyServiceWithManyConstructors))
	}

}