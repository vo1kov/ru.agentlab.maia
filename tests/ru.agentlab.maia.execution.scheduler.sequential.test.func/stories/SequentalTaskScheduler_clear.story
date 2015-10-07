Sequential Task Schduler Clear

Narrative:
In order to communicate effectively to the business some functionality
As a HTN user
I want to remove wrong subtasks from compound task

Meta:
@author Shishkin Dmitriy

Scenario: Clearing scheduler schould set to zero subtasks list size
Given a scheduler
And scheduler have <size> subtasks
When clear scheduler
Then scheduler contains <sizeAfter> subtasks
Examples:
|size		|sizeAfter	|
|100		|0			|
|10			|0			|
|5			|0			|
|2			|0			|
|1			|0			|

Scenario: Clearing scheduler schould change state to UNKNOWN
Given a scheduler
And scheduler have 10 subtasks
And scheduler have <state> state
When clear scheduler
Then scheduler is in <stateAfter> state
Examples:
|state		|stateAfter	|
|READY		|UNKNOWN	|
|UNKNOWN	|UNKNOWN	|
|WORKING	|UNKNOWN	|
|BLOCKED	|UNKNOWN	|
|SUCCESS	|UNKNOWN	|
|FAILED		|UNKNOWN	|
