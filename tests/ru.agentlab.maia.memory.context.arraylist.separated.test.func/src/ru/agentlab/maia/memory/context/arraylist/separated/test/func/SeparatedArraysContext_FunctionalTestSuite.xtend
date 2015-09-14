package ru.agentlab.maia.memory.context.arraylist.separated.test.func

import java.util.Collection
import org.junit.parameterizedsuite.ParameterizedSuite
import org.junit.runner.RunWith
import org.junit.runners.Parameterized.Parameters
import org.junit.runners.Suite.SuiteClasses
import ru.agentlab.maia.memory.context.arraylist.separated.SeparatedArraysContext
import ru.agentlab.maia.memory.context.test.AbstractContext_removeByClass_FunctionalTests
import ru.agentlab.maia.memory.context.test.AbstractContext_removeByString_FunctionalTests
import ru.agentlab.maia.memory.context.test.AbstractContext_putServiceByString_FunctionalTests
import ru.agentlab.maia.memory.context.test.AbstractContext_putServiceByClass_FunctionalTests

@RunWith(ParameterizedSuite)
@SuiteClasses(#[
	AbstractContext_removeByClass_FunctionalTests,
	AbstractContext_removeByString_FunctionalTests,
	AbstractContext_putServiceByClass_FunctionalTests,
	AbstractContext_putServiceByString_FunctionalTests
])
class SeparatedArraysContext_FunctionalTestSuite {

	@Parameters
	def public static Collection<?> keysAndValues() {
		return #[new SeparatedArraysContext]
	}

}