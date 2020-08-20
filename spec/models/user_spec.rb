require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password)}
    it { should validate_presence_of(:password_confirmation)}
    it { should validate_presence_of(:first_name)}
    it { should validate_presence_of(:last_name)}
  end

  # describe "relationships" do
  #   it {should have_many :items}
  #   it {should have_many :bids}
  # end
end
