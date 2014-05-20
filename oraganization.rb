class Organization
  attr_reader :name
  attr_reader :children
  attr_reader :parent
  attr_reader :members
  def initialize(parent = nil, name = nil)
    @parent = parent
    @children = []
    @members = {}
    @name = parent ? name : 'Root Organization'
  end

  def create_child(name = nil)
    if self.org_level < 2
      child_organization = Organization.new(self, name)
      @children << child_organization
      child_organization
    else
      nil
    end
  end

  def org_level
    self.parent.nil? ? 0 : self.parent.org_level + 1
  end

  def grant_user_role(user, role)
    legal_roles = %w(Admin User Denied)
    @members[user] = role if legal_roles.include? role
  end

  def role_for_user(user)
    @members[user] || (self.parent.nil? ? nil : self.parent.role_for_user(user))
  end

end

class User
  attr_reader :name
  def initialize(name = nil)
    @name = name
  end
end

require 'minitest/spec'
require 'minitest/autorun'

describe 'Oranization' do
  it 'will have a lowest root of Root Organization' do
    Organization.new.name.must_equal ('Root Organization')
  end

  it 'will create a child with itself as a parent' do
    organization = Organization.new
    org2 = organization.create_child()
    org2.parent.must_equal organization
  end

  it 'can have grand children' do
    organization = Organization.new
    org2 = organization.create_child()
    org3 = org2.create_child()
    org3.parent.must_equal org2
  end

  it 'will only create grandchildren of the Root, but no more' do
    organization = Organization.new
    org2 = organization.create_child()
    org3 = org2.create_child()
    org3.create_child().must_equal nil
  end

  it 'can have multiple children' do
    organization = Organization.new
    organization.create_child()
    organization.create_child()
    organization.children.length.must_equal 2
  end

  it 'can grant legal roles to users' do
    user = User.new
    organization = Organization.new
    organization.grant_user_role(user, 'Admin')
    organization.members[user].must_equal 'Admin'
  end

  it 'wont grant illegal roles to users' do
    user = User.new
    organization = Organization.new
    organization.grant_user_role(user, 'foo')
    organization.members[user].wont_equal 'foo'
  end

  it 'should get a role for a user' do
    user = User.new
    organization = Organization.new
    organization.grant_user_role(user, 'Admin')
    organization.role_for_user(user).must_equal 'Admin'
  end

  it 'should return a role from its parent if it has none' do
    user = User.new
    organization = Organization.new
    organization.grant_user_role(user, 'Admin')
    org2 = organization.create_child()
    org2.role_for_user(user).must_equal 'Admin'
  end

  it 'should overwrite a parents role if it has its own' do
    user = User.new
    organization = Organization.new
    organization.grant_user_role(user, 'Admin')
    org2 = organization.create_child()
    org2.grant_user_role(user, 'Denied')
    org2.role_for_user(user).must_equal 'Denied'
  end

end