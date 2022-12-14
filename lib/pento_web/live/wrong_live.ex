defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, session, socket) do
    answer = 1..10 |> Enum.random()

    {
      :ok,
      assign(
        socket,
        answer: answer,
        score: 0,
        message: "Make a guess:",
        session_id: session["live_socket_id"]
      )
    }
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %><br />
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n} phx-value-answer={@answer}><%= n %></a>
      <% end %>
    </h2>
    <pre>
      <%= @current_user.email %>
      <%= @session_id %>
    </pre>
    """
  end

  def handle_event("guess", %{"number" => guess, "answer" => answer} = _data, socket)
      when guess == answer do
    message = "Your guess: #{guess}. Correct!"
    score = socket.assigns.score + 1
    {:noreply, assign(socket, answer: socket.assigns.answer, message: message, score: score)}
  end

  def handle_event("guess", %{"number" => guess} = _data, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again."
    score = socket.assigns.score - 1
    {:noreply, assign(socket, answer: socket.assigns.answer, message: message, score: score)}
  end
end
