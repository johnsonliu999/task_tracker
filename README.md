# TaskTracker V2.0

### Latest Design Strategies

- Task1: Manager

  - Managers & users

    First through the navigation bar enter the `Users` list, the username started with  `#` is a manager. Through the manager's profile, we can get his/her underlings.

  - Assign Tasks

    First log as a manager using the manger's name, then we can get a list of tasks of the manger him/herself and his/her underlings.

    There is a `New Task` button below, which will bring us to a new task form, the manager can assign task through the `select` input, which contains only his/her underlings' names.

    If log as a normal user, there won't be the `New Task` button, and server-side will forbid the access to the form as well.

  - Profile

    Any profile will show their managers and underlings. A normal user don't have underlings but a manager.

  - Reports

    If log as a manager, the navigation bar will show a entrance for reports, which shows a list of tasks assigned to his/her underlings and the status of the tasks.

- Task2

  - TimeBlock Resources

    Created through `mix phx.gen.json`, and fieds `start` and `end`. User can see multiple pairs of them in a certain task detail page and can be edited and deleted by the users.

  - Start & Stop Tasks

    User can start and stop their tasks in the `Tasks` index page, which shows a list of tasks and the `Start` button. After clicking `Start` button, it will turn into a red `Stop` button. After clicking `Stop`, a new record of TimeBlock will be sent to the server which is implemented by jQuery's AJAX function.

#### Last Design Strategy
- User

  - Delete

    When a user is deleted, I used `niltify_all` for the related tasks

  - Create

    User name should be unique by add `unique` when migrate.

- Manager

  - User - Manager one-to-one relationship

    keep a `user_id` as foreign_key, so that the user can be a manager if has_one `manager` field


- Task

  - Assign

    A task is assigned by *user id*. User can only modify the task assigned to themselves. Unlogged user can not modify any task.

- Validation

  The validation happens at `create_task` and `update_task` rather than database, because database will cause a certain amount of lag.

- Displaying Tasks

  On the *tasks list* page, I choose not to display the descriptions, since user can click `Detail` button to know exact what the task is.

- Assigning Tasks

  Each task can be assigned by any member to any member.

- Tracking Time

  Since each button will load a new page and tracking time will modify the `time` field, I decide to redirect to the *task edit* page for tracking time by editing the `time` field.

  To limit the time input, I set the `step`, `min` of the number input, so there is no worry of invalid time input.
