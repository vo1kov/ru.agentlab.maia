package ru.agentlab.maia.memory.context.test.blackbox

import java.util.UUID
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.exception.MaiaContextKeyNotFound

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(Parameterized)
class AbstractContext_removeByString_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IContext context, ServiceRegistration contextServices, ServiceRegistration parentServices) {
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

//	@Test
//	def void getProviderByString_returnParentValue_whenValidArgs() {
//		val inParent = try {
//			parent.getProvider(KEY_STRING_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		invokeWithValidArgs
//
//		val inContext = try {
//			context.getProvider(KEY_STRING_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		assertThat(inContext, equalTo(inParent))
//	}
//
//	@Test
//	def void getProviderByString_unchangeValue_whenUnknownArgs() {
//		val before = try {
//			context.getProvider(KEY_STRING_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		invokeWithUnknownArgs
//
//		val inContext = try {
//			context.getProvider(KEY_STRING_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		assertThat(inContext, equalTo(before))
//	}
//
//	@Test
//	def void getProviderByClass_returnParentValue_whenValidArgs() {
//		val inParent = try {
//			parent.getProvider(KEY_CLASS_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		invokeWithValidArgs
//
//		val inContext = try {
//			context.getProvider(KEY_CLASS_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		assertThat(inContext, equalTo(inParent))
//	}
//
//	@Test
//	def void getProviderByClass_unchangeValue_whenUnknownArgs() {
//		val before = try {
//			context.getProvider(KEY_CLASS_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		invokeWithUnknownArgs
//
//		val inContext = try {
//			context.getProvider(KEY_CLASS_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		assertThat(inContext, equalTo(before))
//	}
//
//	@Test(expected=MaiaContextKeyNotFound)
//	def void getProviderLocalByString_throwKeyNotFound_whenValidArgs() {
//		invokeWithValidArgs
//
//		context.getProviderLocal(KEY_STRING_VALID)
//	}
//
//	@Test
//	def void getProviderLocalByString_unchangeValue_whenUnknownArgs() {
//		val before = try {
//			context.getProviderLocal(KEY_STRING_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		invokeWithUnknownArgs
//
//		val inContext = try {
//			context.getProviderLocal(KEY_STRING_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		assertThat(inContext, equalTo(before))
//	}
//
//	@Test(expected=MaiaContextKeyNotFound)
//	def void getProviderLocalByClass_throwKeyNotFound_whenValidArgs() {
//		invokeWithValidArgs
//
//		context.getProviderLocal(KEY_CLASS_VALID)
//	}
//
//	@Test
//	def void getProviderLocalByClass_unchangeValue_whenUnknownArgs() {
//		val before = try {
//			context.getProviderLocal(KEY_CLASS_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		invokeWithUnknownArgs
//
//		val inContext = try {
//			context.getProviderLocal(KEY_CLASS_VALID)
//		} catch (MaiaContextKeyNotFound e) {
//			e.class
//		}
//
//		assertThat(inContext, equalTo(before))
//	}

	@Test
	def void getServiceByString_returnParentValue_whenValidArgs() {
		val inParent = try {
			parent.get(KEY_STRING_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		invokeWithValidArgs

		val inContext = try {
			context.get(KEY_STRING_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		assertThat(inContext, equalTo(inParent))
	}

	@Test
	def void getServiceByString_unchangeValue_whenUnknownArgs() {
		val before = try {
			context.get(KEY_STRING_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		invokeWithUnknownArgs

		val inContext = try {
			context.get(KEY_STRING_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		assertThat(inContext, equalTo(before))
	}

	@Test
	def void getServiceByClass_returnParentValue_whenValidArgs() {
		val inParent = try {
			parent.get(KEY_CLASS_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		invokeWithValidArgs

		val inContext = try {
			context.get(KEY_CLASS_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		assertThat(inContext, equalTo(inParent))
	}

	@Test
	def void getServiceByClass_unchangeValue_whenUnknownArgs() {
		val before = try {
			context.get(KEY_CLASS_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		invokeWithUnknownArgs

		val inContext = try {
			context.get(KEY_CLASS_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		assertThat(inContext, equalTo(before))
	}

	@Test(expected=MaiaContextKeyNotFound)
	def void getServiceLocalByString_throwKeyNotFound_whenValidArgs() {
		invokeWithValidArgs

		context.getLocal(KEY_STRING_VALID)
	}

	@Test
	def void getServiceLocalByString_unchangeValue_whenUnknownArgs() {
		val before = try {
			context.getLocal(KEY_STRING_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		invokeWithUnknownArgs

		val inContext = try {
			context.getLocal(KEY_STRING_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		assertThat(inContext, equalTo(before))
	}

	@Test(expected=MaiaContextKeyNotFound)
	def void getServiceLocalByClass_throwKeyNotFound_whenValidArgs() {
		invokeWithValidArgs

		context.getLocal(KEY_CLASS_VALID)
	}

	@Test
	def void getServiceLocalByClass_unchangeValue_whenUnknownArgs() {
		val before = try {
			context.getLocal(KEY_CLASS_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		invokeWithUnknownArgs

		val inContext = try {
			context.getLocal(KEY_CLASS_VALID)
		} catch (MaiaContextKeyNotFound e) {
			e.class
		}

		assertThat(inContext, equalTo(before))
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
//	def void getChilds_unchangeValue_whenUnknownArgs() {
//		val before = context.childs
//
//		invokeWithUnknownArgs
//
//		assertArrayEquals(before, context.childs)
//	}
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