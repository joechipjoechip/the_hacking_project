class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def edit
  end

  def show
    @student = Students.find(params[:id])
  end

  def create
  end

  def new
  end

  def destroy
  end
end
