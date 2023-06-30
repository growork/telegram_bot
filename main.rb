require 'telegram/bot'
require_relative 'database/database'
require_relative 'keyboards/keyboard'
require_relative 'commands_handler'

token = File.read('token/token.txt').chomp

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    response_params = CommandsHandler.do(message)
    
    bot.api.send_message(response_params)
  end
end

