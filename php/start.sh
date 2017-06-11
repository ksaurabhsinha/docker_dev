#! /bin/sh
set -e


wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
sed -i -- 's/robbyrussell/ys/g' /root/.zshrc
echo "plugins=(git symfony2)" >> ~/.zshrc

exec "$@"
