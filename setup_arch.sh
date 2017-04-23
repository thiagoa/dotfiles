PACMANITY_GIST_ID="ce4ee6f8482d758e72ef745bf32aa686"
PACMANITY_AUR_GIST_ID="1e5f0d561937021c5f0f7b635328a700"

echo "Installing yaourt..."
sudo pacman -S yaourt

echo "Creating OpenSSL customizepkg config needed for old Ruby versions..."

if [[ ! -f /etc/customizepkg.d/openssl ]]; then
    sudo mkdir -p /etc/customizepkg.d
    sudo echo "replace#global#no-ssl3-method#zlib\nreplace#global#no-ssl3#zlib" > /etc/customizepkg.d/openssl
    sudo pacman -S openssl
fi

echo "Installing gist command. Our list of packages is stored within gists."
yaourt -S gist-git
gist --login

echo "Creating pacmanity configuration..."

if [[ ! -f /etc/pacmanity ]]; then
    echo "GIST=${PACMANITY_GIST_ID}" | sudo tee /etc/pacmanity
fi

if [[ ! -f /etc/pacmanity_aur ]]; then
    echo "GIST=${PACMANITY_AUR_GIST_ID}" | sudo tee /etc/pacmanity_aur
fi

echo "Installing pacman packages..."
sudo pacman -S --needed $(gist -r $PACMANITY_GIST_ID)

echo "Installing AUR packages. Be ready for a lot of prompts..."
yaourt -S --needed $(gist -r $PACMANITY_AUR_GIST_ID)

echo "Configuring system services..."
if [[ ! -f /etc/systemd/system/mysql.service ]]; then
  sudo cp $HOME/.dotfiles/system_config/mysql.service /etc/systemd/system/
fi
sudo systemctl enable postgresql mysql redis elasticsearch dnsmasq
