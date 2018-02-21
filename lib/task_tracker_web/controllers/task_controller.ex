defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task

  require Logger

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
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
