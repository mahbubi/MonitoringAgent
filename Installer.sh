#! /bin/bash
echo "################ Instal Package node_exporter ################"
sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz 
sudo tar xvf node_exporter-1.3.1.linux-amd64.tar.gz 
sudo mv node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/ 
sudo useradd -rs /bin/false node_exporter
echo "################ Move SystemD & Restart Service Node_exporter.service ################"
mv node_exporter.service /etc/systemd/system/node_exporter.service
sudo systemctl daemon-reload && sudo systemctl enable --now node_exporter.service 
sudo systemctl status node_exporter.service
echo "################ Test Curl Node Exporter ################"
curl localhost:9100
echo "################ Instal Package Promtail ################"
curl -s https://api.github.com/repos/grafana/loki/releases/latest | grep browser_download_url |  cut -d '"' -f 4 | grep promtail-linux-amd64.zip | wget -i -  
sudo apt install unzip && unzip promtail-linux-amd64.zip 
sudo mv promtail-linux-amd64 promtail
sudo cp promtail /usr/local/bin
sudo mkdir -p /etc/promtail
echo "################ Move SystemD &Restart Service promtail.service ################"
mv promtail.yaml /etc/promtail/promtail.yaml
mv promtail.service /etc/systemd/system/promtail.service
sudo systemctl daemon-reload && sudo systemctl enable --now promtail.service
sudo systemctl status promtail.service