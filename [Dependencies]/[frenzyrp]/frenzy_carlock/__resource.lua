resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script {
    'client.js',
    'config.js'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@async/async.lua',
    'server_lib.lua'
}

dependencies {
    'mysql-async',
    'async'
}