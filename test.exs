alias TaskTracker.{Repo, Accounts, Tasks}
alias Accounts.{User, Manager}
alias Tasks.{Task, TimeBlock}
require Logger

t1 = Repo.get_by(Task, id: 1) |> Repo.preload([:user, :time_blocks])


Logger.debug(inspect(t1.time_blocks))
