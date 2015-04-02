package ru.agentlab.maia.test.func

import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.naming.INameGenerator

@Accessors
class PlatformNameGeneratorInjectionExample {

	@Inject
	INameGenerator nameGenerator

}