package org.maia.task.scheduler.scheme

import java.util.Collection

interface IBehaviourSchemeRegistry {

	def IBehaviourScheme getDefaultScheme()

	def Collection<IBehaviourScheme> getSchemes()

}