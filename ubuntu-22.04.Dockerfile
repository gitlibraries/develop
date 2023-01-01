FROM ubuntu:22.04

RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone && \
    apt update && apt upgrade -y && \
    apt install -y build-essential curl git && \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" || true && \
    rm -rf /usr/local && ln -sf /home/linuxbrew/.linuxbrew/ /usr/local && \
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" && echo "export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH" >> ~/.bashrc && \
    brew shellenv && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc && \
    brew install gcc && \
    mv -f /usr/local/bin/x86_64-pc-linux-gnu-gfortran-12 /usr/local/bin/x86_64-pc-linux-gnu-gfortran && \
    mv -f /usr/local/bin/x86_64-pc-linux-gnu-gcc-ranlib-12 /usr/local/bin/x86_64-pc-linux-gnu-gcc-ranlib && \
    mv -f /usr/local/bin/x86_64-pc-linux-gnu-gcc-nm-12 /usr/local/bin/x86_64-pc-linux-gnu-gcc-nm && \
    mv -f /usr/local/bin/x86_64-pc-linux-gnu-gcc-ar-12 /usr/local/bin/x86_64-pc-linux-gnu-gcc-ar && \
    mv -f /usr/local/bin/x86_64-pc-linux-gnu-gcc-12 /usr/local/bin/x86_64-pc-linux-gnu-gcc && \
    mv -f /usr/local/bin/x86_64-pc-linux-gnu-g++-12 /usr/local/bin/x86_64-pc-linux-gnu-g++ && \
    mv -f /usr/local/bin/x86_64-pc-linux-gnu-c++-12 /usr/local/bin/x86_64-pc-linux-gnu-c++ && \
    mv -f /usr/local/bin/lto-dump-12 /usr/local/bin/lto-dump && \
    mv -f /usr/local/bin/gfortran-12 /usr/local/bin/gfortran && \
    mv -f /usr/local/bin/gcov-tool-12 /usr/local/bin/gcov-tool && \
    mv -f /usr/local/bin/gcov-dump-12 /usr/local/bin/gcov-dump && \
    mv -f /usr/local/bin/gcov-12 /usr/local/bin/gcov && \
    mv -f /usr/local/bin/gcc-ranlib-12 /usr/local/bin/gcc-ranlib && \
    mv -f /usr/local/bin/gcc-nm-12 /usr/local/bin/gcc-nm && \
    mv -f /usr/local/bin/gcc-ar-12 /usr/local/bin/gcc-ar && \
    mv -f /usr/local/bin/gcc-12 /usr/local/bin/gcc && \
    mv -f /usr/local/bin/g++-12 /usr/local/bin/g++ && \
    mv -f /usr/local/bin/cpp-12 /usr/local/bin/cpp && \
    mv -f /usr/local/bin/c++-12 /usr/local/bin/c++ && \
    brew install wget curl git zip unzip vim make cmake pkg-config && \
    brew tap aws/tap && brew install awscli aws-sam-cli && \
    brew install vcpkg && git clone https://github.com/microsoft/vcpkg "$HOME/vcpkg" && \
    export VCPKG_ROOT="$HOME/vcpkg" && echo "export VCPKG_ROOT=$HOME/vcpkg" >> ~/.bashrc && \
    vcpkg install boost libgo && \
    brew install pyenv pyenv-virtualenv && \
    export PYENV_ROOT="$HOME/.pyenv" && echo "export PYENV_ROOT=$HOME/.pyenv" >> ~/.bashrc && \
    export PATH="$PYENV_ROOT/bin:$PATH" && echo "export PATH=$PYENV_ROOT/bin:$PATH" >> ~/.bashrc && \
    eval "$(pyenv init -)" && echo "eval \"\$(pyenv init -)\"" >> ~/.bashrc && \
    eval "$(pyenv virtualenv-init -)" && echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.bashrc && \
    pyenv install 3.7.9 && pyenv global 3.7.9

ENV VCPKG_ROOT=/root/vcpkg \
    PYENV_ROOT=/root/.pyenv \
    PATH=/root/.pyenv/bin:/root/.pyenv/shims:$PATH
