package ru.agentlab.maia.adapter

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Issue implements IIssue {

	val String target

	val String result

	new(String target, String result) {
		this.target = target
		this.result = result
	}

}