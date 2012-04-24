#!/usr/bin/env node
#
# Nothing too fancy for now; just connect and print the collected
# URIs to the console. Later we'll feed this into a redis datastore.

irc 		= require 'irc'
logging = require './lib/log'
date 		= require './lib/date'

DEBUG = no
CHANNEL = '#testnet'

client = new irc.Client 'irc.bsdfrog.org', 'tadpole',
  userName: 'tadpole'
  realName: 'http://github.com/jasperla/tadpole/'
  channels: [CHANNEL]
  secure: true
  port: 6697
  certExpired: true

client.addListener 'pm', (from, message) ->
	if from is 'jasper'
		console.log "[#{date.format_date()}]: /msg from jasper: #{message}"
	else
		client.say CHANNEL, "#{from} whispered to me: \"#{message}\"!"

client.addListener "message#{CHANNEL}", (from, message) ->
	console.log "#{from} said: #{message}" if DEBUG
	uri = contains_uri message
	if uri
		logging.log_uri uri
  
# Only get full URIs, this prevents stuff from 'look at google.com' from
# being picked up.
contains_uri = (msg) ->
	match = /.*(http|ftp|scp|sftp|https):\/\/.*/i.test(msg)
	if match
		/(http|ftp|scp|sftp|https):\/\/[^ ]*/i.exec(msg)[0]
