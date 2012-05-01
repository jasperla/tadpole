#!/usr/bin/env node
#
# Nothing too fancy for now; just connect and print the collected
# URIs to the console. Later we'll feed this into a redis datastore.

irc 	= require 'irc'
util	= require 'util'
logging	= require './lib/log'
date 	= require './lib/date'
config	= require './config'

client = new irc.Client config.network.server, config.network.nickName,
  userName: config.network.userName
  realName: config.network.realName
  channels: [config.network.channel]
  secure: config.network.ssl
  port: config.network.port || 6667
  certExpired: true

client.addListener 'pm', (from, message) ->
	if from is config.ownerNick
                util.log "/msg from config.ownerNick: #{message}"
	else
		client.say config.network.channel, "#{from} whispered to me: \"#{message}\"!"

client.addListener "message#{config.network.channel}", (from, message) ->
	util.log "#{from} said: #{message}" if config.debug
	uri = contains_uri message
	if uri
		logging.log_uri uri, message, from

# Only get full URIs, this prevents stuff from 'look at google.com' from
# being picked up.
contains_uri = (msg) ->
	match = /.*(http|ftp|scp|sftp|https):\/\/.*/i.test(msg)
	if match
		/(http|ftp|scp|sftp|https):\/\/[^ ]*/i.exec(msg)[0]
