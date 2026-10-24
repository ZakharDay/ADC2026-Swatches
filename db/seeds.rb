@hex_symbols = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F']

def seed
  remove_schema_file
  reset_db
  create_admin
  create_users
  create_colors(100)
  create_projects(10)
  create_swatches(2..8)
  create_fills(2..8)
  add_colors_to_fills
end

def reset_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

def remove_schema_file
  FileUtils.rm('db/schema.rb')
  puts "Schema just removed"
end

def get_random_color
  color_hex = []

  6.times do
    color_hex << @hex_symbols.sample
  end

  color_hex.join('')
end

def create_admin
  user_data = {
    email: "admin@email.com",
    password: "testtest",
    admin: true
  }

  user = User.create!(user_data)
  puts "Admin created with id #{user.id}"
end

def create_users
  i = 1

  10.times do
    user_data = {
      email: "user_#{i}@email.com",
      password: 'testtest'
    }

    user = User.create!(user_data)
    puts "User created with id #{user.id}"

    i += 1
  end
end

def create_colors(quantity)
  quantity.times do
    user = User.all.sample
    color = user.colors.create!(rgb_hash: "#{get_random_color}")
    puts "Color with id #{color.id} just created"
  end
end

def create_projects(quantity)
  i = 1

  quantity.times do
    user = User.all.sample

    project = user.projects.create!(
      name: "Project #{i}",
      description: 'Some project description'
    )

    puts "Project with id #{project.id} just created"
    i += 1
  end
end

def create_swatches(quantity)
  i = 1
  projects = Project.all
  
  projects.each do |project|
    quantity.to_a.sample.times do
      user = project.user
      swatch = project.swatches.create!(user_id: user.id, name: "Swatch #{i}")
      puts "Swatch with id #{swatch.id} for project with id #{swatch.project.id} just created"
      i += 1
    end
  end
end

def create_fills(quantity)
  i = 1
  swatches = Swatch.all
  
  swatches.each do |swatch|
    quantity.to_a.sample.times do
      user = swatch.user
      fill = swatch.fills.create!(user_id: user.id)
      puts "Fill with id #{fill.id} for swatch with id #{fill.swatch.id} just created"
      i += 1
    end
  end
end

def add_colors_to_fills
  Fill.all.each do |fill|
    type = ['solid', 'gradient'].sample

    if type == 'solid'
      create_solid_color(fill)
    elsif type == 'gradient'
      create_gradient_color(fill)
    end
  end
end

def create_solid_color(fill)
  color = Color.all.sample
  fill.colors << color

  puts "Color #{color.rgb_hash} just added to fill with id #{fill.id}"
end

def create_gradient_color(fill)
  quantity = (2..5).to_a.sample
  first_stop = (0..40).to_a.sample
  last_stop = (60..100).to_a.sample

  if quantity > 2
    range = last_stop - first_stop
    step = range / (quantity - 1)
  end

  i = 1

  quantity.times do
    stop = 0

    if i == 1
      stop = first_stop
    elsif i == quantity
      stop = last_stop
    else
      stop = first_stop + (step * (i - 1))
    end
    
    color = Color.all.sample
    fill_color = FillColor.create!(fill: fill, color: color, stop: stop)

    puts "Color #{color.rgb_hash} just added to fill with id #{fill.id}"

    i += 1
  end
end

seed