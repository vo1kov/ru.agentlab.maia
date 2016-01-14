package ru.agentlab.maia.behaviour

import java.util.ArrayList
import java.util.List
import java.util.UUID
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.IBehaviour

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

}
