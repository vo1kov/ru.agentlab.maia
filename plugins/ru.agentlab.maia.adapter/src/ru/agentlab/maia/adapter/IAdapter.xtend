package ru.agentlab.maia.adapter

interface IAdapter<F, T> {

	val static final String KEY_LANGUAGE = "language"

	def T adapt(F object)

} 