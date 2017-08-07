require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should create a new user' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTesterson',
        email: 'test@test.com',
        password: 'password'
      )

      @user.save

      expect(@user.errors.messages).to eq({})
    end

    it 'should fail without a first name' do
      @user = User.new(
        last_name: 'McTesterson',
        email: 'test@test.com',
        password: 'password'
      )

      @user.save

      expect(@user.errors.messages).to eq({:first_name=>["can't be blank"]})
    end

    it 'should fail without a last name' do
      @user = User.new(
        first_name: 'Test',
        email: 'test@test.com',
        password: 'password'
      )

      @user.save

      expect(@user.errors.messages).to eq({:last_name=>["can't be blank"]})
    end

    it 'should fail without an email' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTesterson',
        password: 'password'
      )

      @user.save

      expect(@user.errors.messages).to eq({:email=>["can't be blank"]})
    end

    it 'should fail without a password' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTesterson',
        email: 'test@test.com'
      )

      @user.save

      expect(@user.errors.messages).to eq({:password=>["can't be blank", "can't be blank", "is too short (minimum is 8 characters)"]})
    end

    it 'should fail if the password is too short' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTesterson',
        email: 'test@test.com',
        password: 'pass'
      )

      @user.save

      expect(@user.errors.messages).to eq({:password=>["is too short (minimum is 8 characters)"]})
    end

    it 'should not allow for duplicate email addresses' do
      @user1 = User.new(
        first_name: 'Test',
        last_name: 'McTesterson',
        email: 'test@test.com',
        password: 'password'
      )

      @user2 = User.new(
        first_name: 'Test',
        last_name: 'McTesterson',
        email: 'TEST@TEST.com',
        password: 'password'
      )

      @user1.save
      @user2.save

      expect(@user2.errors.messages).to eq({:email=>["has already been taken"]})
    end
  end

  describe '.authenticate_with_credentials' do 

    before do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTesterson',
        email: 'test@test.com',
        password: 'password'
      )
      @user.save
    end

    it 'should allow user to login with proper credentials' do
      @user_login = User.authenticate_with_credentials(@user.email, @user.password)

      expect(@user_login.errors.messages).to eq({})
    end

    it 'should allow user to login with leading and trailing spaces in email' do
      @user_login = User.authenticate_with_credentials(' test@test.com ', @user.password)

      expect(@user_login.errors.messages).to eq({})
    end

    it 'should read the email as case insensitive' do
      @user_login = User.authenticate_with_credentials('TEST@tesT.com', @user.password)

      expect(@user_login.errors.messages).to eq({})
    end
  end

end
