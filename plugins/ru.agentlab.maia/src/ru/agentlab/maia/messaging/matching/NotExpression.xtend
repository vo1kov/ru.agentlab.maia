package ru.agentlab.maia.messaging.matching

import ru.agentlab.maia.messaging.IMessage

class NotExpression implements IMatchExpression {

	IMatchExpression op

	new(IMatchExpression e) {
		op = e
	}

	override public boolean match(IMessage msg) {
		return ! op.match(msg)
	}

	override public String toString() {
		return "(NOT " + op.toString() + ")"
	}

}