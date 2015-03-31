package ru.agentlab.maia.agent

import ru.agentlab.maia.platform.IPlatformId

class MaiaIdHelperService {
	
	def IPlatformId getPlatformId(IAgentId agentId){
		return agentId?.containerId?.platformId
	}
}