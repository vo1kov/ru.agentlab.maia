package ru.agentlab.maia.memory.context.test.blackbox

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.context.IContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(Parameterized)
class AbstractContext_putByString_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IContext context, ServiceRegistration contextServices, ServiceRegistration parentServices) {
		super(context, contextServices, parentServices)
	}

	@Test
	def void getKeySet_increaseSize_whenKeyNoInContext_whenValidArgs() {
		assumeKeyNotInContext
		val before = context.keySet.size

		invokeWithValidArgs

		assertThat(context.keySet.size - before, equalTo(1))
	}

	@Test
	def void getKeySet_increaseSize_whenKeyNoInContext_whenNullService() {
		assumeKeyNotInContext
		val before = context.keySet.size

		invokeWithNullService

		assertThat(context.keySet.size - before, equalTo(1))
	}

	@Test
	def void getKeySet_unchangeSize_whenKeyInContext_whenValidArgs() {
		assumeKeyInContext
		val before = context.keySet.size

		invokeWithValidArgs

		assertThat(context.keySet.size - before, equalTo(0))
	}

	@Test
	def void getKeySet_unchangeSize_whenKeyInContext_whenNullService() {
		assumeKeyInContext
		val before = context.keySet.size

		invokeWithNullService

		assertThat(context.keySet.size - before, equalTo(0))
	}

	@Test
	def void getKeySet_containKey_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.keySet, hasItem(KEY_STRING_VALID))
	}

	@Test
	def void getKeySet_containKey_whenNullService() {
		invokeWithNullService

		assertThat(context.keySet, hasItem(KEY_STRING_VALID))
	}

//	@Test
//	def void getProviderByString_returnNull_whenValidArgs() {
//		invokeWithValidArgs
//
//		assertThat(context.getProvider(KEY_STRING_VALID), nullValue)
//	}
//
//	@Test
//	def void getProviderByString_returnNull_whenNullService() {
//		invokeWithNullService
//
//		assertThat(context.getProvider(KEY_STRING_VALID), nullValue)
//	}
//
//	@Test
//	def void getProviderByClass_returnNull_whenValidArgs() {
//		invokeWithValidArgs
//
//		assertThat(context.getProvider(KEY_CLASS_VALID), nullValue)
//	}
//
//	@Test
//	def void getProviderByClass_returnNull_whenNullService() {
//		invokeWithNullService
//
//		assertThat(context.getProvider(KEY_CLASS_VALID), nullValue)
//	}
//
//	@Test
//	def void getProviderLocalByString_returnNull_whenValidArgs() {
//		invokeWithValidArgs
//
//		assertThat(context.getProviderLocal(KEY_STRING_VALID), nullValue)
//	}
//
//	@Test
//	def void getProviderLocalByString_returnNull_whenNullService() {
//		invokeWithNullService
//
//		assertThat(context.getProviderLocal(KEY_STRING_VALID), nullValue)
//	}
//
//	@Test
//	def void getProviderLocalByClass_returnNull_whenValidArgs() {
//		invokeWithValidArgs
//
//		assertThat(context.getProviderLocal(KEY_CLASS_VALID), nullValue)
//	}
//
//	@Test
//	def void getProviderLocalByClass_returnNull_whenNullService() {
//		invokeWithNullService
//
//		assertThat(context.getProviderLocal(KEY_CLASS_VALID), nullValue)
//	}

	@Test
	def void getServiceByString_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.get(KEY_STRING_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceByString_returnNull_whenNullService() {
		invokeWithNullService

		assertThat(context.get(KEY_STRING_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceByClass_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.get(KEY_CLASS_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceByClass_returnNull_whenNullService() {
		invokeWithNullService

		assertThat(context.get(KEY_CLASS_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceLocalByString_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getLocal(KEY_STRING_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceLocalByString_returnNull_whenNullService() {
		invokeWithNullService

		assertThat(context.getLocal(KEY_STRING_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceLocalByClass_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getLocal(KEY_CLASS_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceLocalByClass_returnNull_whenNullService() {
		invokeWithNullService

		assertThat(context.getLocal(KEY_CLASS_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getUuid_unchangeValue_whenValidArgs() {
		val before = context.uuid

		invokeWithValidArgs

		assertThat(context.uuid, equalTo(before))
	}

	@Test
	def void getUuid_unchangeValue_whenNullService() {
		val before = context.uuid

		invokeWithNullService

		assertThat(context.uuid, equalTo(before))
	}

	@Test
	def void getParent_unchangeValue_whenValidArgs() {
		val before = context.parent

		invokeWithValidArgs

		assertThat(context.parent, equalTo(before))
	}

	@Test
	def void getParent_unchangeValue_whenNullService() {
		val before = context.parent

		invokeWithNullService

		assertThat(context.parent, equalTo(before))
	}

//	@Test
//	def void getChilds_unchangeValue_whenValidArgs() {
//		val before = context.childs
//
//		invokeWithValidArgs
//
//		assertArrayEquals(before, context.childs)
//	}
//
//	@Test
//	def void getChilds_unchangeValue_whenNullService() {
//		val before = context.childs
//
//		invokeWithNullService
//
//		assertArrayEquals(before, context.childs)
//	}
	@Test
	def void self_notInteractWithParent_whenValidArgs() {
		invokeWithValidArgs

		verifyZeroInteractions(parent)
	}

	@Test
	def void self_notInteractWithParent_whenNullService() {
		invokeWithNullService

		verifyZeroInteractions(parent)
	}

	@Test(expected=IllegalArgumentException)
	def void self_throw_whenNullString() {
		invokeWithNullString
	}

	@Test(expected=IllegalArgumentException)
	def void self_throw_whenNullArgs() {
		invokeWithNullArgs
	}

	def private void invokeWithValidArgs() {
		context.put(KEY_STRING_VALID, SERVICE_VALID)
	}

	def private void invokeWithNullService() {
		context.put(KEY_STRING_VALID, SERVICE_NULL)
	}

	def private void invokeWithNullString() {
		context.put(KEY_STRING_NULL, SERVICE_VALID)
	}

	def private void invokeWithNullArgs() {
		context.put(KEY_STRING_NULL, SERVICE_NULL)
	}

}