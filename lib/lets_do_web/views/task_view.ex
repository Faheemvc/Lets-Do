# defmodule LetsDoWeb.TaskView do
#   use LetsDoWeb, :view


#   def count_tasks(completed, tasks) do
#     tasks
#     |> Enum.count(fn task -> task.completed == completed end)
#   end

#   def filter_tasks(params, tasks) do
#     if Enum.empty?(params) do
#       tasks
#     else
#       filter_tasks(params, tasks)
#       completed = String.to_existing_atom(params["completed"])

#       tasks
#       |> Enum.filter(fn task -> task.completed == completed end)
#     end
#   end
# end
