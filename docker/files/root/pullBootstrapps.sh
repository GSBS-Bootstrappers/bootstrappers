#!/bin/bash

#pull repo
cd /var/www/html/ && git clone https://github.com/GSBS-Bootstrappers/bootstrappers.git --recursive

#compile html pages and pdfs 
cd /var/www/html/bootstrappers/bootstrappers-courses && ./create_all_pages.sh

