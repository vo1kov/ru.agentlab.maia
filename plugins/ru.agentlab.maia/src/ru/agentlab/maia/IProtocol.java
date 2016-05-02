/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import java.util.Collection;
import ru.agentlab.maia.IProtocolParticipant;
import ru.agentlab.maia.IRole;

@SuppressWarnings("all")
public interface IProtocol {
  public abstract IRole getInitiator();
  
  public abstract Collection<IProtocolParticipant> getParticipants();
}
