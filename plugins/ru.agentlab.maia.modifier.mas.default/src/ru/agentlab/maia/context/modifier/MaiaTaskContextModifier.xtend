package ru.agentlab.maia.context.modifier

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IContext

class MaiaTaskContextModifier {

	@Inject
	IContext context

	@PostConstruct
	def void setup() {
		context => []
	}
}