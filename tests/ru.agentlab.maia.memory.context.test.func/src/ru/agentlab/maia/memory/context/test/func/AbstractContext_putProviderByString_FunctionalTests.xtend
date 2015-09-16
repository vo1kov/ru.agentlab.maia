package ru.agentlab.maia.memory.context.test.func

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

/**
 * <p>
 * Tests for {@link IMaiaContext#set(String,Provider) IMaiaContext.set(String,Provider)}
 * method.
 * </p><p>
 * Possible provider-service position in context tree:
 * </p><ul>
 * <li>noInTree  - no any provider-service contains in testing context or it's parents;</li>
 * <li>inParent  - provider-service contains in some parent of testing context;</li>
 * <li>inContext - provider-service contains in testing context;</li>
 * </ul><p>
 * Possible method's arguments:
 * </p><ul>
 * <li>validArgs  - invoke <code>IMaiaContext.set(validKey, validProvider)</code>;</li>
 * <li>nullString  - invoke <code>IMaiaContext.set(null, validProvider)</code>;</li>
 * <li>nullProvider - invoke <code>IMaiaContext.set(validKey, null)</code>;</li>
 * <li>nullArgs - invoke <code>IMaiaContext.set(null, null)</code>;</li>
 * </ul><p>
 * Results of method tests can be proven by:
 * </p><ul>
 * <li>{@link IMaiaContext#getKeySet() IMaiaContext.getKeySet()};</li>
 * <li>{@link IMaiaContext#get(String) IMaiaContext.get(String)};</li>
 * </ul>
 */
@RunWith(Parameterized)
class AbstractContext_putProviderByString_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context, ServiceRegistration contextServices, ServiceRegistration parentServices) {
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
	def void getKeySet_increaseSize_whenKeyNoInContext_whenNullProvider() {
		assumeKeyNotInContext
		val before = context.keySet.size

		invokeWithNullProvider

		assertThat(context.keySet.size - before, equalTo(1))
	}

	@Test
	def void getKeySet_unchangedSize_whenKeyInContext_whenValidArgs() {
		assumeKeyInContext
		val before = context.keySet.size

		invokeWithValidArgs

		assertThat(context.keySet.size, equalTo(before))
	}

	@Test
	def void getKeySet_unchangedSize_whenKeyInContext_whenNullProvider() {
		assumeKeyInContext
		val before = context.keySet.size

		invokeWithNullProvider

		assertThat(context.keySet.size, equalTo(before))
	}

	@Test
	def void getKeySet_containKey_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.keySet, hasItem(KEY_STRING_VALID))
	}

	@Test
	def void getKeySet_containKey_whenNullProvider() {
		invokeWithNullProvider

		assertThat(context.keySet, hasItem(KEY_STRING_VALID))
	}

	@Test
	def void getProviderByString_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProvider(KEY_STRING_VALID), equalTo(PROVIDER_VALID))
	}

	@Test
	def void getProviderByString_returnNull_whenNullProvider() {
		invokeWithNullProvider

		assertThat(context.getProvider(KEY_STRING_VALID), equalTo(PROVIDER_NULL))
	}

	@Test
	def void getProviderByClass_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProvider(KEY_CLASS_VALID), equalTo(PROVIDER_VALID))
	}

	@Test
	def void getProviderByClass_returnNull_whenNullProvider() {
		invokeWithNullProvider

		assertThat(context.getProvider(KEY_CLASS_VALID), equalTo(PROVIDER_NULL))
	}

	@Test
	def void getProviderLocalByString_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProviderLocal(KEY_STRING_VALID), equalTo(PROVIDER_VALID))
	}

	@Test
	def void getProviderLocalByString_returnNull_whenNullProvider() {
		invokeWithNullProvider

		assertThat(context.getProviderLocal(KEY_STRING_VALID), equalTo(PROVIDER_NULL))
	}

	@Test
	def void getProviderLocalByClass_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProviderLocal(KEY_CLASS_VALID), equalTo(PROVIDER_VALID))
	}

	@Test
	def void getProviderLocalByClass_returnNull_whenNullProvider() {
		invokeWithNullProvider

		assertThat(context.getProviderLocal(KEY_CLASS_VALID), equalTo(PROVIDER_NULL))
	}

	@Test
	def void getServiceByString_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getService(KEY_STRING_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceByString_returnNull_whenNullProvider() {
		invokeWithNullProvider

		assertThat(context.getService(KEY_STRING_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceByClass_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getService(KEY_CLASS_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceByClass_returnNull_whenNullProvider() {
		invokeWithNullProvider

		assertThat(context.getService(KEY_CLASS_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceLocalByString_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getServiceLocal(KEY_STRING_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceLocalByString_returnNull_whenNullProvider() {
		invokeWithNullProvider

		assertThat(context.getServiceLocal(KEY_STRING_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceLocalByClass_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getServiceLocal(KEY_CLASS_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceLocalByClass_returnNull_whenNullProvider() {
		invokeWithNullProvider

		assertThat(context.getServiceLocal(KEY_CLASS_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getUuid_unchangeValue_whenValidArgs() {
		val before = context.uuid

		invokeWithValidArgs

		assertThat(context.uuid, equalTo(before))
	}

	@Test
	def void getUuid_unchangeValue_whenNullProvider() {
		val before = context.uuid

		invokeWithNullProvider

		assertThat(context.uuid, equalTo(before))
	}

	@Test
	def void getParent_unchangeValue_whenValidArgs() {
		val before = context.parent

		invokeWithValidArgs

		assertThat(context.parent, equalTo(before))
	}

	@Test
	def void getParent_unchangeValue_whenNullProvider() {
		val before = context.parent

		invokeWithNullProvider

		assertThat(context.parent, equalTo(before))
	}

	@Test
	def void getChilds_unchangeValue_whenValidArgs() {
		val before = context.childs

		invokeWithValidArgs

		assertArrayEquals(before, context.childs)
	}

	@Test
	def void getChilds_unchangeValue_whenNullProvider() {
		val before = context.childs

		invokeWithNullProvider

		assertArrayEquals(before, context.childs)
	}

	@Test
	def void self_notInteractWithParent_whenValidArgs() {
		invokeWithValidArgs

		verifyZeroInteractions(parent)
	}

	@Test
	def void self_notInteractWithParent_whenNullProvider() {
		invokeWithNullProvider

		verifyZeroInteractions(parent)
	}

	@Test(expected=NullPointerException)
	def void self_throw_whenNullString() {
		invokeWithNullString
	}

	@Test(expected=NullPointerException)
	def void self_throw_whenNullArgs() {
		invokeWithNullArgs
	}

	def private void invokeWithValidArgs() {
		context.putProvider(KEY_STRING_VALID, PROVIDER_VALID)
	}

	def private void invokeWithNullProvider() {
		context.putProvider(KEY_STRING_VALID, PROVIDER_NULL)
	}

	def private void invokeWithNullString() {
		context.putProvider(KEY_STRING_NULL, PROVIDER_VALID)
	}

	def private void invokeWithNullArgs() {
		context.putProvider(KEY_STRING_NULL, PROVIDER_NULL)
	}

}