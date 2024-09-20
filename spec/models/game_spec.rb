require 'rails_helper'

RSpec.describe Game, type: :model do
  before(:each) do
    @user = User.create!(email: "test@test.com", password: "password")
  end
  it "is invalid if user is missing" do
    game = Game.new(
      rows: 4,
      columns: 4,
      matrix: '[["*","*","*","*"],["*","*","*","*"],["*","*","*","*"],["*","*","*","*"]]',
      user_id: nil
    )
    expect(game).not_to be_valid
  end
  it "is invalid if rows are missing" do
    game = Game.new(
      rows: nil,
      columns: 4,
      matrix: '[["*","*","*","*"],["*","*","*","*"],["*","*","*","*"],["*","*","*","*"]]',
      user_id: @user.id
    )
    expect(game).not_to be_valid
  end
  it "is invalid if matrix and rows are incoherent" do
    game = Game.new(
      rows: 10,
      columns: 4,
      matrix: '[["*","*","*","*"],["*","*","*","*"],["*","*","*","*"],["*","*","*","*"]]',
      user_id: @user.id
    )
    expect(game).not_to be_valid
  end
  it "fails if matrix does not contains any other characters than* or ." do
    game = Game.new(
      rows: 10,
      columns: 4,
      matrix: '[["1","*","*","*"],["*","*","*","*"],["*","*","*","*"],["*","*","*","*"]]',
      user_id: @user.id
    )
    expect(game).not_to be_valid
  end
end
