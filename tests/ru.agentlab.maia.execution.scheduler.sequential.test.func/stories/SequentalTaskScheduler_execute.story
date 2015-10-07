Execute scheduler

Narrative:
In order to communicate effectively to the business some functionality
As a HTN user
I want to remove wrong subtasks from compound task

Meta:
@author Shishkin Dmitriy

Scenario: Executing task scheduler schould change state
Given a scheduler
And scheduler subtasks states are <subtasks>
When execute scheduler <step> times
Then scheduler have <state> state
Examples:
|subtasks					|step	|state	|
|WORKING					|1		|WORKING|
|BLOCKED					|1		|BLOCKED|
|FAILED						|1		|FAILED	|
|SUCCESS					|1		|SUCCESS|

|WORKING, SUCCESS			|1		|WORKING|
|BLOCKED, SUCCESS			|1		|BLOCKED|
|FAILED,  SUCCESS			|1		|FAILED	|

|SUCCESS, WORKING			|2		|WORKING|
|SUCCESS, BLOCKED			|2		|BLOCKED|
|SUCCESS, FAILED			|2		|FAILED	|
|SUCCESS, SUCCESS			|2		|SUCCESS|

|WORKING, SUCCESS, SUCCESS	|1		|WORKING|
|BLOCKED, SUCCESS, SUCCESS	|1		|BLOCKED|
|FAILED,  SUCCESS, SUCCESS	|1		|FAILED	|

|SUCCESS, WORKING, SUCCESS	|2		|WORKING|
|SUCCESS, BLOCKED, SUCCESS	|2		|BLOCKED|
|SUCCESS, FAILED,  SUCCESS	|2		|FAILED	|

|SUCCESS, SUCCESS, WORKING	|3		|WORKING|
|SUCCESS, SUCCESS, BLOCKED	|3		|BLOCKED|
|SUCCESS, SUCCESS, FAILED	|3		|FAILED	|
|SUCCESS, SUCCESS, SUCCESS	|3		|SUCCESS|
