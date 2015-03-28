package ru.agentlab.maia.test.func

import javax.inject.Inject
import ru.agentlab.maia.platform.IPlatformNameGenerator
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PlatformNameGeneratorInjectionExample {
	
	@Inject
	IPlatformNameGenerator nameGenerator
	
}