" Enable diagnostics highlighting
let lspOpts = #{ autoHighlightDiags: v:true, noNewlineInCompletion: v:true }
autocmd User LspSetup call LspOptionsSet(lspOpts)
let lspServers = [
            \ #{
            \   name: 'clang',
            \   filetype: ['c', 'cpp'],
            \   path: 'clangd',
            \   args: ['--background-index', '--clang-tidy']
            \  },
            \ #{
            \   name: 'vimls',
            \   filetype: ['vim'],
            \   path: 'vimls',
            \   args: []
            \ }
            \ ]

autocmd User LspSetup call LspAddServer(lspServers)

" Key mappings
nnoremap gd :LspGotoDefinition<CR>
nnoremap gr :LspShowReferences<CR>
nnoremap K  :LspHover<CR>
nnoremap gl :LspDiag current<CR>
nnoremap <leader>nd :LspDiag next \| LspDiag current<CR>
nnoremap <leader>pd :LspDiag prev \| LspDiag current<CR>
inoremap <silent> <C-Space> <C-x><C-o>

nnoremap <leader>fl :Autoformat<CR>
autocmd BufWritePre *.c,*.cpp,*.h,*.hpp,*.vim,*.lua Autoformat

" Set omnifunc for completion
autocmd FileType c,cpp,vim setlocal omnifunc=lsp#complete

" Custom diagnostic sign characters
autocmd User LspSetup call LspOptionsSet(#{
            \   diagSignErrorText: '✘',
            \   diagSignWarningText: '▲',
            \   diagSignInfoText: '»',
            \   diagSignHintText: '⚑',
            \ })

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
