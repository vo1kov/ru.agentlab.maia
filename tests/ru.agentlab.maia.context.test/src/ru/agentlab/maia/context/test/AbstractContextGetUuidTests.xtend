package ru.agentlab.maia.context.test

import org.junit.Test

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class AbstractContextGetUuidTests extends AbstractContextTests {

	@Test
	def void shouldReturnAfterConstruction() {
		val uuid = context.uuid

		assertThat(uuid, notNullValue)
	}

}