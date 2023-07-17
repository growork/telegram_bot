module Database
  require 'sqlite3'

  # Определение базы
  @db = SQLite3::Database.open "database/MeetingBot"

  # Добавление нового пользователя в базу
  def self.add_user(username, first_name, last_name, user_id)
      @db.execute("insert into users (username, first_name, last_name, user_id) values (?, ?, ?, ?)", [username, first_name, last_name, user_id]) unless user_exists?(user_id)
  end

  # Проверка наличия пользователя в базе
  def self.user_exists?(user_id)
    (@db.execute("select * from users where user_id = '#{user_id}'")).any?
  end
end

