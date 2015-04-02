package ru.agentlab.maia.internal.platform

import java.util.ArrayList
import java.util.HashSet
import java.util.regex.Pattern
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.junit.BeforeClass
import org.junit.Test
import ru.agentlab.maia.internal.naming.PlatformNameGenerator

import static org.junit.Assert.*

class PlatformNameGeneratorTest {

	val static UUID_PATTERN = "[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}"

	val generator = new PlatformNameGenerator
	var static IEclipseContext context

	@BeforeClass
	def static void init() {
		context = EclipseContextFactory.create("Test context")
	}

	@Test
	def void generate_notEmpty_test() {
		val name = generator.generate
		assertNotNull(name)
		assertTrue(name.length > 0)
	}

	@Test
	def void generate_rightFormat_test() {
		val name = generator.generate
		val pattern = Pattern.compile(UUID_PATTERN)
		val matcher = pattern.matcher(name)
		assertTrue(matcher.matches)
	}

	@Test
	def void generate_unique_test() {
		val generatedNames = new ArrayList<String>
		for (i : 0 ..< 100) {
			generatedNames += generator.generate
		}
		val uniqueGeneratedNames = new HashSet<String>(generatedNames)
		assertTrue(uniqueGeneratedNames.size == generatedNames.size)
	}

}