require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Muhammad', password: 'QPFJWz1343439') }

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if password is less than 10 chars' do
    subject.password = 'Abc123'
    expect(subject).to_not be_valid
  end

  it 'is not valid if password is greater than 16 chars' do
    subject.password = '000aaaBBBccccDDDXYZ'
    expect(subject).to_not be_valid
  end

  it 'is not valid if password does not contain an upper case letter' do
    subject.password = 'abcdefghijklmnop'
    expect(subject).to_not be_valid
  end

  it 'is not valid if password does not contain a lower case letter' do
    subject.password = 'ABCDEFGHIJKLMNOP'
    expect(subject).to_not be_valid
  end

  it 'is not valid if password does not contain a digit' do
    subject.password = 'ABCDEFGHIJKLmnop'
    expect(subject).to_not be_valid
  end

  it 'is not valid if password contains three consecutive repeating strings' do
    subject.password = '000aaaBBBccccDDD'
    expect(subject).to_not be_valid
  end
end
