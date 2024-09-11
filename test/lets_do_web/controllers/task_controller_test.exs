defmodule LetsDoWeb.TaskControllerTest do
  use LetsDoWeb.ConnCase

  import LetsDo.TasksFixtures

  @create_attrs %{text: "some text", completed: true}
  @update_attrs %{text: "some updated text", completed: false}
  @invalid_attrs %{text: nil, completed: nil}

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get(conn, ~p"/tasks")
      assert html_response(conn, 200) =~ "Todos"
    end
  end

  describe "create task" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/tasks", task: @create_attrs)

      assert redirected_to(conn) == ~p"/"

      conn = get(conn, ~p"/")
      assert html_response(conn, 200) =~ "Todos"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/tasks", task: @invalid_attrs)
      assert html_response(conn, 200) =~ "Todos"
    end
  end

  describe "edit task" do
    setup [:create_task]

    test "renders form for editing chosen task", %{conn: conn, task: task} do
      conn = get(conn, ~p"/tasks/#{task}/edit")
      assert html_response(conn, 200) =~ "Edit Task"
    end
  end

  describe "update task" do
    setup [:create_task]

    test "redirects when data is valid", %{conn: conn, task: task} do
      conn = put(conn, ~p"/tasks/#{task}", task: @update_attrs)
      assert redirected_to(conn) == ~p"/"

      conn = get(conn, ~p"/")
      assert html_response(conn, 200) =~ "some updated text"
    end

    test "renders errors when data is invalid", %{conn: conn, task: task} do
      conn = put(conn, ~p"/tasks/#{task}", task: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Task"
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "deletes chosen task", %{conn: conn, task: task} do
      conn = delete(conn, ~p"/tasks/#{task}")
      assert redirected_to(conn) == ~p"/"

      conn = get(conn, ~p"/")
      refute html_response(conn, 200) =~ task.text
    end
  end

  defp create_task(_) do
    task = task_fixture()
    %{task: task}
  end
end
