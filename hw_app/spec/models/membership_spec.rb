require 'spec_helper'

describe Membership do
  before(:each) do
    @user = User.create
    @company = Company.create
  end

  it 'should have a role of: admin user or denied' do
    membership = Membership.new(user: @user, role: 'admin', company: @company)
    expect(membership.valid?).to be true
  end

  it 'should not allow any other role' do
    membership = Membership.new(user: @user, role: 'foo', company: @company)
    expect(membership.valid?).to be false
  end

  it 'should not allow two memberships for the same company and user' do
    Membership.create(user: @user, company: @company, role: 'admin')
    Membership.create(user: @user, company: @company, role: 'admin')
    expect(Membership.count).to eq(1)
  end
end