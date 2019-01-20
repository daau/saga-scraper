# Saga Scraper
This is a web scraper built to extract data from the [MapleSaga library.](https://maplesaga.com/library/)

This script is written in Ruby.

Data for both items and equipments are extracted. Data is exported to the `./export` directory.

## Data format
The data is presented in .json format. Data entries are organized into the 
categories shown on the MapleSaga library website.

The following attributes are recorded for equipment:
```
id:             INTEGER
name:           STRING
image_url:      STRING
wearable_by:    STRING
requirements:   STRING
stats:          STRING
dropped_by:     STRING
obtained_from:  STRING
remarks:        STRING
```

The following attributes are recorded for items:
```
id:             INTEGER
name:           STRING
image_url:      STRING 
description:    STRING 
dropped_by:     STRING 
obtained_from:  STRING 
remarks:        STRING 
```

## Installation and Usage
1. Download the repository and extract it to your local machine
2. `bundle install`
3. `ruby lib/sagascraper.rb`

Alternaively if you're just interested in the scraped data, check the `./export` folder of this repository.