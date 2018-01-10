#!/usr/bin/env sh

WKHTML2PDF_VERSION='0.12.4'

echo "downloading and installing wkhtmltopdf (please wait...)"
wget -q "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/${WKHTML2PDF_VERSION}/wkhtmltox-${WKHTML2PDF_VERSION}_linux-generic-amd64.tar.xz"
tar -xJf "wkhtmltox-${WKHTML2PDF_VERSION}_linux-generic-amd64.tar.xz"
cd wkhtmltox
chown root:root bin/wkhtmltopdf
cp -r * /usr/