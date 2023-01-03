FROM ubuntu:22.04

# root
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone && \
    touch /.dockerenv && \
    touch ${HOME}/.hushlogin && \
    apt update && apt upgrade -y && \
    apt install -y build-essential procps curl file git cobra

# brew
RUN export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" && \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc && \
    brew install gcc@12 wget curl git zip unzip vim make cmake pkg-config && \
    brew tap aws/tap && brew install awscli aws-sam-cli

# c++
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install vcpkg && git clone https://github.com/microsoft/vcpkg "$HOME/vcpkg" && \
    export VCPKG_ROOT="$HOME/vcpkg" && echo "export VCPKG_ROOT=\$HOME/vcpkg" >> ~/.bashrc && \
    vcpkg install boost libgo

# golang
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install golang && \
    curl -fsSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash -s && \
    bash -c "source /root/.gvm/scripts/gvm && gvm install go1.19.4 && gvm use go1.19.4 --default"

# python
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install pyenv pyenv-virtualenv && \
    export PYENV_ROOT="$HOME/.pyenv" && echo "export PYENV_ROOT=\$HOME/.pyenv" >> ~/.bashrc && \
    export PATH="$PYENV_ROOT/bin:$PATH" && echo "export PATH=\$PYENV_ROOT/bin:\$PATH" >> ~/.bashrc && \
    eval "$(pyenv init -)" && echo "eval \"\$(pyenv init -)\"" >> ~/.bashrc && \
    eval "$(pyenv virtualenv-init -)" && echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.bashrc && \
    export CC="/home/linuxbrew/.linuxbrew/bin/gcc-12" && \
    export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/include" && \
    export LDFLAGS="-L/home/linuxbrew/.linuxbrew/lib" && \
    export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/lib/pkgconfig" && \
    pyenv install 3.7.9 && pyenv global 3.7.9