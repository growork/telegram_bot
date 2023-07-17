module CommandsHandler
  def self.do(message)
    case message
    when Telegram::Bot::Types::CallbackQuery
      {chat_id: message.from.id, "text": message.data}
    when Telegram::Bot::Types::Message
    case (message.text ? message.text : '/start')
# ---------- Базовые команды ----------
    when '/start' # ----------
      if Database.add_user(message.from.username.to_s, message.from.first_name.to_s, message.from.last_name.to_s, message.from.id.to_i)
        text = "Добро пожаловать, #{message.from.first_name}! \nХочется быстро и с удобством собрать друзей для весёлой посиделки? Этот бот поможет тебе! \nЗагляни в раздел Помощь(/help), чтобы узнать о возможностях бота и вперёд к весёлому времяпрепровождению!"
      else
        text = "#{message.from.first_name}, <b>ты</b> в главном меню! \nЗа помощью в умениях бота — в раздел Помощь(/help). Удачи!"
      end
      keyboard = Keyboard.set(:main)
      response_params = {
        "chat_id": message.chat.id,
        "text": text,
        "reply_markup": keyboard,
        "parse_mode": "HTML"
      }
    
    when '/stop' # ----------
      response_params = {
        "chat_id": message.chat.id,
        "text": 'Надеюсь, что ты к нам вернёшься и соберёшь весёлую компанию! Удачи!',
        "reply_markup": Keyboard.remove
      }

# ---------- Раздел "Главное меню" ----------
    when 'Компании'
      response_params = {
        "chat_id": message.chat.id,
        "text": "Раздел компаний.",
        "reply_markup": Keyboard.set(:companies, true)
      }
    else
      response_params = {
        "chat_id": message.chat.id,
        "text": "Я такого не знаю"
      }
    end
    response_params
  end
end
end

