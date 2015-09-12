package ru.agentlab.maia.memory.context.test

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class AbstractContext_GetUuid_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context) {
		super(context)
	}
	
	@Test
	def void shouldReturnAfterConstruction() {
		val uuid = context.uuid

		assertThat(uuid, notNullValue)
	}

}