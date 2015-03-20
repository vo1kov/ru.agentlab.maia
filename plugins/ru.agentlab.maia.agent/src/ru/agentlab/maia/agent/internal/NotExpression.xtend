package ru.agentlab.maia.agent.internal

import ru.agentlab.maia.IMessage

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