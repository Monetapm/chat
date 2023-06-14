SYNRC 💬 CHAT
=============

![image](https://github.com/erpuno/chat/assets/144776/b7e0b60b-4b61-4ff6-a8c9-e27f2e4c4e7c)

Features
--------

* X.509 OpenSSL, LiberSSL for security;
* MQTT for CHAT application;
* NS for DNSSEC domain security;
* LDAP for user directory;
* SYN/MAIL message delivery system;
* CA for X.509 client certificate enrollment;
* N2O based CHAT protocol.

CHAT protocol
-------------

The CHAT protocols communicates with `actions/:client`, `events/:client`, `devices/:phone`,
`contacts/:roster`, `private/:roster/:roster` MQTT topics, sending through them
`Index`, `Typing`, `Search`, `Feature`, `Service`, `Desc`, `Presence`,
`Friend`, `Tag`,  `Link`, `StickerPack`, `Message`, `Member`, `Room`, `Contact`,
`Star`, `RoomStar`, `Ack`, `Auth`, `Roster`, `Profile`, `History`, `push`, `io`
ETF-serialized messages.

The CHAT protocol is implemented in the set of sub-protocol modules:
FILE, HISTORY, LINK, MESSAGE, PRESENSE, PROFILE, PUSH, ROOM, ROSTER,
SEARCH, AUTH. For full specification follow `priv/design` folder.
The CHAT server implementation relies only on ISO/IETF connections
such as DNSSEC, X.509 SCR, LDAP, QUIC, WebSocket, MQTT.

* [CHAT N2O PROTO SPEC](priv/proto) Erlang Term Format ETF/BERT over MQTT/QUIC

MQTT server
-----------

```erlang
$ sudo apt instal mosquitto mosquitto-clients
$ mosquitto -c mosquitto.conf
$ mosquitto_sub -p 8883 -t topic --cafile "caroot.pem" --cert "client.pem" --key "client.key"
$ mosquitto_pub -p 8883 -t topic --cafile "caroot.pem" --cert "client.pem" --key "client.key" -m "HELLO"
```


CHAT server
-----------

```erlang
$ sudo apt install erlang elixir
$ git clone git@github.com:synrc/mq && cd mq
$ mix deps.get
$ mix release
$ _build/dev/rel/chat/bin/chat daemon
$ _build/dev/rel/chat/bin/chat remote
Erlang/OTP 24 [erts-12.2.1] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit]

Interactive Elixir (1.12.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(chat@TRISTELLAR)1>
^C^C
>
```

MQTT client
-----------

```erlang
 1> {ok, Conn} = emqtt:start_link([
       {client_id, <<"5HT">>},
       {ssl, true},
       {port, 8883},
       {ssl_opts, [
           {verify,verify_peer},
           {certfile,"cert/ecc/Max Socha.pem"},
           {keyfile,"cert/ecc/Max Socha.key"},
           {cacertfile,"cert/ecc/caroot.pem"}]}]).
 {ok,<0.193.0>}
 2> emqtt:connect(Conn).
 {ok,undefined}
 3> emqtt:subscribe(Conn, {<<"hello">>, 0}).
 {ok,undefined,[0]}
 4> emqtt:publish(Conn, <<"hello">>, <<"Hello World!">>, 0).
 ok
 5> flush().
 Shell got {publish,#{client_pid => <0.193.0>,dup => false,
                     packet_id => undefined,payload => <<"Hello World!">>,
                     properties => undefined,qos => 0,retain => false,
                     topic => <<"hello">>}}
 ok
^C^C
```

CHAT client
-----------

The CHAT comes with Elixir shell console `chat_client`.

Credits
-------

* Namdak Tonpa

OM A HUM
