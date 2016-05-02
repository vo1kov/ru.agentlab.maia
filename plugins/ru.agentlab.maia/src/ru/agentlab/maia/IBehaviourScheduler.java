/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import ru.agentlab.maia.IBehaviour;

/**
 * <p>Execution node than delegate execution to one of subtasks.</p>
 * 
 * <h2>Child state change notification</h2>
 * <p>After executing any subtask scheduler should know a new state of
 * that node for further scheduling. For this purpose child should notify
 * its parent about changing its state.</p>
 * 
 * <p>There are possible notifications:</p>
 * <ul>
 * <li>{@link #notifyChildSuccess() notifyChildSuccess()} - when node finished
 * successfully.</li>
 * <li>{@link #notifyChildBlocked() notifyChildBlocked()} - when node wait
 * some external event for continue.</li>
 * <li>{@link #notifyChildFailed() notifyChildFailed()} - when node finished
 * with some exception.</li>
 * <li>{@link #notifyChildWorking() notifyChildWorking()} - when node still working
 * and need more iterations to complete the task.</li>
 * <li>{@link #notifyChildReady(ITask) notifyChildReady()} -
 * when node became ready for execution.</li>
 * </ul>
 * 
 * <h2>Reacting on child notifications</h2>
 * <p>Depending on the requirements of scheduler behavior there are some
 * possible variants of reacting on child notification. Reactions are configured
 * for every scheduler instance by {@link Policy Policy} - some flag indicating
 * how exactly react on child notification.</p>
 * 
 * @author Dmitry Shishkin
 */
@SuppressWarnings("all")
public interface IBehaviourScheduler extends IBehaviour {
  /**
   * Get all subtasks.
   * 
   * @return					all subtasks as Iterable.
   */
  public abstract Iterable<IBehaviour> getChilds();
  
  /**
   * Add specified task as subtask of current scheduler.
   * 
   * @param task				task to be added.
   * @throws					NullPointerException
   * 							if task argument is {@code null}.
   */
  public abstract boolean addChild(final IBehaviour child);
  
  /**
   * Remove specified task from subtasks list.
   * 
   * @param task				task to be removed.
   * @return					boolean flag of removing.
   * @throws					NullPointerException
   * 							if task argument is {@code null}.
   */
  public abstract boolean removeChild(final IBehaviour child);
  
  /**
   * Remove all childs
   */
  public abstract void clear();
}
