Remove subtask from scheduler

Meta:
@author Shishkin Dmitriy

Narrative:
In order to change subtasks of scheduler
As a task designer
I want to remove some subtasks from the scheduler

Scenario: Remove existing subtask from scheduler
Meta:
@flow default
Given a scheduler
And scheduler have <size> subtasks
When remove existing subtask
Then scheduler have <sizeAfter> subtasks
Examples:
|size	|sizeAfter	|
|100	|99			|
|10		|9			|
|5		|4			|
|2		|1			|
|1		|0			|

Scenario: Remove unknown subtask from scheduler
Meta:
@flow A1
Given a scheduler
And scheduler have <size> subtasks
When remove unknown subtask
Then scheduler have <size> subtasks
Examples:
|size	|
|100	|
|10		|
|5		|
|2		|
|1		|
|0		|

Scenario: Remove non last subtask from scheduler
Meta:
@flow A2
Given a scheduler
And scheduler have 5 subtasks
And scheduler have <state> state
When remove existing subtask
Then scheduler have <state> state
Examples:
|state	|
|READY	|
|UNKNOWN|
|WORKING|
|BLOCKED|
|SUCCESS|
|FAILED	|

Scenario: Remove last subtask from scheduler
Meta:
@flow A3
Given a scheduler
And scheduler have 1 subtasks
And scheduler have <state> state
When remove existing subtask
Then scheduler have UNKNOWN state
Examples:
|state	|
|READY	|
|UNKNOWN|
|WORKING|
|BLOCKED|
|SUCCESS|
|FAILED	|
