package ru.agentlab.maia.context.modifier

import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext

class MaiaRootContextModifier {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
			set(IMaiaContext.KEY_TYPE, "root")
			set(ExecutorService, Executors.newFixedThreadPool(5))
		]
	}
}