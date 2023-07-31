-ifndef(CHAT_META_HRL).
-define(CHAT_META_HRL, true).

-type module() :: chats | contacts | calls | settings.
-type icons() :: bin | heart | update | more | search | export |
              toggle | read | qr | user | users | add | edit | avatar.

-record('header', { name = [], icons = []}.
-record('footer', { modules = []}.
-record('section', { name = [], rows = []}).
-record('row', { lico = [], rico = [], desc = [] }).
-record('screen', { hd = [], ft = [], sections = []}).

-endif.