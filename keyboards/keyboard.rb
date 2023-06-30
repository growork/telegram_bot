module Keyboard
  require 'json'

  def self.set(keyboard_name)
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(
      keyboard: self.keyboard_parse(keyboard_name),
      resize_keyboard: true
    )
  end

  def self.remove
    Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  end

  # Формирует массив массивов с кнопками из json
  def self.keyboard_parse(keyboard_name)
    keyboards_file = File.read('keyboards/keyboards.json')
    keyboards_hash = JSON.parse(keyboards_file)
    keyboard_array = []
    
    keyboards_hash[keyboard_name.to_s].each do |rows, buttons|
      keyboard_array << buttons.map {|button, params| buttons[button]}
    end

    keyboard_array
  end
end
