package ru.agentlab.maia.execution

import java.util.Iterator

interface IExecutionNode {

	/**
	 * Indicate that current node isn't ready for execution by some worker.
	 */
	val public static int UNKNOWN = -1

	/**
	 * Indicate that current node is ready for execution by some worker.
	 */
	val public static int READY = 1

	/**
	 * Indicate that current node is handled by some worker.
	 */
	val public static int IN_WORK = 3

	/**
	 * Indicate that current node was handled and now is waiting for some external event.
	 */
	val public static int WAITING = 5

	/**
	 * Indicate that current node execution was finished.
	 */
	val public static int FINISHED = 11

	/**
	 * Indicate that current node execution was performed with exception.
	 */
	val public static int EXCEPTION = 13

	def void run()

	// --------------------------------------------
	// Parent manipulations
	// --------------------------------------------
	def IExecutionScheduler getParent()

	def void setParent(IExecutionScheduler parent)

	// --------------------------------------------
	// Inputs manipulations
	// --------------------------------------------
	def Iterator<IExecutionInput<?>> getInputs()

	def void addInput(IExecutionInput<?> input)

	def void removeInput(IExecutionInput<?> input)

	def IExecutionInput<?> getInput(String name)

	def void onInputConnected(IExecutionInput<?> param)

	def void onInputDisconnected(IExecutionInput<?> param)

	// --------------------------------------------
	// Outputs manipulations
	// --------------------------------------------
	def Iterator<IExecutionOutput<?>> getOutputs()

	def void addOutput(IExecutionOutput<?> output)

	def void removeOutput(IExecutionOutput<?> output)

	def IExecutionOutput<?> getOutput(String name)

	def void onOutputConnected(IExecutionOutput<?> param)

	def void onOutputDisconnected(IExecutionOutput<?> param)

	// --------------------------------------------
	// State manipulations
	// --------------------------------------------
	def String getStateName()
	
	def void changeStateUnknown(boolean propagate)

	def void changeStateReady(boolean propagate)

	def void changeStateInWork(boolean propagate)

	def void changeStateWaiting(boolean propagate)

	def void changeStateFinished(boolean propagate)

	def void changeStateException(boolean propagate)

	def boolean isStateUnknown()

	def boolean isStateReady()

	def boolean isStateInWork()

	def boolean isStateWaiting()

	def boolean isStateFinished()

	def boolean isStateException()

}