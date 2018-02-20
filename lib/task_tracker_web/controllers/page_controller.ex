defmodule TaskTrackerWeb.PageController do
  use TaskTrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  '''
  def tasks(conn, __param) do
    tasks = TaskTracker.Tasks.list_tasks()
    changeset = TaskTracker.Tasks.change_task(%TaskTracker.Tasks.Task{})
    render conn, "tasks.html", tasks: tasks, changeset: changeset
  end
  '''
end
