package ru.agentlab.maia.execution

/**
 * Class that represent exception handling.
 */
class ExceptionHandling {

	/**
	 * Not change scheduler state if one of child nodes fails. 
	 */
	val public static byte SKIP = 0 as byte

	/**
	 * Block scheduler if one of child nodes fails.
	 */
	val public static byte BLOCK = IExecutionNode.BLOCKED as byte

	/**
	 * Fail scheduler if one of child nodes fails.
	 */
	val public static byte FAIL = IExecutionNode.EXCEPTION as byte

	/**
	 * Successfully finish scheduler if one of child nodes fails
	 */
	val public static byte SUCCESS = IExecutionNode.SUCCESS as byte

	/**
	 * Delete scheduler if one of child nodes fails
	 */
	val public static byte DELETE = (-100) as byte

	/**
	 * Restart scheduler if one of child nodes fails
	 */
	val public static byte RESTART = (100) as byte

}