fx_version 'adamant'
game 'gta5'

author 'Oph3Z#4326'
description 'HTML part made by ! Resul#0001'

ui_page 'html/index.html'

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua',
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua'
}

shared_script {
	'config.lua',
	
	'locale.lua',
    'locales/*.lua'
}

files {
	'html/index.html',
	'html/js/*.js',
	'html/css/*.css',
	'html/img/*.png',
}