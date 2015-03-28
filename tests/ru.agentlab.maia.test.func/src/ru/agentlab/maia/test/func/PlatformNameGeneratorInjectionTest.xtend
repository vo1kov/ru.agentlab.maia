package ru.agentlab.maia.test.func

import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.junit.BeforeClass
import ru.agentlab.maia.platform.IPlatformNameGenerator

import static org.junit.Assert.*

class PlatformNameGeneratorInjectionTest {

	static IEclipseContext context

	@BeforeClass
	def static void init() {
		context = EclipseContextFactory.getServiceContext(Activator.context)
	}

	/**
	 * Test that IPlatformNameGenerator registered in OSGI registry
	 */
	def void test() {
		val reference = Activator.context.getServiceReference(IPlatformNameGenerator)
		val generator = Activator.context.getService(reference)
		assertNotNull(generator)
	}
	
	/**
	 * Test that OSGI Service Context contains IPlatformNameGenerator
	 */
	def void test3() {
		val generator = context.get(IPlatformNameGenerator)
		assertNotNull(generator)
	}

	def void test2() {
		val example = ContextInjectionFactory.make(PlatformNameGeneratorInjectionExample, context)
		assertNotNull(example.nameGenerator)
	}

}