package ru.agentlab.maia.test.func

import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.junit.BeforeClass
import org.junit.Test
import ru.agentlab.maia.naming.INameGenerator

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
	@Test
	def void test() {
		val reference = Activator.context.getServiceReference(INameGenerator)
		val generator = Activator.context.getService(reference)
		assertNotNull(generator)
	}

	/**
	 * Test that OSGI Service Context contains IPlatformNameGenerator
	 */
	@Test
	def void test3() {
		val generator = context.get(INameGenerator)
		assertNotNull(generator)
	}

	@Test
	def void test2() {
		val example = ContextInjectionFactory.make(PlatformNameGeneratorInjectionExample, context)
		assertNotNull(example.nameGenerator)
	}

}