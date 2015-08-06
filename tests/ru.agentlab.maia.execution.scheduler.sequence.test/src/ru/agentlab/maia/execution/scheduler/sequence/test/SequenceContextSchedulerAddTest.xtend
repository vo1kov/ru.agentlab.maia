package ru.agentlab.maia.execution.scheduler.sequence.test

import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler

import static org.junit.Assert.*

@RunWith(MockitoJUnitRunner)
class SequenceContextSchedulerAddTest {

	@Mock
	IMaiaContext context

	@Mock
	IMaiaContextAction action1

	@Mock
	IMaiaContextAction action2

	IMaiaExecutorScheduler scheduler

	@Before
	def void beforeEach() {
		scheduler = new SequenceContextScheduler(context) => [
			add(action1)
			add(action2)
		]
	}

	@After
	def void afterEach() {
		scheduler.removeAll
	}

	@Test
	def void testActionOrder() {
		scheduler => [
			assertEquals(action1, nextContext)
			assertEquals(action2, nextContext)
			assertEquals(action1, nextContext)
			assertEquals(action2, nextContext)
			assertEquals(action1, nextContext)
			assertEquals(action2, nextContext)
		]
	}

	@Test
	def void testFirstAction() {
		assertEquals(action1, scheduler.nextContext)
	}
	
	@Test
	def void testDuplicateAdd() {
		scheduler => [
			add(action1)
			add(action2)
			add(action1)
			add(action2)
			assertEquals(action1, nextContext)
			assertEquals(action2, nextContext)
			assertEquals(action1, nextContext)
			assertEquals(action2, nextContext)
			assertEquals(action1, nextContext)
			assertEquals(action2, nextContext)
		]
	}
	
}
