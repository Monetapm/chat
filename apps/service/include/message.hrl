-ifndef(MESSAGE_HRL).
-define(MESSAGE_HRL, true).

-type container()     :: chain | cur.
-type messageType()   :: sys | reply | forward | read | edited | cursor.
-type messageStatus() :: masync | mdelete | mclear| mupdate | medit.
-type historyType()   :: hupdated | hget | hupdate | hlast_loaded | hlast_msg | hget_reply.
-type jobType()       :: jinit | jupdate | jdelete | jpending | jstop | jcomplete.

-record(muc,            {name = [] :: [] | binary() }).
-record(p2p,            {from = [] :: [] | binary(),
                         to   = [] :: [] | binary() }).

-record('Message',      {id        = [] :: [] | integer(),
                         container = chain :: container(),
                         feed_id   = [] :: #muc{} | #p2p{},
                         prev      = [] :: [] | integer(),
                         next      = [] :: [] | integer(),
                         msg_id    = [] :: [] | binary(),
                         from      = [] :: [] | binary(),
                         to        = [] :: [] | binary(),
                         created   = [] :: [] | integer(),
                         files     = [] :: list(#'Desc'{}),
                         type      = [] :: messageType(),
                         link      = [] :: [] | integer() | #'Message'{},
                         seenby    = [] :: list(binary() | integer()),
                         repliedby = [] :: list(integer()),
                         mentioned = [] :: list(integer()),
                         mstatus   = [] :: messageStatus()}).

-record('History',      {roster_id = [] :: [] | binary(),
                         feed      = [] :: [] | #p2p{} | #muc{},
                         size      = 0  :: [] | integer(),
                         entity_id = 0  :: [] | integer(),
                         data      = [] :: integer(),
                         status    = [] :: historyType()}).

-record(act,           {name= <<"publish">> :: [] | binary(),
                        data=[]:: binary() | integer() }).

-record(messageEvent, { name       = [] :: [] | atom(),
                        payload    = [] :: binary(),
                        timeout    = [] :: integer(),
                        module     = [] :: atom()}).

-record('Job',          {id        = [] :: [] | integer(),
                         container = chain :: container(),
                         feed_id   = [] :: #act{},
                         prev      = [] :: [] | integer(),
                         next      = [] :: [] | integer(),
                         context   = [] :: [] | integer() | binary(),
                         proc      = [] :: [] | integer(),
                         time      = [] :: integer(),
                         data      = [] :: list( #'Message'{}),
                         events    = [] :: list(#messageEvent{}),
                         settings  = [] :: list(#'Feature'{}),
                         status    = [] ::  jobType()}).

-endif.
