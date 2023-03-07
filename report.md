# FAF.PTR16.1 -- Project 0
> **Performed by:** Moisei Liviu, group FAF-202
> **Verified by:** asist. univ. Alexandru Osadcenco

## P0W1

**Task 1** -- Hello World

```erlang
  def hello() do
    "Hello, PTR!"
  end
```

Simple function that returns a string.

**Task 2** -- Unit test for the function

```erlang
  test "greets the world" do
    assert One.hello() == "Hello, PTR!"
  end
```

Verify the value returned.
## P0W2

**Task 1** -- Write a function that determines whether an input integer is prime.

```erlang
  def is_prime?(n) when n < 2 do
    false
  end

  def is_prime?(n) when n < 4 do
    true
  end

  def is_prime?(n) when n > 1 do
    nums = 2..(n - 1)
    Enum.all?(nums, fn x -> rem(n, x) != 0 end)
  end
```

Here we use function guards, to check if the function should be executed or not, if not the next one bellow will be checked. This is basically a recursive implementation of the Sieve of Eratosthenes algo.

**Task 2** -- Write a function to calculate the area of a cylinder, given it’s height and
radius.

```erlang
  def cylinder_area(h, r) do
    2 * Math.pi * r * (r + h)
  end
```

Using the formula...

**Task 3** -- Write a function to reverse a list.

```erlang
  def reverse_list(list, acc \\ []) do
    case list do
      [] -> acc
      [head | tail] -> reverse_list(tail, [head | acc])
    end
  end
```

Recursively put the tail at the front of the list until we iterate over the entire list.

**Task 4** -- Write a function to calculate the sum of unique elements in a list.

```erlang
  def unique_sum(list) do
    Enum.uniq(list) |> Enum.sum()
  end
```

Using the Enum module we get the unique items and pipe them to the sum function.

**Task 5** -- Write a function that extracts a given number of randomly selected elements
from a list.

```erlang
  def extract_random_list(list, n) do
    Enum.take_random(list, n)
  end
```

Again use the Enum module.

**Task 6** --Write a function that returns the first n elements of the Fibonacci sequence.

```erlang
  def first_fibonacci(n) when n == 1 do
    [1]
  end

  def first_fibonacci(n) when n == 2 do
    [1, 1]
  end

  def first_fibonacci(n) when n > 2 do
    fib = first_fibonacci(n - 1)
    next_number = Enum.at(fib, n - 2) + Enum.at(fib, n - 3)
    fib ++ [next_number]
  end
```

Using recursion and guards, get the n-th fibonacci number.

**Task 7** -- Write a function that, given a dictionary, would translate a sentence. Words
not found in the dictionary need not be translated.

```erlang
  def translate(dictionary, text) do
    Enum.map(text, fn word -> Map.get(dictionary, word, word) end)
  end
```

Use the lambda inside the Enum.map function to translate every word to the corresponding one inside the passed dictionary.

**Task 8** -- Write a function that receives as input three digits and arranges them in an
order that would create the smallest possible number. Numbers cannot start with a 0.

```erlang
  def smallestNumber(a, b, c) do
    list = Enum.sort([a, b, c])
    zeroes = Enum.count(list, &(&1 == 0))
    if zeroes == 3 do
      0
    else
      if zeroes == 2 do
        rotateLeft(list, 2) |> Enum.join()
      end
      if zeroes == 1 do
        Enum.reverse(rotateLeft(list, 2)) |> Enum.join()
      else
        Enum.join(list)
      end
    end
  end

  def rotateLeft(list, n) do
    {left, right} = Enum.split(list, rem(n, length(list)))
    right ++ left
  end
```

First we sort the digits, then we swap their places until the zeroes are positioned properly.

**Task 9** -- Write a function that extracts a given number of randomly selected elements
from a list.

```erlang
  def extract_random_list(list, n) do
    Enum.take_random(list, n)
  end
```

Use the function take_random in the Enum module.

**Task 10** -- Write a function that would rotate a list n places to the left.

```erlang
  def rotateLeft(list, n) do
    {left, right} = Enum.split(list, rem(n, length(list)))
    right ++ left
  end
```

Same function that was used for previous task.

**Task 11** -- Write a function that lists all tuples a, b, c such that a
2+b
2 = c
2 and a, b ≤ 20

```erlang
  def  listRightAngleTriangles do
    Enum.reduce 1..20, [], fn a, acc ->
      Enum.reduce 1..20, acc, fn b, acc ->
        c = Math.sqrt(a*a + b*b)
        if c == trunc(c) do
          [{a, b, trunc(c)} | acc]
        else
          acc
        end
      end
    end
  end
```

Brute force approach, using the Enum.reduce() function.

**Task 12** -- Write a function that would rotate a list n places to the left.

```erlang
  def rotateLeft(list, n) do
    {left, right} = Enum.split(list, rem(n, length(list)))
    right ++ left
  end
```

Same function that was used for previous task.

**Task 13** -- Write a function to find the longest common prefix string amongst a list of
strings.

```erlang
  def common_prefix(strings) do
    Enum.reduce(strings, fn string, acc ->
      if String.starts_with?(string, acc) do
        acc
      else
        common_prefix(string, acc)
      end
    end)
  end

  def common_prefix(string1, string2) do
    <<head1, tail1::binary>> = string1
    <<head2, tail2::binary>> = string2

    if head1 == head2 do
      <<head1>> <> common_prefix(tail1, tail2)
    else
      <<>>
    end
  end
```

Recursive function that appends next character as long as it corresponds to the character in the same position in the other passed string.
**Task 14** -- Write a function to calculate the prime factorization of an integer.

```erlang
  def factorize(n) do
    factorize(n, 2)
  end

  defp factorize(n, i) when n == 1 do
    []
  end

  defp factorize(n, i) do
    if is_prime?(i) && rem(n, i) == 0 do
      [i | factorize(round(n / i), i)]
    else
      factorize(n, i + 1)
    end
  end
```

## Conclusion

In conclusion during this week i wrote my first lines of code in elixir and got my feet wet with the functional paradigm.
## P0W3

**Task 1** -- Create an actor that returns any message it receives, while modifying it. Infer
the modification from the following example:

```erlang
defmodule ModifyActor do
  def start do
    spawn_link(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      msg when is_integer(msg) ->
        new_msg = msg + 1
        IO.puts("Received integer: #{msg}, modified to: #{new_msg}")
        loop()

      msg when is_binary(msg) ->
        new_msg = String.downcase(msg)
        IO.puts("Received string: #{msg}, modified to: #{new_msg}")
        loop()

      msg ->
        IO.puts("Received unknown message: #{inspect(msg)}")
        loop()
    end
  end
end
```

Here we create a process that will continuously listen for input that we filter with guards. Depending on the type of the input we perform different modifications on it and then print it out and continue the loop.

**Task 2** -- Create a two actors, actor one ”monitoring” the other. If the second actor
stops, actor one gets notified via a message.

```erlang
defmodule MonitoringActor do
  def start do
    spawn(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      {:monitoring, pid} ->
        IO.puts("Monitoring...")
        Process.monitor(pid)
        loop()
      {:DOWN, _ref, :process, _obj, reason} ->
        IO.puts("The monitored actor stopped, due to #{reason}.")
    end
  end
end

defmodule MonitoredActor do
  def start do
    spawn(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      {:stop} ->
        IO.puts("Monitored actor received stop message")
        exit(:normal)
    end
    loop()
  end
end
```

Here we use the Process.monitor function that guarantees that we receive a message in the case that the monitored actor gets killed. In the monitored actor we have a loop function that expects a stop message so we can kill it.

**Task 3** -- Create an actor which receives numbers and with each request prints out the
current average.

```erlang
defmodule AverageActor do
  def start do
    spawn(__MODULE__, :loop, [0, 0])
  end

  def loop(sum, count) do
    receive do
      number when is_number(number) ->
        new_sum = sum + number
        new_count = count + 1
        IO.puts("Current average is #{new_sum / new_count}")
        loop(new_sum, new_count)
    end
  end
end
```

The loop function in this case also maintains the state which is the current sum and the count of all the passed numbers so far. When a new number is received, we print the new average and call the loop function with the new state.

**Task 4** -- Create an actor which maintains a simple FIFO queue. You should write helper
functions to create an API for the user, which hides how the queue is implemented.

```erlang
defmodule QueueActor do
  def start do
    spawn(__MODULE__, :loop, [[]])
  end

  def loop(queue) do
    receive do
      {:push, item} ->
        new_queue = queue ++ [item]
        IO.inspect(new_queue)
        loop(new_queue)
      {:pop, pid} ->
        case queue do
          [] -> send(pid, :empty)
          [head | tail] -> send(pid, { :ok, head })
                           IO.inspect(tail)
                           loop(tail)
        end
    end
  end

  def push(pid, item) do
    send(pid, {:push, item})
  end

  def pop(pid) do
    send(pid, {:pop, self()})
    receive do
      result -> result
    end
  end
end
```

For this task we also maintain the state in as a loop function param, but we also have two helper functions that send a message to this actor by pid for adding and removing items from the queue.

## Conclusion

In conclusion during this week I got familiar with the concept of actors and processes, discovered the difference between multithreaded approach and the actors approach, and implemented supervised actors in elixir.

## P0W4

**Task 1** -- Create a supervised pool of identical worker actors. The number of actors
is static, given at initialization. Workers should be individually addressable. Worker actors
should echo any message they receive. If an actor dies (by receiving a “kill” message), it should
be restarted by the supervisor. Logging is welcome.

```erlang
defmodule Worker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def call(pid, msg) do
    GenServer.call(pid, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, msg, state}
  end
end

defmodule Super do
  use Supervisor

  def start_link(num_workers) do
    Supervisor.start_link(__MODULE__, num_workers: num_workers, name: __MODULE__)
    |> elem(1)
  end

  def init(args) do
    children = Enum.map(1..args[:num_workers], fn i ->
      %{
        id: i,
        start: {Worker, :start_link, []}
      }
    end)

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_worker_pid(pid, id) do
    Supervisor.which_children(pid)
    |> Enum.find(fn {i, _, _, _} -> i == id end)
    |> elem(1)
  end

  def count(pid) do
    Supervisor.count_children(pid)
  end
end
```

For this task we use the Supervisor module which allows us to maintain a steady pool of actors. If one of the actors fails or gets killed, a new one is spawned. The actual worker actor uses GenServer module, that allows us to receive sync and async calls in an easier way. 

**Task 2** -- Create a supervised processing line to clean messy strings. The first worker in
the line would split the string by any white spaces (similar to Python’s str.split method).
The second actor will lowercase all words and swap all m’s and n’s (you nomster!). The third
actor will join back the sentence with one space between words (similar to Python’s str.join
method). Each worker will receive as input the previous actor’s output, the last actor printing the result on screen. If any of the workers die because it encounters an error, the whole
processing line needs to be restarted. Logging is welcome.

```erlang
defmodule StringProcessor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
    |> elem(1)
  end

  def init(_) do
    children = [
      %{
        id: :split_worker,
        start: {SplitWorker, :start_link, []}
      },
      %{
        id: :replace_worker,
        start: {ReplaceWorker, :start_link, []}
      },
      %{
        id: :join_worker,
        start: {JoinWorker, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def process(msg) do
    msg
    |> SplitWorker.split()
    |> ReplaceWorker.replace()
    |> JoinWorker.join()
  end
end

defmodule SplitWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def split(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, String.split(msg), state}
  end
end

defmodule ReplaceWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def replace(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    msg = Enum.map(msg, fn word ->
      String.downcase(word)
      |> String.replace("n", "*")
      |> String.replace("m", "n")
      |> String.replace("*", "m")
    end)

    {:reply, msg , state}
  end
end

defmodule JoinWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def join(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, Enum.join(msg, " "), state}
  end
end
```

Here we have a different actor for each step in the pipeline, each actor defines a handle_call function that performs the logic of the pipeline step and returns the processed string.

## P0W3

**Task 1** -- Write an application that would visit this link. Print out the HTTP response
status code, response headers and response body. Extract all quotes from the HTTP
response body. Collect the author of the quote, the quote text and tags. Save the data
into a list of maps, each map representing a single quote. Persist the list of quotes into a file.
Encode the data into JSON format. Name the file quotes.json.

```erlang
defmodule ScrapeQuotes do
  use HTTPoison.Base

  @url "https://quotes.toscrape.com/"

  def start do
    response = get(@url) |> elem(1)
    IO.puts "RESPONSE BODY : #{response.body}"
    quotes = extract_quotes(response.body)
    write_quotes_to_file(quotes)
    IO.puts "Extracted #{length(quotes)} quotes and saved them to quotes.json."
  end

  defp extract_quotes(body) do
    {:ok, doc} = Floki.parse_document(body)
    quotes = Floki.find(doc, ".quote")
    Enum.map(quotes, fn quote ->
      author = Floki.find(quote, ".author") |> hd() |> Floki.text()
      text = Floki.find(quote, ".text") |> hd() |> Floki.text()
      tags = Floki.find(quote, ".tag") |> Enum.map(&Floki.text/1)
      %{author: author, text: text, tags: tags}
    end)
  end

  defp write_quotes_to_file(quotes) do
    File.write("quotes.json", Poison.encode!(quotes))
  end
end
```

For this task i used several third party libraries like Floki and Poison for performing http requests and parsing the response. After that i use the File module to write the parsed results to the file.

**Task 2** -- Write an application that would implement a Star Wars-themed RESTful API.
The API should implement the following HTTP methods:
``
• GET /movies
• GET /movies/:id
• POST /movies
• PUT /movies/:id
• PATCH /movies/:id
• DELETE /movies/:id
``
Use a database to persist your data

```erlang
defmodule StarWarsApi do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: StarWarsApi.Router, options: [port: 8080]},
      {StarWarsApi.Repository, []}
    ]
    opts = [strategy: :one_for_one, name: StarWarsApi.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
end
```

This application starts with the StarWarsApi module that binds all the other modules and components together under one supervisor that will restart all of them if one of the actors dies.

```erlang
defmodule StarWarsApi.Router do
  use Plug.Router

  plug Plug.Parsers,
       parsers: [:urlencoded, :json],
       pass: ["*/*"],
       json_decoder: Jason

  plug :match
  plug :dispatch

  get "/movies" do
    movies = StarWarsApi.Repository.get_all_movies()
    send_resp(conn, 200, Jason.encode!(movies))
  end

  get "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = StarWarsApi.Repository.get_movie(id)
    send_resp(conn, 200, Jason.encode!(movie))
  end

  post "/movies" do
    movie = conn.body_params
    new_movie = StarWarsApi.Repository.create_movie(movie)
    send_resp(conn, 201, Jason.encode!(new_movie))
  end

  put "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = conn.body_params
    new_movie = StarWarsApi.Repository.update_movie(id, movie)
    send_resp(conn, 200, Jason.encode!(new_movie))
  end

  patch "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = conn.body_params
    new_movie = StarWarsApi.Repository.update_movie(id, movie)
    send_resp(conn, 200, Jason.encode!(new_movie))
  end

  delete "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    StarWarsApi.Repository.delete_movie(id)
    send_resp(conn, 204, "")
  end

  match _ do
    send_resp(conn, 404, "Path doesn't exist!")
  end
end
```

The entry point of the app is the Router component which defines all the endpoints that we're going to use. We're using the Plug module, and the plug macros to route and parse the requests. Inside the endpoints definitions we make calls to the StarWarsRepository modules that actually has all the CRUD functionality that we need.

```erlang
defmodule StarWarsApi.Repository do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    :ets.new(:movies_table, [:set, :public, :named_table])
    :ok = load_movies_into_table(:movies_table)
    {:ok, :movies_table}
  end

  defp load_movies_into_table(table) do
    movies = [
      %{
        id: 1,
        title: "Star Wars: Episode IV - A New Hope",
        director: "George Lucas",
        release_year: 1977
      },
      %{
        id: 2,
        title: "Star Wars: Episode V - The Empire Strikes Back",
        director: "Irvin Kershner",
        release_year: 1980
      },
      %{
        id: 3,
        title: "Star Wars: Episode VI - Return of the Jedi",
        director: "Richard Marquand",
        release_year: 1983
      },
      %{
        id: 4,
        title: "Star Wars: Episode I - The Phantom Menace",
        director: "George Lucas",
        release_year: 1999
      },
      %{
        id: 5,
        title: "Star Wars: Episode II - Attack of the Clones",
        director: "George Lucas",
        release_year: 2002
      },
      %{
        id: 6,
        title: "Star Wars: Episode III - Revenge of the Sith",
        director: "George Lucas",
        release_year: 2005
      },
      %{
        id: 7,
        title: "Star Wars: Episode VII - The Force Awakens",
        director: "J.J. Abrams",
        release_year: 2015
      },
      %{
        id: 8,
        title: "Star Wars: Episode VIII - The Last Jedi",
        director: "Rian Johnson",
        release_year: 2017
      },
      %{
        id: 9,
        title: "Star Wars: Episode IX - The Rise of Skywalker",
        director: "J.J. Abrams",
        release_year: 2019
      },
      %{
        id: 10,
        title: "Star Wars: Episode III - Revenge of the Sith",
        director: "George Lucas",
        release_year: 2005
      }
    ]

    Enum.each(movies, fn movie ->
      :ets.insert(table, {movie[:id], movie})
    end)
  end

  def handle_call(:get_all_movies, _from, table) do
    movies = Enum.map(:ets.tab2list(table), fn {key, movie} -> Map.put(movie, :id, key) end)
    {:reply, movies, table}
  end

  def handle_call({:get_movie, id}, _from, table) do
    movies = :ets.lookup(table, id)
    if length(movies) == 0 do
      {:reply, nil, table}
    else
      {key, movie} = List.first(movies)
      {:reply, %{movie | id: key}, table}
    end
  end

  def handle_call({:create_movie, movie}, _from, table) do
    id = :ets.info(table, :size) + 1
    Map.put(movie, :id, id)
    :ets.insert(table, {id, movie})
    {:reply, :ok, table}
  end

  def handle_call({:update_movie, id, movie}, _from, table) do
    :ets.insert(table, {id, movie})
    {:reply, :ok, table}
  end

  def handle_call({:delete_movie, id}, _from, table) do
    :ets.delete(table, id)
    {:reply, :ok, table}
  end

  def get_all_movies do
    GenServer.call(__MODULE__, :get_all_movies)
  end

  def get_movie(id) do
    GenServer.call(__MODULE__, {:get_movie, id})
  end

  def create_movie(movie) do
    GenServer.call(__MODULE__, {:create_movie, movie})
  end

  def update_movie(id, movie) do
    GenServer.call(__MODULE__, {:update_movie, id, movie})
  end

  def delete_movie(id) do
    GenServer.call(__MODULE__, {:delete_movie, id})
  end
end
```

In this module we use the ets in memory data store where we store the movies based with their id as the key. 

## Conclusion

In conclusion during this week I got to implement http requests inside elixir actors, and to create a working api that performs basic CRUD operations.
