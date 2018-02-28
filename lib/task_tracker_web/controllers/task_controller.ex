defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Repo

  require Logger

  def index(conn, _params) do
    cur_user = conn.assigns[:current_user]
    if cur_user do
      cur_user = cur_user |> Repo.preload([:tasks])
      tasks = cur_user.tasks
      if cur_user.manager_part do
          manager_part = cur_user.manager_part |> Repo.preload(:underlings)
          underlings = manager_part.underlings |> Repo.preload(:tasks)
          tasks = tasks ++ (underlings |> Enum.flat_map(&(&1.tasks)))
      end
      tasks = tasks |> Repo.preload(:user)
    else
      tasks = []
    end
    #tasks = Tasks.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    cur_user = conn.assigns[:current_user]
    if cur_user && cur_user.manager_part do
      changeset = Tasks.change_task(%Task{})
      render(conn, "new.html", changeset: changeset)
    else
      conn
      |> put_flash(:error, "Not a manager")
      |> redirect(to: task_path(conn, :index))
    end

  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        if changeset.errors[:user_id] != nil do
          err = changeset.errors[:user_id] |> elem(0)
          changeset = changeset |> Ecto.Changeset.add_error(:user_name, err)
        end
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
            |> Repo.preload([:time_blocks, :user])
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    task = task |> Map.put(:user_name, task.user.name)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        Logger.debug(inspect(changeset.errors))
        if changeset.errors[:user_id] != nil do
          err = changeset.errors[:user_id] |> elem(0)
          changeset = changeset |> Ecto.Changeset.add_error(:user_name, err)
        end
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
