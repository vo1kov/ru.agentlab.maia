package ru.agentlab.maia.behaviour

import java.util.Map
import java.util.UUID

interface IBehaviourRegistry {

	/**
	 * Register UUID-task pair.
	 * 
	 * @param uuid			unique id of task
	 * @param task			task object 
	 */
	def IBehaviour put(UUID uuid, IBehaviour task)

	/**
	 * Retrieve task object by UUID.
	 * 
	 * @param uuid			unique id of task
	 * @return				task object with specified UUID
	 */
	def IBehaviour get(UUID uuid)

	/**
	 * Unregister UUID-task pair by UUID.
	 * 
	 * @param uuid			unique id of task
	 * @return				removed task object with specified UUID
	 */
	def IBehaviour remove(UUID uuid)

	def Map<UUID, IBehaviour> getMap()

}
