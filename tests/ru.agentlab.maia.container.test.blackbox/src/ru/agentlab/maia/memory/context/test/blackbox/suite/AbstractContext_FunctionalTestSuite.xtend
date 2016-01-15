package ru.agentlab.maia.memory.context.test.blackbox.suite

import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Suite.SuiteClasses
import ru.agentlab.maia.memory.context.test.blackbox.AbstractContext_putByClass_FunctionalTests
import ru.agentlab.maia.memory.context.test.blackbox.AbstractContext_putByString_FunctionalTests
import ru.agentlab.maia.memory.context.test.blackbox.AbstractContext_removeByClass_FunctionalTests
import ru.agentlab.maia.memory.context.test.blackbox.AbstractContext_removeByString_FunctionalTests

@RunWith(Parameterized)
@SuiteClasses(#[
	AbstractContext_removeByClass_FunctionalTests,
	AbstractContext_removeByString_FunctionalTests,
	AbstractContext_putByClass_FunctionalTests,
	AbstractContext_putByString_FunctionalTests
])
abstract class AbstractContext_FunctionalTestSuite {
}