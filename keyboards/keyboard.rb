module Keyboard
  require 'json'

  def self.set(keyboard_name, inline = false)
    if inline
      Telegram::Bot::Types::InlineKeyboardMarkup.new(
        inline_keyboard: self.keyboard_parse(keyboard_name, inline)
        )
    else
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(
        keyboard: self.keyboard_parse(keyboard_name),
        resize_keyboard: true
        )
    end
  end

  def self.remove
    Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  end

  # Формирует массив массивов с кнопками из json
  def self.keyboard_parse(keyboard_name, inline = false)
    keyboards_file = File.read('keyboards/keyboards.json')
    keyboards_hash = JSON.parse(keyboards_file)
    keyboard_array = []
    
    if inline
      keyboard_array << keyboards_hash[keyboard_name.to_s].map {|button, params| Telegram::Bot::Types::InlineKeyboardButton.new(params)}
    else
      keyboards_hash[keyboard_name.to_s].each do |row, buttons|
        keyboard_array << buttons.map {|button, params| params}
      end
    end

    keyboard_array
  end
end
