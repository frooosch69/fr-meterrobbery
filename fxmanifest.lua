fx_version 'cerulean'
game 'gta5'

description 'rob Parkingmeters'
version '1.0.0'
author 'froschOderSo'

shared_scripts { 
    
    'config.lua', '@qb-core/shared/locale.lua', 
    'locales/en.lua'

}

server_script { 
    
    'server/server.lua'

}

client_scripts {
    
    'client/client.lua'

}

dependencies {

    'qb-target',
    'qb-core'
    
}

lua54 'yes'
