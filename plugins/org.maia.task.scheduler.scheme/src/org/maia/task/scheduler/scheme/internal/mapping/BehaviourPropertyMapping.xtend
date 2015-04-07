package org.maia.task.scheduler.scheme.internal.mapping

import java.util.HashMap
import java.util.UUID
import javax.inject.Inject
import org.eclipse.xtend2.lib.StringConcatenation
import org.maia.task.scheduler.scheme.internal.PropertyIndex
import org.maia.task.scheduler.scheme.mapping.IBehaviourPropertyMapping

/**
 * Indirect mapping
 * 
 * <pre>
 * [FIELD1] -> [KEY1] -> [VALUE1]
 * [FIELD2] -> [KEY2] -> [VALUE2]
 * [FIELD3] -> [KEY3] -> [VALUE3]
 * </pre>
 * After linking:
 * <pre>
 * [FIELD1] -> [KEY1] -> [VALUE1]
 * [FIELD2] -----^
 * [FIELD2] -----^
 * </pre>
 * 
 */
class BehaviourPropertyMapping implements IBehaviourPropertyMapping {

	val keyMap = new HashMap<UUID, UUID>

	val valueMap = new HashMap<UUID, Object>

	@Inject
	PropertyIndex propertyIndex

	override void put(Object task, String parameter, Object value) {
		val id = propertyIndex.getFieldIndex(task, parameter)
		val key = getKey(id)
		valueMap.put(key, value)
	}

	def private UUID getKey(UUID id) {
		var key = keyMap.get(id)
		if (key == null) {
			key = UUID.randomUUID
			keyMap.put(id, key)
		}
		return key
	}

	override Object get(Object task, String parameter) {
		val id = propertyIndex.getFieldIndex(task, parameter)
		val key = getKey(id)
		return valueMap.get(key)
	}

	override void link(Object fromTask, String outputParameter, Object toTask, String inputParameter) {
		val toPropertyUuid = propertyIndex.getFieldIndex(toTask, inputParameter)
		val fromPropertyUuid = propertyIndex.getFieldIndex(fromTask, outputParameter)

		val uuid = getKey(fromPropertyUuid)

		keyMap.put(toPropertyUuid, uuid)
		keyMap.put(fromPropertyUuid, uuid)
	}

	override toString() {
		val StringConcatenation sb = ''''''
		keyMap.forEach [ p1, p2 |
			sb.newLine
			sb.append("			[")
			sb.append(p1)
			sb.append(", ")
			sb.append(p2)
			sb.append("]")
		]
		valueMap.forEach [ p1, p2 |
			sb.newLine
			sb.append("				[")
			sb.append(p1)
			sb.append(", ")
			sb.append(p2)
			sb.append("]")
		]
		sb.toString
	}

}