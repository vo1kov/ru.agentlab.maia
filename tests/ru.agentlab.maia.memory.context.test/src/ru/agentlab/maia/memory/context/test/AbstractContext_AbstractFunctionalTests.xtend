package ru.agentlab.maia.memory.context.test

import javax.inject.Provider
import org.junit.Before
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.doubles.DummyService

import static org.mockito.Mockito.*
import static org.junit.Assume.*
import static org.hamcrest.Matchers.*
import static ru.agentlab.maia.memory.context.test.AbstractContext_AbstractFunctionalTests.*
import static ru.agentlab.maia.memory.context.test.ServiceRegistration.*

abstract class AbstractContext_AbstractFunctionalTests {

	val protected IMaiaContext context

	val protected IMaiaContext parent

	val protected static KEY_STRING_NULL = null as String

	val protected static KEY_STRING_VALID = DummyService.name

	val protected static KEY_CLASS_NULL = null as Class<DummyService>

	val protected static KEY_CLASS_VALID = DummyService

	val protected static SERVICE_NULL = null as DummyService

	val protected static SERVICE_VALID = new DummyService

	val protected static SERVICE_FAKE = new DummyService

	val protected static PROVIDER_NULL = null as Provider<DummyService>

	val protected static Provider<DummyService> PROVIDER_VALID = new Provider<DummyService> {
		override get() {
			return SERVICE_VALID
		}
	}

	val protected static Provider<DummyService> PROVIDER_FAKE = new Provider<DummyService> {
		override get() {
			return SERVICE_FAKE
		}
	}

	protected ServiceRegistration contextServices

	protected ServiceRegistration parentServices

	new(IMaiaContext context, ServiceRegistration contextServices, ServiceRegistration parentServices) {
		this.context = context
		this.parent = mock(IMaiaContext)
		this.context.parent = parent
		this.contextServices = contextServices
		this.parentServices = parentServices
	}

	@Before
	def void before() {
		context.clear
		reset(parent)
		switch (contextServices) {
			case NONE: {
			}
			case SERVICE_BY_CLASS: {
				this.context.putService(KEY_CLASS_VALID, SERVICE_FAKE)
			}
			case SERVICE_BY_STRING: {
				this.context.putService(KEY_STRING_VALID, SERVICE_FAKE)
			}
			case PROVIDER_BY_CLASS: {
				this.context.putProvider(KEY_CLASS_VALID, PROVIDER_FAKE)
			}
			case PROVIDER_BY_STRING: {
				this.context.putProvider(KEY_STRING_VALID, PROVIDER_FAKE)
			}
		}
		switch (parentServices) {
			case NONE: {
			}
			case SERVICE_BY_CLASS: {
				when(parent.getService(KEY_CLASS_VALID)).thenReturn(SERVICE_FAKE)
			}
			case SERVICE_BY_STRING: {
				when(parent.getService(KEY_STRING_VALID)).thenReturn(SERVICE_FAKE)
			}
			case PROVIDER_BY_CLASS: {
				when(parent.getProvider(KEY_CLASS_VALID)).thenReturn(PROVIDER_FAKE)
				when(parent.getProvider(KEY_STRING_VALID)).thenReturn(PROVIDER_FAKE)
				when(parent.getService(KEY_CLASS_VALID)).thenReturn(SERVICE_FAKE)
				when(parent.getService(KEY_STRING_VALID)).thenReturn(SERVICE_FAKE)
			}
			case PROVIDER_BY_STRING: {
				when(parent.getProvider(KEY_CLASS_VALID)).thenReturn(PROVIDER_FAKE)
				when(parent.getProvider(KEY_STRING_VALID)).thenReturn(PROVIDER_FAKE)
				when(parent.getService(KEY_CLASS_VALID)).thenReturn(SERVICE_FAKE)
				when(parent.getService(KEY_STRING_VALID)).thenReturn(SERVICE_FAKE)
			}
		}
	}
	

	def protected assumeKeyNotInContext() {
		assumeThat(contextServices, anyOf(
			equalTo(NONE)
		))
	}

	def protected assumeKeyInContext() {
		assumeThat(contextServices, anyOf(
			equalTo(SERVICE_BY_CLASS),
			equalTo(PROVIDER_BY_CLASS),
			equalTo(SERVICE_BY_STRING),
			equalTo(PROVIDER_BY_STRING)
		))
	}

}