/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.organization;

import java.util.Collection;

@SuppressWarnings("all")
public interface IProtocol {
  public abstract Object getInitiator();
  
  public abstract Collection<IProtocolParticipant> getParticipants();
}
