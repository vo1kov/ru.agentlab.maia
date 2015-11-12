package ru.agentlab.maia.behaviour

interface IBehaviourRegistry {
	
	/**
	 * Register UUID-task pair.
	 * 
	 * @param uuid			unique id of task
	 * @param task			task object 
	 */
	def void put(String uuid, IBehaviour task)
	
	/**
	 * Retrieve task object by UUID.
	 * 
	 * @param uuid			unique id of task
	 * @return				task object with specified UUID
	 */
	def IBehaviour get(String uuid)
	
	/**
	 * Unregister UUID-task pair by UUID.
	 * 
	 * @param uuid			unique id of task
	 * @return				removed task object with specified UUID
	 */
	def IBehaviour remove(String uuid)

}
