package ru.agentlab.maia.adapter

import java.util.List

interface IIssueResolver<T> {

	def T resolve(List<IIssue> issues)
}