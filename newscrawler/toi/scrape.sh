#!/bin/bash
# A simple script

SOURCEDIR=/Users/shubhambansal/newscrawler/toi

scrapy crawl tou -a cat="sports"
scrapy crawl tou -a cat="tech"
scrapy crawl tou -a cat="business"
scrapy crawl tou -a cat="entertainment"