FROM ubuntu:18.04

WORKDIR /root
COPY . /root/ngx_http_proxy_connect_module/
RUN apt update && apt install -y wget patch gcc libpcre3 libpcre3-dev zlib1g-dev build-essential
RUN wget http://nginx.org/download/nginx-1.19.3.tar.gz
RUN tar -xzvf nginx-1.19.3.tar.gz && cd nginx-1.19.3 && patch -p1 < /root/ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_1018.patch && ./configure --add-module=/root/ngx_http_proxy_connect_module && make && make install

CMD ["/usr/local/nginx/sbin/nginx", "-v"]
