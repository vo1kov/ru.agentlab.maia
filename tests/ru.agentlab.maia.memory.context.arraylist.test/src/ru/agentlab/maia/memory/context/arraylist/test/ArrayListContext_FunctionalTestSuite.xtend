package ru.agentlab.maia.memory.context.arraylist.test

import java.util.Collection
import org.junit.parameterizedsuite.ParameterizedSuite
import org.junit.runner.RunWith
import org.junit.runners.Parameterized.Parameters
import org.junit.runners.Suite.SuiteClasses
import ru.agentlab.maia.memory.context.arraylist.ArrayListContext
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
class ArrayListContext_FunctionalTestSuite {

	@Parameters(name="{0}")
	def public static Collection<?> getContext() {
		return #[new ArrayListContext]
	}

}