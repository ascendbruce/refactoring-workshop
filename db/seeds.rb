# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admitted_user = User.create!(
  email: 'admitted_user@example.com', password: 'abcd1234', password_confirmation: 'abcd1234',
  profile_attributes: { nickname: 'Tester 1', bio: 'I am a tester' }
)

new_free_user = User.create!(
  email: 'new_free_user@example.com', password: 'abcd1234', password_confirmation: 'abcd1234',
  profile_attributes: { nickname: 'Tester 2', bio: 'I am a tester' }
)

old_free_user = User.create!(
  email: 'old_free_user@example.com', password: 'abcd1234', password_confirmation: 'abcd1234',
  profile_attributes: { nickname: 'Tester 3', bio: 'I am a tester' }
)
old_free_user.update_column(:created_at, 2.weeks.ago)

Project.create!(
  title:       'Project A',
  description: 'Featured Project',
  label:       'new featured',
  is_featured: true,
)

Project.create!(
  title:       'Project B',
  description: 'Normal Project',
  label:       'normal',
  is_featured: false,
)

Project.create!(
  title:       'Project C',
  description: 'Normal Project own by first user',
  label:       'normal',
  is_featured: false,
  user: admitted_user,
)
