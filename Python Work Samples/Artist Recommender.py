
# coding: utf-8

# In[2]:

import spotipy
import pandas as pd
import requests
import matplotlib.pyplot as plt
import plotly
import plotly.plotly as py
import cufflinks as cf
import warnings
warnings.filterwarnings('ignore')
import sys
import random
import spotipy.util as util
sp = spotipy.Spotify()
#define variables
#function
#then use it at the beginnning but outside the loop
#use it to run a loop for each tool number
#this will gather data for 4 artists with similar areas of the artist inputed
#place the gathered data into a data frame
#use the data frame to graph
url = 'http://api.musicgraph.com/api/v2/artist/search?api_key=08f4b6366fe0b8bfdd450556c4372be6'
similar = '&similar_to='
Type = '&genre='
decade = '&decade='
a = 0
name = input('Enter artist name: ')
def artist_rate(name):
    results = sp.search(q='artist:' + name, type='artist')
    total_followers = results['artists']['items'][0]['followers']['total']
    artist_id= results['artists']['items'][0]['id']
    popularity = results['artists']['items'][0]['popularity']
    genre = results['artists']['items'][0]['genres']
    artist = { 'Followers': total_followers, 'Popularity': popularity, 'ID' : artist_id, 'Genre' : genre}
    return artist

#set up three other uses for  this API 1, find similar artists by names 2, find similar artists by decade 3, find artists by country
print('1: Find a similar artist') 
print('2: Find similar artist by genres')
print('3: Find similar artist by decade')

artist = artist_rate(name)
while True:
    if a is 3:
        print('artist sample of 3 reached')
        break
    
    tool = input('Enter numbers 1,2, and 3 in Sequential order to start information gathering: ')
    
    if a is 3:
        print('artist sample of 3 reached')
        break

    if tool == '1':
      
        url1 = url + similar + name
        response = requests.get(url1)
        info1 = response.json()
        data1 = info1['data'][0]
        name1 = info1['data'][random.randint(0,5)]['name']
        artist1 = artist_rate(name1)
        print('A popular  artist that you may like is', name1)
        a=a+1
    
    elif tool == '2':
        
        music_type = input('Enter a genre of music: ')
        url2 = url + Type + music_type + similar + name
        response = requests.get(url2)
        info2 = response.json()
        data2 = info2['data'][0]
        name2 = info2['data'][0]['name']
        artist2 = artist_rate(name2)
        print('A similar artist to', name ,' based on genre is', name2)
        a=a+1
    
    elif tool == '3':
        era= input('Please choose a decade: ')
        url3 = url + decade + era + 's' + similar + name
        response = requests.get(url3)
        info3 = response.json()
        data3 = info3['data'][0]
        name3 = info3['data'][0]['name']
        artist3 = artist_rate(name3)
        print('A similar artist to', name,' based on the decade parameter is', name3)
        a=a+1
    else:
            print('Not a valid input')

print('Printing visual representation of data gathered')

# use an else to decline any input that is not 1-3
# the third section will use the data and will turn it into a data frame


artist_df = pd.DataFrame({ 'Artists' : [name, name1, name2, name3], 'Total Account Followers' : [artist['Followers'], artist1['Followers'], artist2['Followers'], artist3['Followers']]})
artist_df['Popularity' ]= [ artist['Popularity'], artist1['Popularity'], artist2['Popularity'], artist3['Popularity']]
artist_df

# the final  section of the code will graph the data


artist_df.iplot(kind="pie", labels = 'Artists', values='Popularity')


# 

# In[ ]:



