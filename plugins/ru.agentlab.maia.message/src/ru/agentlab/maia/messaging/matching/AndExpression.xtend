package ru.agentlab.maia.messaging.matching

import ru.agentlab.maia.message.IMessage

class AndExpression implements IMatchExpression {

	private IMatchExpression op1

	private IMatchExpression op2

	new(IMatchExpression e1, IMatchExpression e2) {
		op1 = e1
		op2 = e2
	}

	override public boolean match(IMessage msg) {
		return op1.match(msg) && op2.match(msg)
	}

	override public String toString() {
		return "(" + op1.toString() + " AND " + op2.toString() + ")"
	}

}