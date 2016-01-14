package ru.agentlab.maia.behaviour.pattern

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.IBehaviour

@Accessors
class PatternState implements IPatternState {

	String name

	IBehaviour node

	new(String name) {
		this.name = name
	}

}