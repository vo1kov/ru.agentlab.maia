package ru.agentlab.maia.behaviour

/**
 * 
 * @author Dmitry Shishkin
 */
enum BehaviourState {

	/**
	 * <p>Indicate that current node isn't ready for execution by some worker.</p>
	 */
	UNKNOWN,

	/**
	 * <p>Indicate that current node is ready for execution by some worker.</p>
	 */
	READY,

	/**
	 * <p>Indicate that current node is handled by some worker.</p>
	 */
	WORKING,

	/**
	 * <p>Indicate that current node was handled and now is waiting for some external event.</p>
	 */
	BLOCKED,

	/**
	 * <p>Indicate that current node execution was finished successfully.</p>
	 */
	SUCCESS,

	/**
	 * <p>Indicate that current node execution was performed with exception.</p>
	 */
	FAILED
}