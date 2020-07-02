## Taylor Lucero
## Cocktail Program
## import the requests library
import requests
import json


Drink = input("What's your poison: ")
fletter = Drink[0]


url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="+fletter

## Make a get request
response = requests.get(url,
                        params= {'q':'requests+language:python'},
                        headers= {'Accept': url})
if(response.ok):
    Data = json.loads(response.content.decode('utf-8'))

Data = Data['drinks']

def AllDrinkInfo():
    def DrinkIngredients():
        listOfIngredients = [(int(key.replace('strIngredient', '')), value) for (key, value) in Data.items() if 'strIngredient' in key]
        return dict(listOfIngredients)

    def drinkmeasure():
        measureDict = {key: value for (key, value) in Data.items() if 'strMeasure' in key}
        i = 1
        print('Here are the needed ingredients: ')
        while 'strMeasure' + str(i) in measureDict:
            for x in measureDict:
                orderedmeasure = [value for (key, value) in measureDict.items() if 'strMeasure' + str(i) == key]
                if orderedmeasure == [None] and (DrinkIngredients()[i]) != None:
                    print(DrinkIngredients()[i])
                    i += 1
                    break
                elif orderedmeasure != [None]:
                    print(orderedmeasure[0] + ' of ' + (DrinkIngredients()[i]))
                    i += 1

                else:
                    break
            break

    listOfValues = [ value  for (key, value) in Data.items() if value == Drink ]
    if Drink in listOfValues:
        instructions = [value for (key, value) in Data.items() if key == 'strInstructions']
        print("Here are the instructions on how to make that drink:")
        print(instructions[0])
        drinkmeasure()
    else:
        print("Unfortunately we don't have that drink, is there anything else I can help you with?")
        AllDrinkInfo()
i=0
while True:
    try:
        drinkInfo = [value for (key, value) in Data[i].items() if value == Drink]
        if Drink in drinkInfo:
            Data = Data[i]
            AllDrinkInfo()
            break
        else:
            i += 1
            continue
    except IndexError:
        print("Unfortunately," + Drink + " does not exist")
        break







