
![show](./assets/show_sample6.png)

### PS:
```
NvimLua 配置main版本，打开lsp支持
多功能支持
```

### TODO:

```
./install_config.sh
```
or

```bash
1.解压插件/字体
  tar -xJvf fzf.tar.xz -C ~/

  cd ~/.local/share/nvim/ 
  tar -xJvf lazy.tar.xz 

  cd ~/.local/share/fonts/UbuntuMono/
  tar -xJvf UbuntuMono.tar.xz
  更新终端的字体缓存:
  fc-cache -fv

2.还原/解压clangd
  cd .local/share/nvim/mason/packages/clangd/clangd_20.1.0/bin/
  cat clangd.tar.xz.part_a* > clangd.tar.xz
  tar -xJvf clangd.tar.xz
```
