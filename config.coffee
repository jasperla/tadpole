module.exports =
	DEBUG: no
	network:
		server: process.argv[2] || 'irc.somenet.org'
		nickName: 'tadpole'
		userName: 'tadpole'
		realName: 'http://github.com/jasperla/tadpole/'
		port: 6697
		channel: '#testnet'
		ssl: yes
	ownerNick: 'jasper'
	html:
		enabled: yes
		path: '/tmp/tadpole/'
