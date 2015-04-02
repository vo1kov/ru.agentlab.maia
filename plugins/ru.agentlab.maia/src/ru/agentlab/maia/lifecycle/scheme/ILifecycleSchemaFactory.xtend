package ru.agentlab.maia.lifecycle.scheme

import ru.agentlab.maia.lifecycle.scheme.ILifecycleScheme

interface ILifecycleSchemaFactory {

	def ILifecycleScheme createSchema()

}