defmodule LetsDoWeb.TaskController do
  use LetsDoWeb, :controller

  alias LetsDo.Tasks
  alias LetsDo.Tasks.Task

  def index(conn, _params) do
    changeset = Tasks.change_task(%Task{})

    conn
    |> assign(:changeset, changeset)
    |> assign(:tasks, Tasks.list_tasks())
    |> render(:index)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, :edit, task: task, changeset: changeset)
  end

  def complete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, completed?(task.completed)) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task marked as completed.")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, "Failed to mark task as completed.")
        |> redirect(to: ~p"/")
    end
  end

  defp completed?(false), do: %{completed: true}
  defp completed?(true), do: %{completed: false}

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: ~p"/")
  end

  def clear(conn, _params) do
    Tasks.clear()

    redirect(conn, to: ~p"/")
  end
end
