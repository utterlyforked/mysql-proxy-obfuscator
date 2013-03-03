-- define a lua table matching the schema name
my_table_test = {}

-- define a function in that table matching the column name to obfuscate
function my_table_test.email(original_value) 
    return emailAddressAtMailinator(original_value)
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
