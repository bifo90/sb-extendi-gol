require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid if password is not set" do
    user = User.new(email: "test@test.com", password: nil)
    expect(user).not_to be_valid
  end
  it "is not valid without an email" do
    user = User.new(email: nil)
    expect(user).not_to be_valid
  end
  it "is not valid with a 4 chars password" do
    user = User.new(email: "test@test.com", password: "test")
    expect(user).not_to be_valid
  end
end
