export DISPLAY=:1

Xvfb :1 -screen 0 1024x768x24 & 
#su puritys bash -c "source /home/puritys/dotfiles/basic/.alias_common ; fn_eclim_start &"
su puritys bash -c "DISPLAY=:1 ~/.vim/eclipse/eclimd -b"

