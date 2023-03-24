# Web scraper in python

# The main parts of a web scraper:
# 1) Request : used to send HTTP request to the website you want to scrape
# 2) Parsing : used to extract specific data from the HTML or XML code of the website.
# 3) Storage : Storage it is used to store the extracted data


# The steps are :
# Send an HTTP request to the website you want to scrape
# Receive the HTML code of the webpage
# Parse the HTML code to extract the required data
# Store the extracted data

# The below code creates a web scraper that goes through only static content of a
# Webpage. This is limiting as most web pages are interactive and have dynamic parts
# and blocks to prevent overuse of resources on the server


from bs4 import BeautifulSoup
import requests
import csv
import re

# Identify the website

URL = "https://books.toscrape.com"

# Website inspection

response = requests.get(URL)
html_content = response.content
soup = BeautifulSoup(html_content, "html.parser")

#print(soup.prettify())

# parse
title = soup.find('h1').text
print(title)

# find all p eleemnts with a class starting with "star - rating"
star_ratings = soup.find_all('p', attrs={'class': re.compile(r'^star-rating')})

# Prints the list of star rating classes
#for star_rating in star_ratings:
    #print(star_rating['class'])
    #print(star_rating['class'][1])

book_title = [b.text for b in soup.find_all('h3')]
print(len(book_title))

price = [price.text for price in soup.find_all('p', class_='price_color')]
print(len(price))

#store extracted data
data = {'Book Title': book_title, 'Price' : price, 'Ratings': star_ratings}
#print(data)

with open("Html_data.csv", "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['Book Title', 'Price', 'Ratings'])
    for i in range(len(book_title)):
        writer.writerow([book_title[i], price[i], star_ratings[i]['class'][1]])

csvfile.close()