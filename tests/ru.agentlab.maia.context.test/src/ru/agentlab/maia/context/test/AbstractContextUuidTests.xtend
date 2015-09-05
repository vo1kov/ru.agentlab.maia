package ru.agentlab.maia.context.test

import org.junit.Test

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class AbstractContextUuidTests extends AbstractContextTests {

	@Test
	def void shouldRetrieveServiceWhenInContext() {
		val uuid = context.uuid

		assertThat(uuid, notNullValue)
	}

}