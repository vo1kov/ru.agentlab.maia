Add subtasks to scheduler

Meta:
@author Shishkin Dmitriy

Narrative:
In order to decompose complex task into parts
As a task designer
I want to add subtasks to the scheduler

Scenario: Add new subtask to scheduler
Meta:
@flow BF
Given a scheduler
And scheduler have <size> subtasks
And scheduler have <state> state
When add new subtask
Then scheduler have <sizeAfter> subtasks
And scheduler have <state> state
Examples:
|size	|state		|sizeAfter	|
|5		|READY		|6			|
|5		|UNKNOWN	|6			|
|5		|WORKING	|6			|
|5		|BLOCKED	|6			|
|5		|SUCCESS	|6			|
|5		|FAILED		|6			|

|1		|READY		|2			|
|1		|UNKNOWN	|2			|
|1		|WORKING	|2			|
|1		|BLOCKED	|2			|
|1		|SUCCESS	|2			|
|1		|FAILED		|2			|

Scenario: Add existing subtask to scheduler
Meta:
@flow A1
Given a scheduler
And scheduler have <size> subtasks
When add existing subtask
Then scheduler have <size> subtasks
Examples:
|size	|
|100	|
|10		|
|5		|
|2		|
|1		|

Scenario: Add subtask to empty scheduler
Meta:
@flow A2
Given a scheduler
And scheduler have 0 subtasks
When add new subtask
Then scheduler have READY state
