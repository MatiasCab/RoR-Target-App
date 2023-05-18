AdminUser.create!(email: 'admin@example.com', password: 'password') if Rails.env.development?
Setting.create_or_find_by!(key: 'min_version', value: '0.0')

User.create!(first_name: 'Matias', last_name: 'Cabrera', email: 'matias@gmail.com',
             password: '12345678')
User.create!(first_name: 'User_2', last_name: 'User_2', email: 'user_2@gmail.com',
             password: '12345678')

Topic.create!(name: 'Sports', image: '----')
Topic.create!(name: 'Music', image: '----')
Topic.create!(name: 'Study', image: '----')
Topic.create!(name: 'Food', image: '----')
Topic.create!(name: 'Animals', image: '----')
Topic.create!(name: 'Places', image: '----')
