fx_version "cerulean"
game "gta5"
lua54 "yes"

files {
    "data/config.lua",
    "postals.json"
}

client_script "client/main.lua"

server_script "server/main.lua"

export "getPostal"

server_export "getPostal"
