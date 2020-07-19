FROM phusion/passenger-ruby24:1.0.5
# TODO - tag version! (Otherwise we'll get a different Ubuntu in different environments and it'll all fall apart)

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

RUN mkdir /home/app/webapp

RUN lsb_release -a && \
    chown -R app:app /home/app/webapp && \
    rm /home/app/webapp/.ruby-version && \
    rm /etc/nginx/sites-enabled/default && \
    cd /home/app/webapp && \
    apt-get update && \
    apt-get install -y dirmngr gpg ca-certificates apt-transport-https 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic/snapshots/5.16.0 main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-get update && \
    apt-get install -y mono-complete wget
RUN apt-get install -y unzip && \
    mkdir /home/app/ipy && \
    cd /home/app/ipy && \
    wget 'https://github.com/IronLanguages/ironpython2/releases/download/ipy-2.7.8/IronPython.2.7.8.zip' && \
    unzip 'IronPython.2.7.8.zip' && \
    find . -name '*.exe' && \
    cd - && \
    echo 'mono /home/app/ipy/net45/ipy.exe $*' > /usr/local/bin/ipy && \
    chmod 755 /usr/local/bin/ipy

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#    echo "deb https://download.mono-project.com/repo/ubuntu bionic/snapshots/5.16.0.221 main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
#    echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
