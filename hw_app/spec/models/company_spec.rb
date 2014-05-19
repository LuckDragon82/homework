require 'spec_helper'

describe Company do
  before do
    @user = User.create
    @company = Company.create(name: 'Root Org')
    @company.grant_user_role(@user, 'admin')
    @company2 = @company.children.create
  end

  describe 'role_for_user' do
    it 'gets a users role from its parent, if it has no roles' do
      expect(@company2.role_for_user(@user)).to eq('admin')
    end

    it 'overrides a parents role for a user if it provides its own role' do
      @company2.grant_user_role(@user, 'denied')
      expect(@company2.role_for_user(@user)).to eq('denied')
    end

    it 'should return nil if no company in the chain has a role' do
      user2 = User.new
      expect(@company2.role_for_user(user2)).to be_nil
    end
  end

  describe 'number_of_parents' do
    it 'should correctly return number of parents' do
      expect(@company.number_of_parents).to eq(0)
      expect(@company2.number_of_parents).to eq(1)
    end
  end

  describe 'create_child_company' do
    it 'should create a new company that is a child of itself' do
      company = @company.create_child_company
      expect(company.parent).to eq(@company)
    end

    it 'should not create a company if it is a leaf (2 down from the root)' do
      company3 = @company2.create_child_company
      expect(company4 = company3.create_child_company).to be_nil
    end
  end

  describe 'grant_user_role' do
    it 'should grant a role for a user in the company if no memberships exist' do
      user = User.new
      @company2.grant_user_role(user, 'admin')
      expect(@company2.role_for_user user).to eq('admin')
    end

    it 'should overwrite an old role if that user already has a membership' do
      @company.grant_user_role(@user, 'denied')
      expect(@company.role_for_user @user).to eq('denied')
    end
  end

end
