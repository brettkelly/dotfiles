return function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local fmt = require("luasnip.extras.fmt").fmt

    ls.add_snippets("all",{
        s("date", {
            f(function() return os.date("%Y-%m-%d") end, {}),
        }),
    })


    ls.add_snippets("python", {
      -- Python-specific snippets
      s("def", fmt(
        [[
        def {}({}):
            {}
        ]], {
          i(1, "function_name"),
          i(2, "args"),
          i(3, "pass")
        }
      )),
    })
end
