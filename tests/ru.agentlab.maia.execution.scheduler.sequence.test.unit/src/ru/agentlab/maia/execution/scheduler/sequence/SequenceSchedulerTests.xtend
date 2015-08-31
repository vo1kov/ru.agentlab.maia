package ru.agentlab.maia.execution.scheduler.sequence

import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.tree.IExecutionAction

import static org.junit.Assert.*

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerTests {

	@Mock
	IExecutionAction action1

	@Mock
	IExecutionAction action2

	SequenceContextScheduler scheduler

	@Before
	def void beforeEach() {
//		action1 = mock(IMaiaContextAction)
//		action2 = mock(IMaiaContextAction)
		scheduler = new SequenceContextScheduler
	}

	@After
	def void afterEach() {
		scheduler.removeAll
	}

	@Test
	def void testMultipleAdd() {
		for (i : 0 ..< 5) {
			scheduler.addChild(action1)
		}
		assertEquals(1, scheduler.childs.size)
	}

	@Test
	def void testOrderAdd() {
		scheduler => [
			addChild(action1)
			addChild(action2)
		]
		scheduler.childs => [
			println(it)
//			assertTrue(action1 + "is NOT before " + action2, indexOf(action1) < indexOf(action2))
		]
	}

}