package ru.agentlab.maia.internal.behaviour

import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.Action

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

class BehaviourTicker extends Behaviour {

	@Inject
	@Named("period")
	@Accessors
	long period

	private long wakeupTime

	private boolean finished = false

	/**
	 * How many ticks were done (i.e. how many times this
	 * behaviour was executed) since the last reset.
	 */
	@Accessors(#[AccessorType.PUBLIC_GETTER])
	private int tickCount = 0

	/**
	 * Given a period P, when fixed period mode is off (default), 
	 * this behaviour will wait for P milliseconds from the end of 
	 * the n-th execution of the onTick() method
	 * to the beginning of the n+1-th execution.   
	 * When fixed period is on, this behaviour will execute the onTick() 
	 * method exactly every P milliseconds.
	 * @param fixedPeriod A boolean value indicating whether the fixed 
	 * period mode must be turned on or off.
	 */
	@Inject
	@Named("fixedPeriod")
	@Accessors
	private boolean fixedPeriod = false

	private long startTime

	override boolean isDone() {
		return finished
	}

	override public void onStart() {
		startTime = System.currentTimeMillis()
		wakeupTime = startTime + period
	}

	override public action() {
		if (startFlag) {
			onStart
			startFlag = false
		}
		// Someone else may have stopped us in the meanwhile
		if (!finished) {
			var blockTime = wakeupTime - System.currentTimeMillis()
			if (blockTime <= 0) {
				// Timeout is expired --> execute the user defined action and
				// re-initialize wakeupTime
				tickCount++

				ContextInjectionFactory.invoke(contributor, Action, context, null)

				val currentTime = System.currentTimeMillis()
				if (fixedPeriod) {
					wakeupTime = startTime + (tickCount + 1) * period
				} else {
					wakeupTime = currentTime + period
				}
				blockTime = wakeupTime - currentTime
			} else {
				// Do nothing
			}
		// Maybe this behaviour has been removed within the onTick() method
//			if (myAgent != null && !finished && blockTime > 0) {
//				block(blockTime)
//			}
		} else {
			// Do nothing
		}
	}

	/**
	 * This method must be called to reset the behaviour and starts again
	 * @param period the new tick time
	 */
	def public void reset(long period) {
		this.reset()
		if (period <= 0) {
			throw new IllegalArgumentException("Period must be greater than 0")
		}
		this.period = period
	}

	/**
	 * This method must be called to reset the behaviour and starts again
	 * @param timeout indicates in how many milliseconds from now the behaviour
	 * must be waken up again. 
	 */
	override public void reset() {
		super.reset
		finished = false
		tickCount = 0
	}

	/**
	 * Make this <code>TickerBehaviour</code> terminate.
	 * Calling stop() has the same effect as removing this TickerBehaviour, but is Thread safe
	 */
	override public void stop() {
		finished = true
//		restart()
	}

}