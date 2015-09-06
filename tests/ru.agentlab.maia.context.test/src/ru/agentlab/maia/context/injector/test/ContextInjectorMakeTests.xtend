package ru.agentlab.maia.context.injector.test

import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.MaiaInjector

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class ContextInjectorMakeTests {

	@Mock
	IMaiaContext context

	@InjectMocks
	MaiaInjector injector

	@Test
	def void shouldCallEmptyConstructor() {
		val service = injector.make(DummyServiceWithEmptyConstructor)

		verify(service).emptyConstructorCall
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

		verify(service).secondConstructorCall
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

		assertThat(service, notNullValue)
	}

	@Test
	def void shouldCreateServiceByRelevantConstructor() {
		val string = anyString
		when(context.get(String)).thenReturn(string)
		when(context.get(String.name)).thenReturn(string)

		val service = injector.make(DummyServiceWithManyConstructors)

		assertThat(service, notNullValue)
	}

}