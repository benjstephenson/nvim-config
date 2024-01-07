local diagnostic_icons = {
    error = " ",
    warn = " ",
    info = " ",
    hint = "󰌶 ",
    ok = " ",
}

local kind_icons = {
    Branch = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Keyword = " ",
    Merge = " ",
    Method = " ",
    Module = " ",
    Operator = " ",
    Property = " ",
    Reference = " ",
    Save = " ",
    Snippet = " ",
    Struct = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
    Test = " ",
    Text = " ",
}

local lisp_filetypes = { "fennel", "clojure", "lisp", "racket", "scheme" }

local border = {
    { "🭽", "FloatBorder" },
    { "▔", "FloatBorder" },
    { "🭾", "FloatBorder" },
    { "▕", "FloatBorder" },
    { "🭿", "FloatBorder" },
    { "▁", "FloatBorder" },
    { "🭼", "FloatBorder" },
    { "▏", "FloatBorder" },
}

return {
    diagnostic_icons = diagnostic_icons,
    kind_icons = kind_icons,
    lisp_filetypes = lisp_filetypes,
    border = border,
}
