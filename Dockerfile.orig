FROM phusion/passenger-ruby24
# TODO - tag version! (Otherwise we'll get a different Ubuntu in different environments and it'll all fall apart)

ENV HOME /root

RUN mkdir -p /home/app && \
    lsb_release -a && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt update && \
    apt-get install -y mono-complete wget && \
    apt-get install -y unzip && \
    mkdir -p /home/app/ipy && \
    cd /home/app/ipy && \
    wget 'https://github.com/IronLanguages/ironpython2/releases/download/ipy-2.7.8/IronPython.2.7.8.zip' && \
    unzip 'IronPython.2.7.8.zip' && \
    find . -name '*.exe' && \
    cd - && \
    echo 'mono /home/app/ipy/net45/ipy.exe $*' > /usr/local/bin/ipy && \
    chmod 755 /usr/local/bin/ipy && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

