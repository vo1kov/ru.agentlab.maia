package ru.agentlab.maia.context.modifier

import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IContext

class MaiaRootContextModifier {

	@Inject
	IContext context

	@PostConstruct
	def void setup() {
		context => [
			putService(IContext.KEY_TYPE, "root")
			putService(ExecutorService, Executors.newFixedThreadPool(5))
		]
	}
}