package ru.agentlab.maia.memory.context.arrays

import java.util.Arrays

class ArrayContextTestsExtension {

	def void prepareWithService(ArrayContext context, String key, Object service) {
		val keyIndex = context.keys.indexOf(key)
		if (keyIndex == -1) {
			context.keys = context.keys.add(key)
			context.values = context.values.add(service)
		} else {
			context.values.set(keyIndex, service)
		}
	}

	def void prepareWithOutService(ArrayContext context, String key) {
		val keyIndex = context.keys.indexOf(key)
		if (keyIndex != -1) {
			context.keys = context.keys.remove(keyIndex)
			context.values = context.values.remove(keyIndex)
		}
	}

	def protected <T> int indexOf(T[] array, T element) {
		for (i : 0 ..< array.length) {
			if (element.equals(array.get(i))) {
				return i
			}
		}
		return -1
	}

	def protected <T> T[] remove(T[] array, int index) {
		val int numMoved = array.length - index - 1
		if (numMoved > 0) {
			System.arraycopy(array, index + 1, array, index, numMoved)
		}
		val result = Arrays.copyOf(array, array.length - 1)
		return result
	}

	def protected <T> T[] add(T[] array, T element) {
		val result = Arrays.copyOf(array, array.length + 1)
		result.set(result.length - 1, element)
		return result
	}
}