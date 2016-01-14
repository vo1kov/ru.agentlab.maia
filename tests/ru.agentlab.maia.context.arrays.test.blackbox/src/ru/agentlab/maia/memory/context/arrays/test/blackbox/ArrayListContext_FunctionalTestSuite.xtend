package ru.agentlab.maia.memory.context.arrays.test.blackbox

import java.util.ArrayList
import java.util.Collection
import org.junit.parameterizedsuite.ParameterizedSuite
import org.junit.runner.RunWith
import org.junit.runners.Parameterized.Parameters
import org.junit.runners.Suite.SuiteClasses
import ru.agentlab.maia.memory.context.test.blackbox.AbstractContext_putByClass_FunctionalTests
import ru.agentlab.maia.memory.context.test.blackbox.AbstractContext_putByString_FunctionalTests
import ru.agentlab.maia.memory.context.test.blackbox.AbstractContext_removeByClass_FunctionalTests
import ru.agentlab.maia.memory.context.test.blackbox.AbstractContext_removeByString_FunctionalTests
import ru.agentlab.maia.memory.context.test.blackbox.ServiceRegistrationExtension

@RunWith(ParameterizedSuite)
@SuiteClasses(#[
	AbstractContext_removeByClass_FunctionalTests,
	AbstractContext_removeByString_FunctionalTests,
	AbstractContext_putByClass_FunctionalTests,
	AbstractContext_putByString_FunctionalTests
])
class ArrayListContext_FunctionalTestSuite {

	@Parameters(name="implementation: [{0}], context:[{1}], parent:[{2}]")
	def public static Collection<?> keysAndValues() {
		val result = new ArrayList
		for (pair : ServiceRegistrationExtension.combinations) {
			result += #[new ArrayContext, pair.key, pair.value].toArray
		}
		return result
	}

}
