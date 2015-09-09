package ru.agentlab.maia.memory.context.arraylist

import static org.junit.Assert.*

class ArrayListContextTestsExtension {
	
	def void checkSameSize(ListContext context) {
		if (context.keys.size != context.values.size) {
			fail("Key and value sizes not match. Testing on corrupted context")
		}
	}

	def void prepareWithService(ListContext context, String key, Object service) {
		context.checkSameSize
		val keyIndex = context.keys.indexOf(key)
		if (keyIndex == -1) {
			context.keys.add(key)
			context.values.add(service)
		} else {
			context.values.add(keyIndex, service)
		}
		context.checkSameSize
	}

	def void prepareWithOutService(ListContext context, String key) {
		context.checkSameSize
		val keyIndex = context.keys.indexOf(key)
		if (keyIndex != -1) {
			context.keys.remove(keyIndex)
			context.values.remove(keyIndex)
		}
		context.checkSameSize
	}
}