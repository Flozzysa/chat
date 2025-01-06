fx_version 'cerulean'
game 'gta5'
author 'wx / woox'
description 'Advanced ESX RP Chat for FiveM'
version '2.0'
lua54 'yes'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/*.lua',
	'esx_garage/server/garage_server.lua'
}

client_scripts {
	'client/*.lua',
	'esx_garage/client/garage_client.lua'
}

shared_scripts {'@ox_lib/init.lua', 'configs/*.lua'}