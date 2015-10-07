Clear task schduler

Narrative:
In order to remove all subtask from schediler
As a task designer
I want to clear the scheduler

Meta:
@author Shishkin Dmitriy

Scenario: Clearing scheduler schould set to zero subtasks list size
Given a scheduler
And scheduler have <size> subtasks
When clear scheduler
Then scheduler contains 0 subtasks
Examples:
|size		|
|100		|
|10			|
|5			|
|2			|
|1			|

Scenario: Clearing scheduler schould change state to UNKNOWN
Given a scheduler
And scheduler have 10 subtasks
And scheduler have <state> state
When clear scheduler
Then scheduler have UNKNOWN state
Examples:
|state		|
|READY		|
|UNKNOWN	|
|WORKING	|
|BLOCKED	|
|SUCCESS	|
|FAILED		|
