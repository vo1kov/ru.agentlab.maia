Add subtasks to scheduler

Meta:
@author Shishkin Dmitriy

Narrative:
In order to decompose complex task into parts
As a task designer
I want to add subtasks to the scheduler

Scenario: Add new subtask to scheduler
Meta:
@default
@steps 1->2->3->4->5
Given a scheduler
And scheduler have <size> subtasks
When add new subtask
Then scheduler contains <sizeAfter> subtasks
Examples:
|size	|sizeAfter	|
|100	|101		|
|10		|11			|
|5		|6			|
|2		|3			|
|1		|2			|
|0		|1			|

Scenario: Add existing subtask to scheduler
Given a scheduler
And scheduler have <size> subtasks
When add existing subtask
Then scheduler contains <size> subtasks
Examples:
|size	|
|100	|
|10		|
|5		|
|2		|
|1		|

Scenario: Add subtask to non empty scheduler
Given a scheduler
And scheduler have 5 subtasks
And scheduler have <state> state
When add new subtask
Then scheduler have <state> state
Examples:
|state	|
|READY	|
|UNKNOWN|
|WORKING|
|BLOCKED|
|SUCCESS|
|FAILED	|

Scenario: Add subtask to empty scheduler
Given a scheduler
And scheduler have 0 subtasks
When add new subtask
Then scheduler have READY state
