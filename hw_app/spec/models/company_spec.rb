require 'spec_helper'

describe Company do
  before do
    @user = User.create
    @company = Company.create
    @company.grant_user_role(@user, 'admin')
    @company2 = @company.children.create
  end
  it 'gets a users role from its parent, if it has no roles' do
    expect(@company2.role_for_user(@user)).to eq('admin')
  end

  it 'over rides a parents role for a user if it provides its own role' do
    @company2.grant_user_role(@user, 'denied')
    expect(@company2.role_for_user(@user)).to eq('denied')
  end

  it 'should return nil if no company in the chain has a role' do
    user2 = User.new
    expect(@company2.role_for_user(user2)).to be_nil
  end

  it 'should correctly return number of parents' do
    expect(@company.number_of_parents).to eq(0)
    expect(@company.number_of_parents).to eq(1)
  end

end
