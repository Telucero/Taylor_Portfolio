#Taylor Lucero
#Web Scraping


import bs4
import pandas as pd
import requests
import re

url = 'https://www.yelp.com/search?cflt=nightlife&find_loc=Washington%2C+DC'

def page_contents(url):
    page = requests.get(url, headers={"Accept-Language": "en-US"})
    return bs4.BeautifulSoup(page.text, "html.parser")

soup = page_contents(url)
# INSPECT the webpage
# target name = "Name of Bar"
# Information of Bar

Bars = soup.findAll('div',  class_="lemon--div__373c0__1mboc scrollablePhotos__373c0__1LEvd arrange__373c0__2C9bH border-color--default__373c0__3-ifU")
Names = [Bar.find('a').text for Bar in Bars]
print(Names)

Contact = [Bar.find('p').text for Bar in Bars]
print(Contact)

Phone = re.compile('\(\d\d\d\) \d\d\d-\d\d\d\d')
result = Phone.findall(Contact)
print(result)

