require "definitions"

local Chars = {}
for Loop = 0, 255 do
   Chars[Loop+1] = string.char(Loop)
end
local String = table.concat(Chars)

local Built = {['.'] = Chars}

local AddLookup = function(CharSet)
   local Substitute = string.gsub(String, '[^'..CharSet..']', '')
   local Lookup = {}
   for Loop = 1, string.len(Substitute) do
       Lookup[Loop] = string.sub(Substitute, Loop, Loop)
   end
   Built[CharSet] = Lookup

   return Lookup
end

function string.random(Length, CharSet)

   -- Length (number)
   -- CharSet (string, optional); e.g. %l%d for lower case letters and digits

   local CharSet = CharSet or '.'

   if CharSet == '' then
      return ''
   else
      local Result = {}
      local Lookup = Built[CharSet] or AddLookup(CharSet)
      local Range = table.getn(Lookup)

      for Loop = 1,Length do
         Result[Loop] = Lookup[math.random(1, Range)]
      end

      return table.concat(Result)
   end

end

function read_query(packet)

    if packet:byte() ~= proxy.COM_QUERY then return end

    if string.match(string.upper(string.sub(packet,2)), '^SELECT //*') then 
        res = {}
        proxy.queries:append(2, packet, {resultset_is_needed = true})
        return proxy.PROXY_SEND_QUERY
    end

end

function read_query_result(inj)
    
    local fields = {}
    local schemaName = string.gsub(string.match(inj.query, "%b``"), '`', '')

    for n = 1, #inj.resultset.fields do
        fields[#fields + 1] = {
            type = inj.resultset.fields[n].type,
            name = inj.resultset.fields[n].name,
        }
    end
    
    for row in inj.resultset.rows do
        for n = 1, #row do
            local fieldValue 
            if _G[schemaName] and _G[schemaName][fields[n].name] then
                row[n] = _G[schemaName][fields[n].name](row[n])
            elseif fields[n].type == proxy.MYSQL_TYPE_VAR_STRING or 
                fields[n].type == proxy.MYSQL_TYPE_STRING or
                fields[n].type == proxy.MYSQL_LONG_BLOB or
                fields[n].type == proxy.MYSQL_MEDIUM_BLOB then
                
                fieldValue = string.random(string.len(row[n]), '%l')
                row[n] = fieldValue
            end
        end
        res[#res + 1] = row
    end

    proxy.response = {
        type = proxy.MYSQLD_PACKET_OK, resultset = { rows = res }
    }

    proxy.response.resultset.fields = fields
    return proxy.PROXY_SEND_RESULT

end
