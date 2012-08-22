#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'net/imap'
require 'gir_ffi'

server, username, password, account = ARGV[0], ARGV[1], ARGV[2], ARGV[3]

folder = 'INBOX'

imap = Net::IMAP.new(server, 143)
imap.login(username, password)
imap.select(folder)

count = imap.search(["NOT", "SEEN"]).each.count

GirFFI.setup :Notify
Notify.init("Mailovi")

Hello = Notify::Notification.new("%s" % account, "Novi mail: %s" % count, 
                                    "dialog-information")

if count != 0
    Hello.show
end

imap.logout()
imap.disconnect()

puts count.to_s
