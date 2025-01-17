defmodule CHAT.X509 do
    require CHAT

    def ctx(),  do: :application.get_env(:chat, :ctx, ["01-WELCOME"])
    def home(), do: :application.set_env(:chat, :ctx, ["01-WELCOME"])

    def back() do
        case ctx() do
             [] -> home()
             [ctx] -> :skip
             ctx -> :application.set_env(:chat, :ctx, tl(ctx))
        end
    end

    def push(name) do
        ctx = ctx()
        newCtx = [name|ctx]
        :application.set_env(:chat, :ctx, newCtx)
    end

    def findScreen(name) do
        {_name,screen} = :lists.keyfind(name, 1, list())
        screen
    end
    def list() do
      [
        { CHAT.screen(welcome(), :name), welcome() },
        { CHAT.screen(reg(),     :name), reg() },
        { CHAT.screen(privacy(), :name), privacy() },
        { CHAT.screen(contact(), :name), contact() },
        { CHAT.screen(profile(), :name), profile() }
      ]
    end

    def next(no) do
        [ctx|_] = ctx()
        CHAT.screen(sections: [CHAT.section(name: name, rows: rows)]) = findScreen(ctx)
        CHAT.row(rico: {:more, nextName}) = :lists.keyfind(no,2,rows)
        push(nextName)
        show()
    end

    def show() do
        [ctx|_] = ctx()
        CHAT.screen(sections: [CHAT.section(name: name, rows: rows)]) = findScreen(ctx)
        :io.format '\e[0m\e[1;97m\e[45m    \e[0;97m\e[1;104m ~ts ~n\e[0m\e[0K', [name]
        :lists.map(fn CHAT.row(no: no, desc: desc, rico: _rico) ->
           :io.format '\e[0m\e[1;97m\e[45m ~2.. B \e[0;93m\e[0;104m ~40.. ts ~n\e[0m\e[0K', [no,desc]
        end, rows)
        :ok
    end

    def welcome() do
        CHAT.screen(no: 1, name: "01-WELCOME", sections:
         [CHAT.section(name: "Вітаємо в CHAT!", rows: [
           CHAT.row(no: 1, desc: "Реєстрація", rico: {:more, "02-REG"}),
           CHAT.row(no: 2, desc: "Авторизація", rico: :more),
           CHAT.row(no: 3, desc: "Імпорт", rico: :more)
         ])])
    end

    def reg() do
        CHAT.screen(no: 2, name: "02-REG", sections:
         [CHAT.section(name: "Реєстрація", rows: [
           CHAT.row(no: 1, desc: "Позивний", rico: :text),
           CHAT.row(no: 2, desc: "Пароль", rico: :pin),
           CHAT.row(no: 3, desc: "Продовжити", rico: {:more,"03-PROFILE"})
         ])])
    end

    def profile() do
        CHAT.screen(no: 3, name: "03-PROFILE", sections:
          [CHAT.section(name: "Налаштування профілю", rows: [
            CHAT.row(no: 1, desc: "Profile ID", rico: :export),
            CHAT.row(no: 2, desc: "Відкритий ключ", rico: :search),
            CHAT.row(no: 3, desc: "Налаштування ключів", rico: :more),
            CHAT.row(no: 4, desc: "Налаштування серверів", rico: :more),
            CHAT.row(no: 5, desc: "Прив'язаний номер", rico: :more),
            CHAT.row(no: 6, desc: "Прив'язаний E-Mail", rico: :more),
            CHAT.row(no: 7, desc: "Блокування паролем", rico: :toggle),
            CHAT.row(no: 8, desc: "Приватність", rico: {:more,"04-PRIVACY"}),
            CHAT.row(no: 9, desc: "Export ID", rico: :export),
            CHAT.row(no: 10, desc: "Сховище і дані", rico: :more),
            CHAT.row(no: 11, desc: "Видалити дані ID", rico: :bin),
            CHAT.row(no: 12, desc: "Видалити профіль", rico: :bin),
            CHAT.row(no: 13, desc: "Версія", rico: :bin),
            CHAT.row(no: 14, desc: "Параметри", rico: :more),
            CHAT.row(no: 15, desc: "Підтримати", rico: :more),
            CHAT.row(no: 16, desc: "Політика конфіденційності", rico: :more),
            CHAT.row(no: 17, desc: "Умови використання", rico: :more),
            CHAT.row(no: 18, desc: "Ліцензії", rico: :more),
            CHAT.row(no: 19, desc: "Довідка", rico: :more),
        ])])
    end
    def privacy() do
         CHAT.screen(no: 4, name: "04-PRIVACY", sections:
           [CHAT.section(name: "Приватність", rows: [
             CHAT.row(no: 1, desc: "Синхронізація контактів з iOS", rico: :toggle),
             CHAT.row(no: 2, desc: "Блокування невідомих", rico: :toggle),
             CHAT.row(no: 3, desc: "Ділитися контактами з iOS", rico: :toggle),
             CHAT.row(no: 4, desc: "Заблоковані корістувачі", rico: :more),
             CHAT.row(no: 5, desc: "Номер телефону", rico: :more),
             CHAT.row(no: 6, desc: "Email", rico: :more),
             CHAT.row(no: 7, desc: "Видимість в загальному каталозі", rico: :more),
             CHAT.row(no: 8, desc: "Відвідини та стан мережі", rico: :more),
             CHAT.row(no: 9, desc: "Фото профілю", rico: :more),
             CHAT.row(no: 10, desc: "Виклики", rico: :more),
             CHAT.row(no: 11, desc: "Голосові повідомлення", rico: :more),
             CHAT.row(no: 12, desc: "Пересилання повідомлень", rico: :more),
             CHAT.row(no: 13, desc: "Додавання мене в групах", rico: :more),
             CHAT.row(no: 14, desc: "Звіт про прочитання", rico: :toggle),
             CHAT.row(no: 15, desc: "Індикатор набору тексту", rico: :toggle),
             CHAT.row(no: 16, desc: "Папки для чатів", rico: {:more,"05-CONTACT"}),
             CHAT.row(no: 17, desc: "Таймер автовидалення", rico: :more)
        ])])

     end

     def contact() do
         CHAT.screen(no: 5, name: "05-CONTACT", sections:
           [CHAT.section(name: "Контакт", rows: [
             CHAT.row(no: 1, desc: "Чати", rico: :more),
             CHAT.row(no: 2, desc: "Дзвінки", rico: :more),
             CHAT.row(no: 3, desc: "Відеодзвінки", rico: :more),
             CHAT.row(no: 4, desc: "User ID", rico: :export),
             CHAT.row(no: 5, desc: "Видалити контакт", rico: :bin),
             CHAT.row(no: 6, desc: "Очистити бесіди", rico: :bin),
             CHAT.row(no: 7, desc: "Заблокувати контакт", rico: :toggle),
             CHAT.row(no: 8, desc: "Рівень підтверження", rico: :more),
             CHAT.row(no: 9, desc: "Відкритий ключ", rico: :searth),
             CHAT.row(no: 10, desc: "Контактна інформація", rico: :more),
             CHAT.row(no: 11, desc: "Вимкнути сповіщення", rico: :toggle),
             CHAT.row(no: 12, desc: "Зникаючі повідомлення", rico: :toggle),
             CHAT.row(no: 13, desc: "Pin Chat", rico: :toggle),
             CHAT.row(no: 14, desc: "Папки", rico: :more),
             CHAT.row(no: 15, desc: "Файли контакту", rico: :searth)
        ])])
     end

     def test do
         :CHAT.encode(:CHATMessage,
         CHAT."CHATMessage"(no: 1, headers: [], body: {:message,
         CHAT."Message"(id: "5HT", feed: {:muc,CHAT."MUC"(room: "1")},
                        signature: "", from: "sys", to: "5HT", created: 1,
                        files: [], type: :sys, link: {:empty,"NULL"},
                        seenby: "", repliedby: "", mentioned: [])}))
     end

end