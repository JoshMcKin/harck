class TestDB
  def self.yml
    YAML::load(File.open(File.join(File.dirname(__FILE__),'..',"database.yml")))
  end

  def self.connect(logging=false)
    ActiveRecord::Base.configurations = yml
    ActiveRecord::Base.establish_connection(:test)
    ActiveRecord::Base.logger = Logger.new(STDOUT) if logging
  end

  def self.clean
    [:users,:clients].each do |t|
      ActiveRecord::Base.connection.execute("DELETE FROM #{t.to_s}")
    end
  end
end

#Put all the test migrations here
class TestMigrations < ActiveRecord::Migration
  # all the ups
  def self.up
    ActiveRecord::Base.establish_connection(:without_db)

    begin
      ActiveRecord::Base.connection.execute("CREATE DATABASE IF NOT EXISTS harck_test;")
    rescue => e
      puts "Error creating database: #{e}"
    end

    ActiveRecord::Base.establish_connection(:test)

    begin
      create_table "harck_test.users" do |t|
        t.string :name
        t.integer :clicks, default: 0
        t.decimal :money, :precision => 10, :scale => 2
        t.date :date
        t.datetime :datetime
      end
    rescue => e
      puts "tables failed to create: #{e}"
    end
  end

  # all the downs
  def self.down
    ActiveRecord::Base.establish_connection(:test)
    begin
    ActiveRecord::Base.connection.execute("DROP DATABASE `harck_test`;")
    rescue => e
      puts "Error dropping database: #{e}"
    end
  end
end
