defmodule TemporaryHack.PortfolioTest do
  use TemporaryHack.DataCase

  alias TemporaryHack.Portfolio

  describe "projects" do
    alias TemporaryHack.Portfolio.Project

    import TemporaryHack.PortfolioFixtures

    @invalid_attrs %{github_repo: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Portfolio.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Portfolio.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{github_repo: "some github_repo"}

      assert {:ok, %Project{} = project} = Portfolio.create_project(valid_attrs)
      assert project.github_repo == "some github_repo"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portfolio.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{github_repo: "some updated github_repo"}

      assert {:ok, %Project{} = project} = Portfolio.update_project(project, update_attrs)
      assert project.github_repo == "some updated github_repo"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Portfolio.update_project(project, @invalid_attrs)
      assert project == Portfolio.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Portfolio.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Portfolio.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Portfolio.change_project(project)
    end
  end
end
