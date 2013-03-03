mysql-proxy-obfuscator
======================

mysql-proxy-obfuscator is a Lua script which can be added to the excellent MySQL proxy to create an obfuscated dump of data straight out of mysql.
The intended operation is to install MySQL proxy and start a proxy server with the 'obfuscator.lua' script:

  `/usr/local/mysql-proxy/bin/mysql-proxy --proxy-lua-script=/usr/local/mysql-proxy/lib/mysql-proxy/lua/obfuscator.lua`
  
By default this will replace all strings in your mysqldump with random strings the same length as the original string. Formatting is not preserved!

You can further enhance the obfuscation method by creating local definitions in **definitions.lua** script, some have been provided and pull requests are greatly received.
Create a Lua table named after the schema you wish to affect, then create a function within that schema the matches the column you wish to obfuscate. 
The obfuscation script will automatically load your definitions as part of initiliastion.

For example

    my_table = {}
    function my_table.firstname(original_value)
      return 'your my_table.firstname column will be filled with this string instead of the random chars'
    end
  
It's your responsibility to ensure the return value length does not exceed the column length.

The benefit of this method is that we don't need to dump the data before obfuscating it so we can be sure we're controlling acccess to sensitive data. 

More details about MySQL proxy can be found at http://dev.mysql.com/downloads/mysql-proxy/ including instructions of how to install it.
