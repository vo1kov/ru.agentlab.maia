package ru.agentlab.maia.memory.context.test.func

import java.util.UUID
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(Parameterized)
class AbstractContext_removeByString_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

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
	def void getProviderByString_returnFromParent_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProvider(KEY_STRING_VALID), equalTo(parent.getProvider(KEY_STRING_VALID)))
	}

	@Test
	def void getProviderByString_unchangeValue_whenUnknownArgs() {
		val before = context.getProvider(KEY_STRING_VALID)

		invokeWithUnknownArgs

		assertThat(context.getProvider(KEY_STRING_VALID), equalTo(before))
	}

	@Test
	def void getProviderByClass_returnFromParent_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProvider(KEY_CLASS_VALID), equalTo(parent.getProvider(KEY_STRING_VALID)))
	}

	@Test
	def void getProviderByClass_unchangeValue_whenUnknownArgs() {
		val before = context.getProvider(KEY_STRING_VALID)

		invokeWithUnknownArgs

		assertThat(context.getProvider(KEY_CLASS_VALID), equalTo(before))
	}

	@Test
	def void getProviderLocalByString_returnNull_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProviderLocal(KEY_STRING_VALID), equalTo(PROVIDER_NULL))
	}

	@Test
	def void getProviderLocalByString_unchangeValue_whenUnknownArgs() {
		val before = context.getProviderLocal(KEY_STRING_VALID)

		invokeWithUnknownArgs

		assertThat(context.getProviderLocal(KEY_STRING_VALID), equalTo(before))
	}

	@Test
	def void getProviderLocalByClass_returnNull_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProviderLocal(KEY_CLASS_VALID), equalTo(PROVIDER_NULL))
	}

	@Test
	def void getProviderLocalByClass_unchangeValue_whenUnknownArgs() {
		val before = context.getProviderLocal(KEY_STRING_VALID)

		invokeWithUnknownArgs

		assertThat(context.getProviderLocal(KEY_CLASS_VALID), equalTo(before))
	}

	@Test
	def void getServiceByString_returnParentValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getService(KEY_STRING_VALID), equalTo(parent.getService(KEY_STRING_VALID)))
	}

	@Test
	def void getServiceByString_unchangeValue_whenUnknownArgs() {
		val before = context.getService(KEY_STRING_VALID)

		invokeWithUnknownArgs

		assertThat(context.getService(KEY_STRING_VALID), equalTo(before))
	}

	@Test
	def void getServiceByClass_returnParentValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getService(KEY_CLASS_VALID), equalTo(parent.getService(KEY_CLASS_VALID)))
	}

	@Test
	def void getServiceByClass_unchangeValue_whenUnknownArgs() {
		val before = context.getService(KEY_CLASS_VALID)

		invokeWithUnknownArgs

		assertThat(context.getService(KEY_CLASS_VALID), equalTo(before))
	}

	@Test
	def void getServiceByStringLocal_returnNull_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getServiceLocal(KEY_STRING_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceLocalByString_unchangeValue_whenUnknownArgs() {
		val before = context.getServiceLocal(KEY_STRING_VALID)

		invokeWithUnknownArgs

		assertThat(context.getServiceLocal(KEY_STRING_VALID), equalTo(before))
	}

	@Test
	def void getServiceLocalByClass_returnNull_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getServiceLocal(KEY_CLASS_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceLocalByClass_unchangeValue_whenUnknownArgs() {
		val before = context.getServiceLocal(KEY_CLASS_VALID)

		invokeWithUnknownArgs

		assertThat(context.getServiceLocal(KEY_CLASS_VALID), equalTo(before))
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

	@Test(expected=IllegalArgumentException)
	def void self_throw_whenNullArgs() {
		invokeWithNullArgs
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