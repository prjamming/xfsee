FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base utilities and desktop environment
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies tightvncserver wget curl net-tools git supervisor \
    xterm python3-pip \
    && apt-get clean

# Install noVNC and websockify
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

# Add startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Supervisor config
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
