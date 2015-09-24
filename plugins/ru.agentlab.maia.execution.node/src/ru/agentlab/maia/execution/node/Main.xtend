package ru.agentlab.maia.execution.node

class Main {

	def static void main(String[] args) {
		val count = 1_000_000
		val param = new ExecutionInput("d", Object)
		val param2 = new ExecutionInput("d2", Object)
		val t1 = new Thread [
			for (i : 0 ..< count) {
				param.link(param2)
			}
		]
		val t2 = new Thread [
			for (i : 0 ..< count) {
				param.unlink(param2)
			}
		]
		val t3 = new Thread [
			for (i : 0 ..< count) {
				param.dump
			}
		]
		t1.start
		t2.start
		t3.start
		t1.join
		t2.join
		t3.join
		println(param.linked.size)
	}

}