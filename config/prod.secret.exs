use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :task_tracker, TaskTrackerWeb.Endpoint,
  secret_key_base: "HGKV2ebI9IzfPk/YsHVaZHE9DeaDkoTy98EgWrW/n9ywxnrdO5RuP0T5djv47Xam"

# Configure your database
config :task_tracker, TaskTracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "task_tracker_prod",
  pool_size: 15
