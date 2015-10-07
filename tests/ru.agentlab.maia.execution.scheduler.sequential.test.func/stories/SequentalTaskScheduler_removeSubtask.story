Sequential Task Schduler Remove Subtask

Narrative:
In order to communicate effectively to the business some functionality
As a HTN user
I want to remove wrong subtasks from compound task

Meta:
@author Shishkin Dmitriy

Scenario: Removing existing subtask from scheduler schould decrease subtasks list size
Given a scheduler
And scheduler have <size> subtasks
When remove existing subtask
Then scheduler contains <sizeAfter> subtasks
Examples:
|size		|sizeAfter	|
|100		|99			|
|10			|9			|
|5			|4			|
|2			|1			|
|1			|0			|

Scenario: Remove unknown subtask from scheduler should unchange subtask list
Given a scheduler
And scheduler have <size> subtasks
When remove unknown subtask
Then scheduler contains <size> subtasks
Examples:
|size		|
|100		|
|10			|
|5			|
|2			|
|1			|
|0			|

Scenario: Removing last subtask from scheduler schould change state to UNKNOWN, in other states should not change
Given a scheduler
And scheduler have <size> subtasks
And scheduler have <state> state
When remove existing subtask
Then scheduler is in <stateAfter> state
Examples:
|size	|state		|stateAfter	|
|5		|READY		|READY		|
|5		|UNKNOWN	|UNKNOWN	|
|5		|WORKING	|WORKING	|
|5		|BLOCKED	|BLOCKED	|
|5		|SUCCESS	|SUCCESS	|
|5		|FAILED		|FAILED		|

|1		|READY		|UNKNOWN	|
|1		|UNKNOWN	|UNKNOWN	|
|1		|WORKING	|UNKNOWN	|
|1		|BLOCKED	|UNKNOWN	|
|1		|SUCCESS	|UNKNOWN	|
|1		|FAILED		|UNKNOWN	|
