local path = package.path
package.path = path .. ';' .. os.getenv('PWD') .. '/?.lua'
dofile "luahub.lua"
package.path = path
