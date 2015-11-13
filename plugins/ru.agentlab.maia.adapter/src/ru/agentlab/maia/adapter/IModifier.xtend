package ru.agentlab.maia.adapter

interface IModifier<T> {

	val static final String KEY_TYPE = "type"

	def void modify(T target, Object... objects)

}