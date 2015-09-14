package ru.agentlab.maia.memory.context.test

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.junit.Assume.*
import static org.mockito.Mockito.*
import static ru.agentlab.maia.memory.context.test.ServiceRegistration.*
import java.util.UUID

@RunWith(Parameterized)
class AbstractContext_removeByClass_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context, ServiceRegistration contextServices, ServiceRegistration parentServices) {
		super(context, contextServices, parentServices)
	}

	@Test
	def void getKeySet_unchangeSize_whenKeyNoInContext_whenValidArgs() {
		assumeKeyNotInContext
		val before = context.keySet.size

		invokeWithValidArgs

		assertThat(context.keySet.size, equalTo(before))
	}

	@Test
	def void getKeySet_unchangeSize_whenKeyNoInContext_whenUnknownArgs() {
		assumeKeyNotInContext
		val before = context.keySet.size

		invokeWithUnknownArgs

		assertThat(context.keySet.size, equalTo(before))
	}

	@Test
	def void getKeySet_unchangeSize_whenKeyInContext_whenUnknownArgs() {
		assumeKeyInContext
		val before = context.keySet.size

		invokeWithUnknownArgs

		assertThat(context.keySet.size, equalTo(before))
	}

	@Test
	def void getKeySet_decreaseSize_whenKeyInContext_whenValidArgs() {
		assumeKeyInContext
		val before = context.keySet.size

		invokeWithValidArgs

		assertThat(context.keySet.size - before, equalTo(-1))
	}

	@Test
	def void getKeySet_containKey_whenKeyInContext_whenUnknownArgs() {
		assumeKeyInContext
		
		invokeWithUnknownArgs

		assertThat(context.keySet, hasItem(KEY_STRING_VALID))
	}

	@Test
	def void getKeySet_notContainKey_whenKeyInContext_whenValidArgs() {
		assumeKeyInContext
		
		invokeWithValidArgs

		assertThat(context.keySet, not(hasItem(KEY_STRING_VALID)))
	}

	@Test
	def void getKeySet_notContainKey_whenKeyNoInContext_whenValidArgs() {
		assumeKeyNotInContext
		
		invokeWithValidArgs

		assertThat(context.keySet, not(hasItem(KEY_STRING_VALID)))
	}

	@Test
	def void getKeySet_notContainKey_whenKeyNoInContext_whenUnknownArgs() {
		assumeKeyNotInContext
		
		invokeWithUnknownArgs

		assertThat(context.keySet, not(hasItem(KEY_STRING_VALID)))
	}

	@Test
	def void getProviderByString_returnNull_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProvider(KEY_STRING_VALID), nullValue)
	}

	@Test
	def void getProviderByString_returnNull_whenUnknownArgs() {
		invokeWithUnknownArgs

		assertThat(context.getProvider(KEY_STRING_VALID), nullValue)
	}

	@Test
	def void getProviderByClass_returnNull_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProvider(KEY_CLASS_VALID), nullValue)
	}

	@Test
	def void getProviderByClass_returnNull_whenUnknownArgs() {
		invokeWithUnknownArgs

		assertThat(context.getProvider(KEY_CLASS_VALID), nullValue)
	}

	@Test
	def void getServiceByString_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getService(KEY_STRING_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceByString_returnNull_whenUnknownArgs() {
		invokeWithUnknownArgs

		assertThat(context.getService(KEY_STRING_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceByClass_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getService(KEY_CLASS_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceByClass_returnNull_whenUnknownArgs() {
		invokeWithUnknownArgs

		assertThat(context.getService(KEY_CLASS_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getUuid_unchangeValue_whenValidArgs() {
		val before = context.uuid

		invokeWithValidArgs

		assertThat(context.uuid, equalTo(before))
	}

	@Test
	def void getUuid_unchangeValue_whenUnknownArgs() {
		val before = context.uuid

		invokeWithUnknownArgs

		assertThat(context.uuid, equalTo(before))
	}

	@Test
	def void getParent_unchangeValue_whenValidArgs() {
		val before = context.parent

		invokeWithValidArgs

		assertThat(context.parent, equalTo(before))
	}

	@Test
	def void getParent_unchangeValue_whenUnknownArgs() {
		val before = context.parent

		invokeWithUnknownArgs

		assertThat(context.parent, equalTo(before))
	}

	@Test
	def void getChilds_unchangeValue_whenValidArgs() {
		val before = context.childs

		invokeWithValidArgs

		assertArrayEquals(before, context.childs)
	}

	@Test
	def void getChilds_unchangeValue_whenUnknownArgs() {
		val before = context.childs

		invokeWithUnknownArgs

		assertArrayEquals(before, context.childs)
	}

	@Test
	def void self_notInteractWithParent_whenValidArgs() {
		invokeWithValidArgs

		verifyZeroInteractions(parent)
	}

	@Test
	def void self_notInteractWithParent_whenUnknownArgs() {
		invokeWithUnknownArgs

		verifyZeroInteractions(parent)
	}

	@Test(expected=NullPointerException)
	def void self_throw_whenNullArgs() {
		invokeWithNullArgs
	}
	
	def private assumeByClassNoInContext(){
		assumeThat(contextServices, anyOf(
			equalTo(NONE),
			equalTo(SERVICE_BY_STRING),
			equalTo(PROVIDER_BY_STRING)
		))
	}
	
	def private assumeByClassInContext(){
		assumeThat(contextServices, anyOf(
			equalTo(SERVICE_BY_CLASS),
			equalTo(PROVIDER_BY_CLASS)
		))
	}
	
	def private assumeKeyNotInContext(){
		assumeThat(contextServices, anyOf(
			equalTo(NONE)
		))
	}
	
	def private assumeKeyInContext(){
		assumeThat(contextServices, anyOf(
			equalTo(SERVICE_BY_CLASS),
			equalTo(PROVIDER_BY_CLASS),
			equalTo(SERVICE_BY_STRING),
			equalTo(PROVIDER_BY_STRING)
		))
	}

	def private void invokeWithValidArgs() {
		context.remove(KEY_STRING_VALID)
	}

	def private void invokeWithUnknownArgs() {
		context.remove(UUID.randomUUID.toString)
	}

	def private void invokeWithNullArgs() {
		context.remove(KEY_STRING_NULL)
	}

}