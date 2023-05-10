AdminUser.create!(email: 'admin@example.com', password: 'password') if Rails.env.development?
Setting.create_or_find_by!(key: 'min_version', value: '0.0')

User.create(first_name: 'Matias', last_name: 'Cabrera', email: 'matias@gmail.com', password: '12345678')
