#!/bin/bash

# Platform IO setup script
# Links:
# https://docs.platformio.org/en/latest/core/installation/requirements.html
# https://docs.platformio.org/en/latest/core/installation/methods/installer-script.html
# https://docs.platformio.org/en/latest/core/installation/udev-rules.html#platformio-udev-rules

sudo apt install python3 python3-venv curl
python3 -V

#curl -fsSL -o get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py
#python3 get-platformio.py
#rm get-platformio.py

mkdir ~/.local/bin/
ln -s ~/.platformio/penv/bin/platformio ~/.local/bin/platformio
ln -s ~/.platformio/penv/bin/pio ~/.local/bin/pio
ln -s ~/.platformio/penv/bin/piodebuggdb ~/.local/bin/piodebuggdb

grep -qxF 'export PATH=$PATH:$HOME/.local/bin' ~/.bashrc || echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc

curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules | sudo tee /etc/udev/rules.d/99-platformio-udev.rules

cat /etc/udev/rules.d/99-platformio-udev.rules

sudo service udev restart

# or
#sudo udevadm control --reload-rules
#sudo udevadm trigger

sudo usermod -a -G dialout $USER
sudo usermod -a -G plugdev $USER
sudo service udev restart

echo "Developer setup completed successfully."
echo "Please run 'source ~/.bashrc' or restart your terminal to apply the changes."
echo "Next run pio --version to verify tools"
