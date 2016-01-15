package ru.agentlab.maia.behaviour.test

import java.util.ArrayList
import java.util.concurrent.Executors
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.agent.Agent

import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class AgentContainerTests {

	val static int SIZE = 5

	@Test
	def void test() {
		val agent = new Agent(Executors.newFixedThreadPool(5))
		val tasks = new ArrayList<Runnable>
		for (i : 0 ..< SIZE) {
			val task = mock(Runnable)
			doNothing.when(task).run
			tasks += task
			agent.submit(task)
		}
		val order = inOrder(tasks.toArray)

		Thread.sleep(1000)

		tasks.forEach [
			order.verify(it).run
		]
	}

}
