class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.to_displayable_list.join("\n")
  end

  def show
    id = params[:id]
    render plain: User.find(id).to_displayable_string
  end

  def update
    id = params[:id]
    completed = params[:completed]
    todo = User.find(id)
    todo.completed = completed
    todo.save!

    render plain: "Update todo completed status #{completed}"
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]

    newUser = User.create!(name: name, email: email, password: password)
    render plain: "Hey, New User is created with the id #{newUser.id}"
  end
  
  def login
    email = params[:email]
    password = params[:password]
    user = User.find_by(email: email, password: password)

    render plain: user.present? 
  end 
end
