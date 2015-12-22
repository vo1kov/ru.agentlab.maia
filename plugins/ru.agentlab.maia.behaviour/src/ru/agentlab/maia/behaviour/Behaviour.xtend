package ru.agentlab.maia.behaviour

import java.util.ArrayList
import java.util.List
import java.util.UUID

/**
 * 
 * @author Dmitry Shishkin
 */
abstract class Behaviour implements IBehaviour {

	val UUID uuid = UUID.randomUUID

	val List<BehaviourParameter<?>> inputs = new ArrayList<BehaviourParameter<?>>

	val List<BehaviourParameter<?>> outputs = new ArrayList<BehaviourParameter<?>>

	val List<BehaviourException<?>> exceptions = new ArrayList<BehaviourException<?>>

	var protected BehaviourState state = BehaviourState.UNKNOWN

	override final UUID getUuid() {
		return uuid
	}

	override final getState() {
		return state
	}

	override final getInputs() {
		return inputs
	}

	override final getOutputs() {
		return outputs
	}

	override final getExceptions() {
		return exceptions
	}

	/**
	 * Add Input Parameter to behaviour 
	 */
	override void addInput(BehaviourParameter<?> parameter) {
		inputs += parameter
	}

	/**
	 * Add Output Parameter to behaviour 
	 */
	override void addOutput(BehaviourParameter<?> parameter) {
		outputs += parameter
	}

	/**
	 * Add Exception to behaviour 
	 */
	override addException(BehaviourException<?> exception) {
		exceptions += exception
	}

	/**
	 * Remove Input Parameter from behaviour
	 */
	override removeInput(BehaviourParameter<?> parameter) {
		inputs -= parameter
	}

	/**
	 * Remove Output Parameter from behaviour
	 */
	override removeOutput(BehaviourParameter<?> parameter) {
		outputs -= parameter
	}

	/**
	 * Remove Exception from behaviour
	 */
	override removeException(BehaviourException<?> exception) {
		exceptions -= exception
	}

	/**
	 * Remove all Inputs from behaviour
	 */
	override final clearInputs() {
		inputs.clear
	}

	/**
	 * Remove all Outputs from behaviour
	 */
	override final clearOutputs() {
		outputs.clear
	}

	/**
	 * Remove all Exceptions from behaviour
	 */
	override final clearExceptions() {
		exceptions.clear
	}

}
