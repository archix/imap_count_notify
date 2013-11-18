#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'net/imap'
require 'libnotify'

server, username, password, account = ARGV

folder = 'INBOX'

imap = Net::IMAP.new(server, 143)
imap.login(username, password)
imap.select(folder)

count = imap.search(["NOT", "SEEN"]).each.count

Libnotify.show(:summary => account,
   :body => "New mail #{count}", :timeout => 2.5) if count > 0

imap.logout()
imap.disconnect()

puts count.to_s
