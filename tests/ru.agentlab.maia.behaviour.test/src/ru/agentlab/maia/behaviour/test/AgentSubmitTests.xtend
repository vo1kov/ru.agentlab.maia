package ru.agentlab.maia.behaviour.test

import java.util.Random
import java.util.concurrent.Executors
import org.junit.Test
import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.agent.Agent
import ru.agentlab.maia.behaviour.Behaviour

class AgentSubmitTests {

	@Test
	def void test() {
		val random = new Random
		val executor = Executors.newFixedThreadPool(2)
		val agent = new Agent(executor)
//		val tasks = new ArrayList<Runnable>
		for (i : 0 ..< 5) {
			val Runnable task = new Runnable {

				override run() {
					val duration = random.nextInt(1000)
					println("START task " + i + " with duration " + duration)
					Thread.sleep(duration)
					println("END task " + i)
				}

				override toString() {
					"TASK-" + i
				}

			}
//			val mock = Mockito.spy(task)
//			tasks += mock
			agent.submit(task)
		}

		agent.behaviour = new Behaviour {

			override execute() {
				val duration = random.nextInt(1000)
				println("START Behaviour " + " with duration " + duration)
				Thread.sleep(duration)
				println("END Behaviour ")
				state = IBehaviour.State.WORKING
			}

			override toString() {
				"BEHAVIOUR"
			}

		}

		println("START agent")
		agent.start

		for (i : 5 ..< 10) {
			val Runnable task = new Runnable {

				override run() {
					val duration = random.nextInt(1000)
					println("START task " + i + " with duration " + duration)
					Thread.sleep(duration)
					println("END task " + i)
				}

				override toString() {
					"TASK-" + i
				}

			}
//			val mock = Mockito.spy(task)
//			tasks += mock
			agent.submit(task)
		}

		Thread.sleep(10000)

		println("STOP agent")
		agent.stop

		Thread.sleep(5000)

//		val order = Mockito.inOrder(tasks)
//		tasks.forEach [
//			order.verify(it).run
//		]
	}

}
