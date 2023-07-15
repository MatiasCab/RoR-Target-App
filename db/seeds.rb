AdminUser.create!(email: 'admin@example.com', password: 'password') if Rails.env.development?
Setting.create_or_find_by!(key: 'min_version', value: '0.0')

plan = Plan.create!(name: 'Basic', target_limit: 3)
Plan.create!(name: 'Unlimited Platinium', target_limit: -1)

user1 = User.create!(first_name: 'Matias', last_name: 'Cabrera', email: 'matias@gmail.com',
                     password: '12345678', plan_id: plan.id)
user2 = User.create!(first_name: 'User_2', last_name: 'User_2', email: 'user_2@gmail.com',
                     password: '12345678', plan_id: plan.id)

topic1 = Topic.create!(name: 'Sports', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Icon-round-Question_mark.svg/2048px-Icon-round-Question_mark.svg.png')
topic2 = Topic.create!(name: 'Music', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Icon-round-Question_mark.svg/2048px-Icon-round-Question_mark.svg.png')
Topic.create!(name: 'Study', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Icon-round-Question_mark.svg/2048px-Icon-round-Question_mark.svg.png')
Topic.create!(name: 'Food', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Icon-round-Question_mark.svg/2048px-Icon-round-Question_mark.svg.png')
Topic.create!(name: 'Animals', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Icon-round-Question_mark.svg/2048px-Icon-round-Question_mark.svg.png')
Topic.create!(name: 'Places', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Icon-round-Question_mark.svg/2048px-Icon-round-Question_mark.svg.png')

Target.create!(title: 'Example1', radius: 10.0, lat: 10.0, lng: 10.0, user_id: user1.id,
               topic_id: topic1.id)
Target.create!(title: 'Example2', radius: 10.0, lat: 8.0, lng: 8.0, user_id: user2.id,
               topic_id: topic1.id)
Target.create!(title: 'Example3', radius: 10.0, lat: 10.0, lng: 10.0, user_id: user2.id,
               topic_id: topic2.id)
