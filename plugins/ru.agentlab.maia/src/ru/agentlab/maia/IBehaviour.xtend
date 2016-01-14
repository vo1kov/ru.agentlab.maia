package ru.agentlab.maia

import java.util.UUID
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * 
 * @author Dmitry Shishkin
 */
interface IBehaviour {

	def UUID getUuid()
	
	/**
	 * <p>Invoke one step of execution of the task.</p>
	 */
	def void execute() throws java.lang.Exception

	/**
	 * <p>Retrieve task state.</p>
	 * 
	 * @return 					task state.
	 */
	def State getState()

	/**
	 * <p>Retrieve all task inputs.</p>
	 * 
	 * @return 					collection of task inputs or
	 * 							{@code null} if task have no inputs.
	 */
	def Iterable<Parameter<?>> getInputs()

	/**
	 * <p>Retrieve all task outputs.</p>
	 * 
	 * @return 					collection of task outputs or
	 * 							{@code null} if task have no outputs.
	 */
	def Iterable<Parameter<?>> getOutputs()

	/**
	 * <p>Add specified parameter as input to task.</p>
	 * 
	 * @param parameter			parameter to be added.
	 */
	def void addInput(Parameter<?> parameter)

	/**
	 * <p>Add specified parameter as output to task.</p>
	 * 
	 * @param parameter			parameter to be added.
	 */
	def void addOutput(Parameter<?> parameter)

	/**
	 * <p>Remove specified parameter from task inputs.</p>
	 * 
	 * @param parameter			parameter to be removed.
	 */
	def void removeInput(Parameter<?> parameter)

	/**
	 * <p>Remove specified parameter from task outputs.</p>
	 * 
	 * @param parameter			parameter to be removed.
	 */
	def void removeOutput(Parameter<?> parameter)

	/**
	 * <p>Remove all parameters from task inputs.</p>
	 */
	def void clearInputs()

	/**
	 * <p>Remove all parameters from task outputs.</p>
	 */
	def void clearOutputs()

	def Iterable<Exception<?>> getExceptions()

	def void addException(Exception<?> exception)

	def void removeException(Exception<?> exception)

	def void clearExceptions()

///**
// * <p>Reset task to initial state.</p>
// */
//	def void reset()

/**
	 * 
	 * @author Dmitry Shishkin
	 */
	static class Parameter<T> {

		@Accessors
		val protected String name

		@Accessors
		val protected Class<T> type

		val transient protected reference = new AtomicReference<AtomicReference<T>>

		val protected boolean isOptional

		def isOptional() {
			return isOptional
		}

		new(String name, Class<T> type, boolean isOptional) {
			this.name = name
			this.type = type
			this.isOptional = isOptional
		}

		new(String name, Class<T> type) {
			this(name, type, false)
		}

		def setValue(T v) {
			reference.get?.set(v)
		}

		def getValue() {
			reference.get?.get
		}

		def getReference() {
			return reference.get
		}

		def link(Parameter<T> param) {
//		reference.set(param.reference)
		}

		def unlink() {
			reference.set(new AtomicReference<T>(null))
		}

	}

	/**
	 * 
	 * @author Dmitry Shishkin
	 */
	static class Exception<T> {

		@Accessors
		val protected Class<T> type

		new(Class<T> type) {
			this.type = type
		}

	}

	/**
	 * 
	 * @author Dmitry Shishkin
	 */
	static enum State {

		/**
		 * Indicate that current node isn't ready for execution by some worker.
		 */
		UNKNOWN,

		/**
		 * Indicate that current node is ready for execution by some worker.
		 */
		READY,

		/**
		 * Indicate that current node is handled by some worker.
		 */
		WORKING,

		/**
		 * Indicate that current node was handled and now is waiting for some external event.
		 */
		BLOCKED,

		/**
		 * Indicate that current node execution was finished successfully.
		 */
		SUCCESS,

		/**
		 * Indicate that current node execution was performed with exception.
		 */
		FAILED
	}
}