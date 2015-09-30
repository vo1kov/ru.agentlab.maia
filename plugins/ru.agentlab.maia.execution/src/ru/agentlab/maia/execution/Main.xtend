package ru.agentlab.maia.execution

import java.util.BitSet

class Main {

	def static void main(String[] args) {
		val bitset = new BitSet()
		for (i : 0 ..< 80) {
			bitset.set(i, true)
			println("L: " + bitset.length + "	S: " + bitset.size)
		}
	}

}