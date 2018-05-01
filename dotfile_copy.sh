rm -rf nvim i3 polybar zsh
mkdir -p nvim zsh/custom polybar i3
cp -R ~/.config/nvim/init.vim nvim/
cp -R ~/.config/i3/* i3/
cp -R ~/.config/polybar/* polybar/
cp -R ~/.oh-my-zsh/custom/*.zsh zsh/custom/
rm zsh/custom/secret.zsh
cp ~/.zshrc zsh/
