package ru.agentlab.maia.adapter

import java.util.HashMap
import java.util.List

class IssueResolver<T> implements IIssueResolver<T> {

	val cache = new HashMap<String, Object>

	override resolve(List<IIssue> issues) {
		issues.forEach [
			val targetUuid = it.target
			val resultUuid = it.result
			val targetObject = cache.get(targetUuid)
			val resultObject = it.resolve(targetObject)
			if (resultUuid != null) {
				cache.put(resultUuid, resultObject)
			}
		]
		return null
	}

}