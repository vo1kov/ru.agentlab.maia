package ru.agentlab.maia.context.injector.e4

import java.util.ArrayList
import java.util.Collection
import java.util.Set
import java.util.UUID
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import ru.agentlab.maia.context.IMaiaContext

class E4MaiaContext implements IMaiaContext {

	package IEclipseContext context

	var String uuid

	@Inject
	new(IEclipseContext context) {
		this.context = context
		uuid = UUID.randomUUID.toString
	}

	override getParent() {
		return get(KEY_PARENT_CONTEXT) as IMaiaContext
	}

	override getChilds() {
		var result = getLocal(KEY_CHILD_CONTEXTS) as Collection<IMaiaContext>
		if (result == null) {
			result = new ArrayList<IMaiaContext>
			set(KEY_CHILD_CONTEXTS, result)
		}
		return result
	}

	override get(String name) {
		if (IEclipseContext.name.equalsIgnoreCase(name)) {
			return context
		}
		return context.get(name)
	}

	override <T> get(Class<T> clazz) {
		if (clazz == IEclipseContext) {
			return context as T
		}
		return context.get(clazz)
	}

	override getLocal(String name) {
		if (IEclipseContext.name.equalsIgnoreCase(name)) {
			return context
		}
		return context.getLocal(name)
	}

	override <T> getLocal(Class<T> clazz) {
		if (clazz == IEclipseContext) {
			return context as T
		}
		return context.getLocal(clazz)
	}

	override remove(String name) {
		context.remove(name)
	}

	override remove(Class<?> clazz) {
		context.remove(clazz)
	}

	override set(String name, Object value) {
		context.set(name, value)
	}

	override <T> set(Class<T> clazz, T value) {
		context.set(clazz, value)
	}

	override toString() {
		context.toString
	}

	override String dump() {
		val list = (context as EclipseContext).localData.keySet
//		.filter [
//			it != "org.eclipse.e4.core.internal.contexts.ContextObjectSupplier" && // it != "ru.agentlab.maia.context.IMaiaContext" && 
//			it != "debugString" && it != "parentContext"
//		]
		.sortWith [ a, b |
			a.compareTo(b)
		]
		// val instr = Instrumentation.
		val res = '''
			{
				"name" : "«this.toString»",
				"services" : [
					«FOR p1 : list SEPARATOR ","»
						«val value = (context as EclipseContext).localData.get(p1)»
						{
							"key" : "«p1»",
							"value" : "«IF value != null»«value.class.name + "@" + Integer.toHexString(System.identityHashCode(value))»«ENDIF»"
«««							"type" : "«value?.class?.name»"«IF value != null && !value.class.isPrimitive && value.class != String»,
«««								"fields" : [
«««									«FOR field : value.class.declaredFields SEPARATOR ","»
«««										{
«««											"name" : "«field.name»",
«««											«field.setAccessible(true)»
«««											«val fieldValue = field.get(value)»
«««											"value" : "«IF fieldValue != null»«fieldValue.class.name + "@" + Integer.toHexString(System.identityHashCode(fieldValue))»«ELSE»null«ENDIF»"
«««										}
«««									«ENDFOR»
«««								]
«««							«ENDIF»
						}
					«ENDFOR»
				]
			}
		'''
		println(res)
//		var StringConcatenation result = ''''''
//		result.newLine
//		var current = this
//		while (current != null) {
//			result.append(
//			'''
//				
//			''')
//			result.newLine
//
//			for (p1 : list) {
//				
//				result.append(
//				'''
//					
//				''')
//			}
//			result.append(
//			'''
//					]
//				}
//			''')
//			current = current.parent  as E4MaiaContext
//		}
		return res.toString
	}

	override Set<String> getKeySet() {
		val Set<String> result = (context as EclipseContext).localData.keySet
		return result
	}

	override getUuid() {
		return uuid
	}

}
