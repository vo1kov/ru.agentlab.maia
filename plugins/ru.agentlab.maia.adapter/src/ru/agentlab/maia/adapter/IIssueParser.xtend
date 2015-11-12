package ru.agentlab.maia.adapter

import java.util.List

interface IIssueParser<F> {

	def List<IIssue> parse(F input)

}