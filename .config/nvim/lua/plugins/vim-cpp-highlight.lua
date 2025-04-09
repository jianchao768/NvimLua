return {
    "octol/vim-cpp-enhanced-highlight",
    ft = { "cpp", "c", "hpp", "h" }, -- 只在 C/C++ 文件中加载
    init = function()
        -- 可选配置项，按需开启
        --高亮MyClass::func 里面的MyClass::
        --vim.g.cpp_class_scope_highlight = 1
        --高亮类中的成员变量（如this->member) 
        --vim.g.cpp_member_variable_highlight = 1
        --高亮class/struct声明中的类名
        --vim.g.cpp_class_decl_highlight = 1
        --启用简单的模板语法高亮（如vector<int>)
        --vim.g.cpp_experimental_simple_template_highlight = 1
        --支持C++20 Concepts 的语法高亮（如open，close）等
        --vim.g.cpp_concepts_highlight = 1
        --禁用函数名高亮（设1可禁用）
        --vim.g.cpp_no_function_highlight = 0  -- 默认函数也会高亮
    end,
}
