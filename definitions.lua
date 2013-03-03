-- define a lua table matching the schema name
my_table_test = {}
other_table_test = {}

-- define a function in that table matching the column name to obfuscate
function my_table_test.email(original_value) 
    return emailAddressAtMailinator(original_value)
end

function other_table_test.firstname(original_value)
    return nameLikeFirstname() .. " " .. nameLikeLastname()
end

function my_table_test.phone(original_value)
    return telephoneNumber(original_value)
end
-- end of schema definition

-- Generic functions defined below
-- use these functions from the global namespace in the schema functions 
-- above to save re-defining routines for similar columns

function emailAddressAtMailinator(original_value)
    return string.random(string.len(original_value), '%d%l') .. '@mailinator.com'
end

function telephoneNumber(original_value)
    return string.random(string.len(original_value), '%d')
end

function nameLikeFirstname()
    local firstnames = {
"Wilson",
"Kasha",
"Lilly",
"Berneice",
"Amira",
"Dorie",
"Tu",
"Shira",
"Elliot",
"Rona",
"Velda",
"Elvera",
"Arla",
"Cherryl",
"Lovella",
"Ignacia",
"Damaris",
"Evelyne",
"Mariella",
"Jeanne",
"Han",
"Nicole",
"Catheryn",
"Lance",
"Roxanne",
"Sarita",
"Hortencia",
"Sophia",
"Bree",
"Rupert",
"Mabelle",
"Lynne",
"Marlene",
"Amiee",
"Saundra",
"Cinderella",
"Ila",
"Milford",
"Grace",
"Willene",
"Idalia",
"Dianna",
"Taren",
"Arcelia",
"Michiko",
"Shenita",
"Joeann",
"Chery",
"Layla",
"Randolph",
    }
    return firstnames[math.random(1,#firstnames)]
end

function nameLikeLastname()
    local lastnames = {
"Wyer",
"Kuta",
"Luster",
"Bechtol",
"Adger",
"Daoust",
"Tewksbury",
"Sleeman",
"Ertel",
"Ragland",
"Vassallo",
"Eppinger",
"Arwood",
"Concepcion",
"Lovell",
"Isaac",
"Dallas",
"Ensley",
"Meggs",
"Justis",
"Hisey",
"Nobles",
"Caver",
"Landen",
"Rinaldi",
"Shryock",
"Hulme",
"Shuffler",
"Bethea",
"Rothenberger",
"Mourer",
"Lonzo",
"Mettler",
"Addy",
"Servantes",
"Cohan",
"Izzo",
"Meinhardt",
"Giltner",
"Winrow",
"Inglis",
"Delk",
"Turnbow",
"Alt",
"Mcdonnell",
"Schrock",
"Jarrell",
"Corriveau",
"Lorence",
"Ruple",
    }
    return lastnames[math.random(1,#lastnames)]
end

