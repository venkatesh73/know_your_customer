defmodule KYCWeb.IndexLive do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias KYC.Users

  def mount(_session, _params, socket) do
    {:ok, socket}
  end

  def handle_info() do
  end

  def handle_event("submit", %{"sign_in" => form}, socket) do
    case Users.sign_in(form) do
      {:ok, _changeset} ->
        {:noreply, socket}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end
end