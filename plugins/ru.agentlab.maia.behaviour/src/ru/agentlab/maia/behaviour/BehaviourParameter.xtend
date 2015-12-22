package ru.agentlab.maia.behaviour

import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourParameter<T> {

	@Accessors
	val protected String name

	@Accessors
	val protected Class<T> type

	val protected reference = new AtomicReference<AtomicReference<T>>

	val protected boolean isOptional

	def isOptional() {
		return isOptional
	}

	new(String name, Class<T> type, boolean isOptional) {
		this.name = name
		this.type = type
		this.isOptional = isOptional
	}

	new(String name, Class<T> type) {
		this(name, type, false)
	}

	def setValue(T v) {
		reference.get?.set(v)
	}

	def getValue() {
		reference.get?.get
	}

	def getReference() {
		return reference.get
	}

	def link(BehaviourParameter<T> param) {
//		reference.set(param.reference)
	}

	def unlink() {
		reference.set(new AtomicReference<T>(null))
	}

}