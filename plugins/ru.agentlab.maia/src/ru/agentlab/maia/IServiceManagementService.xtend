package ru.agentlab.maia

import org.eclipse.e4.core.contexts.IEclipseContext

interface IServiceManagementService {

	def <T> void moveFromRoot(IEclipseContext context, Class<T> serviceClass) throws IllegalStateException

	def <T> void copyFromRoot(IEclipseContext context, Class<T> serviceClass) throws IllegalStateException

	def <T> void copyFromOsgi(IEclipseContext context, Class<T> serviceClass) throws IllegalStateException

}