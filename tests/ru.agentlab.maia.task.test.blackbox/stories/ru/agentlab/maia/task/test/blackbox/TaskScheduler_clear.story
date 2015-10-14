Clear task schduler

Meta:
@author Shishkin Dmitriy

Narrative:
In order to remove all subtask from schediler
As a task designer
I want to clear the scheduler

Scenario: Clear scheduler
Meta:
@flow default
Given a scheduler
And scheduler have <size> subtasks
And scheduler have <state> state
When clear scheduler
Then scheduler have 0 subtasks
And scheduler have UNKNOWN state
Examples:
|size		|state		|
|100		|READY		|
|100		|UNKNOWN	|
|100		|WORKING	|
|100		|BLOCKED	|
|100		|SUCCESS	|
|100		|FAILED		|

|1			|READY		|
|1			|UNKNOWN	|
|1			|WORKING	|
|1			|BLOCKED	|
|1			|SUCCESS	|
|1			|FAILED		|

|0			|UNKNOWN	|
