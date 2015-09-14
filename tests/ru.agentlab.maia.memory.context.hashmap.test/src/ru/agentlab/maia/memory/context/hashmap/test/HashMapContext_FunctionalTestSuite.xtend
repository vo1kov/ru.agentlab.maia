package ru.agentlab.maia.memory.context.hashmap.test

import java.util.Collection
import org.junit.parameterizedsuite.ParameterizedSuite
import org.junit.runner.RunWith
import org.junit.runners.Parameterized.Parameters
import org.junit.runners.Suite.SuiteClasses
import ru.agentlab.maia.memory.context.hashmap.HashMapContext
import ru.agentlab.maia.memory.context.test.AbstractContext_removeByClass_FunctionalTests

import static ru.agentlab.maia.memory.context.test.ServiceRegistration.*
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
class HashMapContext_FunctionalTestSuite {

	@Parameters(name="implementation: [{0}], self:[{1}], parent:[{2}]")
	def public static Collection<?> keysAndValues() {
		return #[
			#[new HashMapContext, NONE, NONE].toArray,
			// service registration by class
			#[new HashMapContext, SERVICE_BY_CLASS, NONE].toArray,
			#[new HashMapContext, NONE, SERVICE_BY_CLASS].toArray,
			#[new HashMapContext, SERVICE_BY_CLASS, SERVICE_BY_CLASS].toArray,
			// service registration by string
			#[new HashMapContext, SERVICE_BY_STRING, NONE].toArray,
			#[new HashMapContext, NONE, SERVICE_BY_STRING].toArray,
			#[new HashMapContext, SERVICE_BY_STRING, SERVICE_BY_STRING].toArray,
			// provider registration by class
			#[new HashMapContext, PROVIDER_BY_CLASS, NONE].toArray,
			#[new HashMapContext, NONE, PROVIDER_BY_CLASS].toArray,
			#[new HashMapContext, PROVIDER_BY_CLASS, PROVIDER_BY_CLASS].toArray,
			// provider registration by string
			#[new HashMapContext, PROVIDER_BY_STRING, NONE].toArray,
			#[new HashMapContext, NONE, PROVIDER_BY_STRING].toArray,
			#[new HashMapContext, PROVIDER_BY_STRING, PROVIDER_BY_STRING].toArray
		]
	}

}