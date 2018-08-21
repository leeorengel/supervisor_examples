defmodule SupervisorExamples do
  use Application

  alias SupervisorExamples.GenServerModule
  alias SupervisorExamples.NonGenServerModule
  alias SupervisorExamples.NonGenServerModule2
  alias SupervisorExamples.NonGenServerModule3
  alias SupervisorExamples.NonGenServerModule4

  alias SupervisorExamples.ModuleBasedSupervisor

  @doc"""
  NOTE: size of list passed to start func corresponds to arity of function!
  If you want to call a function of arity 1 which takes a list as arg you must
  so pass it as an arg. E.g. {Module, [[arg1, arg2, ...]]}
  """
  def start(_type, _args) do
    Supervisor.start_link(
      [
        NonGenServerModule,

        # launch another instance of NonGenServerModule, but with another ID
        Supervisor.child_spec(NonGenServerModule, id: "#{NonGenServerModule}-two"),

        # Relies on having a child_spec definition inside NonGenServerModule2
        {NonGenServerModule2, []},

        # calling start function with arity 3
        {NonGenServerModule3, [1, 2, 3]},

        # passing in a raw child_spec matching what you would return if you implemented
        # a child spec in the module
        %{
          # launch instance of NonGenServerModule2, but with another ID
          id: "#{NonGenServerModule2}-three",
          # the size of args here will correspond to the arity of the start function!
          # if you pass it an empty list, it will look for my_start_func/0 function!
          start: {NonGenServerModule2, :my_start_func, [[]]},
          type: :worker,
          restart: :transient
        },

        # passing in a raw child_spec matching what you would return if you implemented
        # a child spec in the module
        %{
          # launch instance of NonGenServerModule2, but with another ID
          id: NonGenServerModule4,
          # the size of args here will correspond to the arity of the start function!
          # if you pass it an empty list, it will look for my_start_func/0 function!
          start: {NonGenServerModule4, :my_start_func, [[]]},
          type: :worker,
          restart: :transient
        },

        # a gen server module will wrap whatever args you pass in a list so it can
        # be passed to start_link/1
        {GenServerModule, [1, 2, 3]},

        # Supervisor as a child
        ModuleBasedSupervisor,
      ],
      [strategy: :one_for_all, name: MySupervisor]
    )
  end
end
