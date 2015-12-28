package ru.agentlab.maia.memory.context.test.blackbox

import javax.inject.Provider
import org.junit.Before
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.memory.context.test.blackbox.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assume.*
import static org.mockito.Mockito.*
import static ru.agentlab.maia.memory.context.test.blackbox.AbstractContext_AbstractFunctionalTests.*
import static ru.agentlab.maia.memory.context.test.blackbox.ServiceRegistration.*

abstract class AbstractContext_AbstractFunctionalTests {

	val protected IContext context

	val protected IContext parent

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

	new(IContext context, ServiceRegistration contextServices, ServiceRegistration parentServices) {
		this.context = context
		this.parent = mock(IContext)
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
				this.context.put(KEY_CLASS_VALID, SERVICE_FAKE)
			}
			case SERVICE_BY_STRING: {
				this.context.put(KEY_STRING_VALID, SERVICE_FAKE)
			}
//			case PROVIDER_BY_CLASS: {
//				this.context.putProvider(KEY_CLASS_VALID, PROVIDER_FAKE)
//			}
//			case PROVIDER_BY_STRING: {
//				this.context.putProvider(KEY_STRING_VALID, PROVIDER_FAKE)
//			}
		}
		switch (parentServices) {
			case NONE: {
			}
			case SERVICE_BY_CLASS: {
				when(parent.get(KEY_CLASS_VALID)).thenReturn(SERVICE_FAKE)
			}
			case SERVICE_BY_STRING: {
				when(parent.get(KEY_STRING_VALID)).thenReturn(SERVICE_FAKE)
			}
			case PROVIDER_BY_CLASS: {
//				when(parent.getProvider(KEY_CLASS_VALID)).thenReturn(PROVIDER_FAKE)
//				when(parent.getProvider(KEY_STRING_VALID)).thenReturn(PROVIDER_FAKE)
				when(parent.get(KEY_CLASS_VALID)).thenReturn(SERVICE_FAKE)
				when(parent.get(KEY_STRING_VALID)).thenReturn(SERVICE_FAKE)
			}
			case PROVIDER_BY_STRING: {
//				when(parent.getProvider(KEY_CLASS_VALID)).thenReturn(PROVIDER_FAKE)
//				when(parent.getProvider(KEY_STRING_VALID)).thenReturn(PROVIDER_FAKE)
				when(parent.get(KEY_CLASS_VALID)).thenReturn(SERVICE_FAKE)
				when(parent.get(KEY_STRING_VALID)).thenReturn(SERVICE_FAKE)
			}
		}
	}

	def protected assumeKeyNotInContext() {
		assumeThat(contextServices, equalTo(NONE))
	}

	def protected assumeKeyInContext() {
		assumeThat(contextServices, anyOf(
			equalTo(SERVICE_BY_CLASS),
			equalTo(PROVIDER_BY_CLASS),
			equalTo(SERVICE_BY_STRING),
			equalTo(PROVIDER_BY_STRING)
		))
	}

	def protected assumeKeyNotInParent() {
		assumeThat(parentServices, equalTo(NONE))
	}

	def protected assumeKeyInParent() {
		assumeThat(parentServices, anyOf(
			equalTo(SERVICE_BY_CLASS),
			equalTo(PROVIDER_BY_CLASS),
			equalTo(SERVICE_BY_STRING),
			equalTo(PROVIDER_BY_STRING)
		))
	}

}