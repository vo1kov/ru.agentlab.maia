package ru.agentlab.maia.behaviour

interface IBehaviour {

	val static String KEY_STATE = "behaviour.state"

	val static String KEY_NAME = "behaviour.name"

	/**
	 *  A constant identifying the runnable state.
	 */
	val static String STATE_READY = "READY"

	/**
	 *  A constant identifying the blocked state.
	 */
	val static String STATE_BLOCKED = "BLOCKED"

	/**
	 *  A constant identifying the running state.
	 */
	val static String STATE_RUNNING = "RUNNING"

	/**
	 *  Runs the behaviour. This abstract method must be implemented by
	 *  <code>Behaviour</code>subclasses to perform ordinary behaviour
	 *  duty. An agent schedules its behaviours calling their
	 *  <code>action()</code> method since all the behaviours belonging
	 *  to the same agent are scheduled cooperatively, this method
	 *  <b>must not</b> enter in an endless loop and should return as
	 *  soon as possible to preserve agent responsiveness. To split a
	 *  long and slow task into smaller section, recursive behaviour
	 *  aggregation may be used.
	 *  @see jade.core.behaviours.CompositeBehaviour
	 */
//	def void action()
	
	/**
	 Give a name to this behaviour object.
	 @param name The name to give to this behaviour.
	 */
//	def void setName(String name)
	
	/**
	 Retrieve the name of this behaviour object. If no explicit name
	 was set, a default one is given, based on the behaviour class
	 name.
	 @return The name of this behaviour.
	 */
//	def String getName()
	
	def String getState()

	/**
	 *  Check if this behaviour is done. The agent scheduler calls this
	 *  method to see whether a <code>Behaviour</code> still need to be
	 *  run or it has completed its task. Concrete behaviours must
	 *  implement this method to return their completion state. Finished
	 *  behaviours are removed from the scheduling queue, while others
	 *  are kept within to be run again when their turn comes again.
	 *  @return <code>true</code> if the behaviour has completely executed.
	 */
//	def boolean done()

	/**
	 *  This method is just an empty placeholder for subclasses. It is
	 *  invoked just once after this behaviour has ended. Therefore,
	 *  it acts as an epilog for the task represented by this
	 *  <code>Behaviour</code>.
	 *  <br>
	 *  Note that <code>onEnd</code> is called after the behaviour has been
	 *  removed from the pool of behaviours to be executed by an agent. 
	 *  Therefore calling
	 *  <code>reset()</code> is not sufficient to cyclically repeat the task
	 *  represented by this <code>Behaviour</code>. In order to achieve that, 
	 *  this <code>Behaviour</code> must be added again to the agent 
	 *  (using <code>myAgent.addBehaviour(this)</code>). The same applies to
	 *  in the case of a <code>Behaviour</code> that is a child of a 
	 *  <code>ParallelBehaviour</code>.
	 *  @return an integer code representing the termination value of
	 *  the behaviour.
	 */
//	def int onEnd()

	/**
	 *  This method is just an empty placeholders for subclasses. It is
	 *  executed just once before starting behaviour execution. 
	 *  Therefore, it acts as a prolog to the task
	 *  represented by this <code>Behaviour</code>.
	 */
//	def void onStart()

}
