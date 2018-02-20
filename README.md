# TaskTracker

# Design Strategy
- User

  - Delete

    When a user is deleted, I used `niltify_all` for the related tasks

  - Create

    User name should be unique by add `unique` when migrate.

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

# Start Server

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
