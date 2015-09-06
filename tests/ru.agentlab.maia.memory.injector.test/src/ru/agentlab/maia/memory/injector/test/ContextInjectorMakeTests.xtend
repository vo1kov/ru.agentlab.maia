package ru.agentlab.maia.memory.injector.test

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
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class ContextInjectorMakeTests {

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
		val string = anyString
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)
		val integer = anyInt
		when(context.get(Integer)).thenReturn(integer)
		when(context.get(Integer.name)).thenReturn(integer)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service.firstConstructorCalled, equalTo(false))
		assertThat(service.secondConstructorCalled, equalTo(true))
	}

	@Test
	def void shouldInjectToBiggestConstructor() {
		val string = anyString
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)
		val integer = anyInt
		when(context.get(Integer)).thenReturn(integer)
		when(context.get(Integer.name)).thenReturn(integer)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service.stringValue, equalTo(string))
		assertThat(service.intValue, equalTo(integer))
	}

	@Test
	def void shouldCreateServiceByBiggestConstructor() {
		val string = anyString
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)
		val integer = anyInt
		when(context.get(Integer)).thenReturn(integer)
		when(context.get(Integer.name)).thenReturn(integer)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service, notNullValue(DummyServiceWithManyConstructors))
	}

	@Test
	def void shouldCallRelevantConstructor() {
		val string = anyString
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service.firstConstructorCalled, equalTo(true))
		assertThat(service.secondConstructorCalled, equalTo(false))
	}

	@Test
	def void shouldCreateServiceByRelevantConstructor() {
		val string = anyString
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service, notNullValue(DummyServiceWithManyConstructors))
	}

}