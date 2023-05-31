AdminUser.create!(email: 'admin@example.com', password: 'password') if Rails.env.development?
Setting.create_or_find_by!(key: 'min_version', value: '0.0')

user1 = User.create!(first_name: 'Matias', last_name: 'Cabrera', email: 'matias@gmail.com',
             password: '12345678')
user2 = User.create!(first_name: 'User_2', last_name: 'User_2', email: 'user_2@gmail.com',
             password: '12345678')

topic1 = Topic.create!(name: 'Sports', image: '----')
topic2 = Topic.create!(name: 'Music', image: '----')
Topic.create!(name: 'Study', image: '----')
Topic.create!(name: 'Food', image: '----')
Topic.create!(name: 'Animals', image: '----')
Topic.create!(name: 'Places', image: '----')

Target.create!(title: 'Example1', radius: 10.0, lat: 10.0, lng: 10.0, user_id: user1.id, topic_id: topic1.id)
Target.create!(title: 'Example2', radius: 10.0, lat: 8.0, lng: 8.0, user_id: user2.id, topic_id: topic1.id)
Target.create!(title: 'Example3', radius: 10.0, lat: 10.0, lng: 10.0, user_id: user2.id, topic_id: topic2.id)
