FROM ubuntu:22.04

RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone && \
    touch ${HOME}/.hushlogin && \
    apt update && apt upgrade -y && \
    apt install -y build-essential procps curl file git && \
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" && \
    touch /.dockerenv && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc && \
    brew install gcc@12 wget curl git zip unzip vim make cmake pkg-config && \
    brew tap aws/tap && brew install awscli aws-sam-cli

# c++
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install vcpkg && git clone https://github.com/microsoft/vcpkg "$HOME/vcpkg" && \
    export VCPKG_ROOT="$HOME/vcpkg" && echo "export VCPKG_ROOT=\$HOME/vcpkg" >> ~/.bashrc && \
    vcpkg install boost libgo

# python
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install pyenv pyenv-virtualenv && \
    export PYENV_ROOT="$HOME/.pyenv" && echo "export PYENV_ROOT=\$HOME/.pyenv" >> ~/.bashrc && \
    export PATH="$PYENV_ROOT/bin:$PATH" && echo "export PATH=\$PYENV_ROOT/bin:\$PATH" >> ~/.bashrc && \
    eval "$(pyenv init -)" && echo "eval \"\$(pyenv init -)\"" >> ~/.bashrc && \
    eval "$(pyenv virtualenv-init -)" && echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.bashrc && \
    apt install -y zlib1g-dev && \
    CC="/home/linuxbrew/.linuxbrew/bin/gcc-12" CPPFLAGS="-I/home/linuxbrew/.linuxbrew/include" LDFLAGS="-L/home/linuxbrew/.linuxbrew/lib" \
    pyenv install 3.7.9 && pyenv global 3.7.9

# golang
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install golang && \
    apt install -y cobra && \
    export GOPATH="$HOME/go" && echo "export GOPATH=\$HOME/go" >> ~/.bashrc && \
    export PATH="$GOPATH/bin:$PATH" && echo "export PATH=\$GOPATH/bin:\$PATH" >> ~/.bashrc