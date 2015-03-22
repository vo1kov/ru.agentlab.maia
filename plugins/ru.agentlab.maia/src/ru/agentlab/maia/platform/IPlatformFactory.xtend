package ru.agentlab.maia.platform

interface IPlatformFactory {

	def IPlatform create(String id, Class<?> contributorClass)

}