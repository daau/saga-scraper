# Saga Scraper
This is a web scraper built to extract data from the [MapleSaga library.](https://maplesaga.com/library/)

This script is written in Ruby.

Data for both items and equipments are extracted. Data is exported to the `./export` directory.

## Data format
The data is presented in .json format. Data entries are organized into the 
categories shown on the MapleSaga library website.

The following attributes are recorded for equipment:
- id
- name
- image_url
- wearable_by
- requirements
- stats
- dropped_by
- obtained_from
- remarks

The following attributes are recorded for items:
- id
- name
- image_url
- description
- dropped_by
- obtained_from
- remarks


## Installation and Usage
1. Download the repository and extract it to your local machine
2. `bundle install`
3. `ruby lib/sagascraper.rb`