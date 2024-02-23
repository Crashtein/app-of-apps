#!/bin/bash
wget https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz
ls -l
tar -xvzf ./geckodriver*
chmod +x ./geckodriver
export PATH=$PATH:/path-to-extracted-file/geckodrive
