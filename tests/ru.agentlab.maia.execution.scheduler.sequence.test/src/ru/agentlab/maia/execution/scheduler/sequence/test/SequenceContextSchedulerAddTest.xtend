package ru.agentlab.maia.execution.scheduler.sequence.test

import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.IExecutionAction
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static org.junit.Assert.*

@RunWith(MockitoJUnitRunner)
class SequenceContextSchedulerAddTest {

	@Mock
	IExecutionAction action1

	@Mock
	IExecutionAction action2

	IExecutionScheduler scheduler

	@Before
	def void beforeEach() {
		scheduler = new SequenceContextScheduler => [
			addChild(action1)
			addChild(action2)
		]
	}

	@After
	def void afterEach() {
		scheduler.removeAll
	}

	@Test
	def void testActionOrder() {
		scheduler => [
			assertEquals(action1, nextChild)
			assertEquals(action2, nextChild)
			assertEquals(action1, nextChild)
			assertEquals(action2, nextChild)
			assertEquals(action1, nextChild)
			assertEquals(action2, nextChild)
		]
	}

	@Test
	def void testFirstAction() {
		assertEquals(action1, scheduler.nextChild)
	}

	@Test
	def void testDuplicateAdd() {
		scheduler => [
			addChild(action1)
			addChild(action2)
			addChild(action1)
			addChild(action2)
			assertEquals(action1, nextChild)
			assertEquals(action2, nextChild)
			assertEquals(action1, nextChild)
			assertEquals(action2, nextChild)
			assertEquals(action1, nextChild)
			assertEquals(action2, nextChild)
		]
	}

}
