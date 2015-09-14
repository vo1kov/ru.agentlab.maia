package ru.agentlab.maia.context.modifier

import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.memory.IMaiaContext

class MaiaRootContextModifier {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
			putService(IMaiaContext.KEY_TYPE, "root")
			putService(ExecutorService, Executors.newFixedThreadPool(5))
		]
	}
}