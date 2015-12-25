package ru.agentlab.maia.behaviour

import java.util.ArrayList
import java.util.List
import java.util.UUID
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * 
 * @author Dmitry Shishkin
 */
@Accessors
abstract class Behaviour implements IBehaviour {

	val UUID uuid = UUID.randomUUID

	val List<Parameter<?>> inputs = new ArrayList<Parameter<?>>

	val List<Parameter<?>> outputs = new ArrayList<Parameter<?>>

	val List<Exception<?>> exceptions = new ArrayList<Exception<?>>

	var protected State state = State.UNKNOWN

	/**
	 * Add Input Parameter to behaviour 
	 */
	override void addInput(Parameter<?> parameter) {
		inputs += parameter
	}

	/**
	 * Add Output Parameter to behaviour 
	 */
	override void addOutput(Parameter<?> parameter) {
		outputs += parameter
	}

	/**
	 * Add Exception to behaviour 
	 */
	override addException(Exception<?> exception) {
		exceptions += exception
	}

	/**
	 * Remove Input Parameter from behaviour
	 */
	override removeInput(Parameter<?> parameter) {
		inputs -= parameter
	}

	/**
	 * Remove Output Parameter from behaviour
	 */
	override removeOutput(Parameter<?> parameter) {
		outputs -= parameter
	}

	/**
	 * Remove Exception from behaviour
	 */
	override removeException(Exception<?> exception) {
		exceptions -= exception
	}

	/**
	 * Remove all Inputs from behaviour
	 */
	override clearInputs() {
		inputs.clear
	}

	/**
	 * Remove all Outputs from behaviour
	 */
	override clearOutputs() {
		outputs.clear
	}

	/**
	 * Remove all Exceptions from behaviour
	 */
	override clearExceptions() {
		exceptions.clear
	}

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
