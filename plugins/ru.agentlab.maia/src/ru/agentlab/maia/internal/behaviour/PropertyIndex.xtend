package ru.agentlab.maia.internal.behaviour

import java.util.HashMap
import java.util.UUID
import org.eclipse.xtend2.lib.StringConcatenation
import ru.agentlab.maia.TaskOutput
import ru.agentlab.maia.TaskInput

class PropertyIndex {
	
	val public static String DELIMETER = "::"

	val taskMap = new HashMap<Object, UUID>

	val fieldMap = new HashMap<String, UUID>

	def void add(Object task) {
		task.class.declaredFields.forEach [
			task.add(it.name)
		]
	}

	def void add(Object task, String fieldName) {
		val old = taskMap.get(task)
		val taskUuid = if(old != null){
			old
		} else {
			val newUuid = UUID.randomUUID
			taskMap.put(task, newUuid)
			newUuid
		}
		task.class.declaredFields.findFirst[name == fieldName] => [
			val inputAnn = declaredAnnotations.findFirst[it.annotationType == TaskInput]
			val outputAnn = declaredAnnotations.findFirst[it.annotationType == TaskOutput]
			if (inputAnn != null || outputAnn != null) {
				fieldMap.put(taskUuid.toString + DELIMETER + it.name, UUID.randomUUID)
			}
		]
	}

	def UUID getTaskIndex(Object task) {
		taskMap.get(task)
	}

	def UUID getFieldIndex(Object task, String field) {
		val taskUuid = taskMap.get(task)
		return fieldMap.get(taskUuid.toString + DELIMETER + field)
	}

	override toString() {
		val StringConcatenation sb = ''''''
		taskMap.forEach [ p1, p2 |
			sb.newLine
			sb.append("			[")
			sb.append(p1)
			sb.append(", ")
			sb.append(p2)
			sb.append("]")
		]
		fieldMap.forEach [ i1, i2 |
			sb.newLine
			sb.append("			[")
			sb.append(i1)
			sb.append(", ")
			sb.append(i2)
			sb.append("]")
		]
		sb.toString
	}

}