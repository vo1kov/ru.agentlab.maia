package ru.agentlab.maia.task

interface ITaskRegistry {
	
	/**
	 * Register UUID-task pair.
	 * 
	 * @param uuid			unique id of task
	 * @param task			task object 
	 */
	def void put(String uuid, ITask task)
	
	/**
	 * Retrieve task object by UUID.
	 * 
	 * @param uuid			unique id of task
	 * @return				task object with specified UUID
	 */
	def ITask get(String uuid)
	
	/**
	 * Unregister UUID-task pair by UUID.
	 * 
	 * @param uuid			unique id of task
	 * @return				removed task object with specified UUID
	 */
	def ITask remove(String uuid)

}
