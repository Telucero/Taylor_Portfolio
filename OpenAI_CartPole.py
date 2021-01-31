# Taylor Lucero Run in the Conda env
# Some AI Terms:
# Agent: The object/ entity performing the action
# Environment: The setting/ surrounding of where the agent is
# Episode: is essentially the attempt # in the event series
# Learning method: How the Agent learns to perform action, Reward based learning etc.
# This will be with CartPole
# Cart Pole Explanation, Cart will be object in the center of the screen, if you move the
# Cart to far to the left or to far to the right its game over and if the cart moves more than 15 degrees from the
# vertical position you also lose.

# The aim is to balance the pole on the cart by moving the cart bit by bit.

import tflearn
import gym  # This has the game Packages
import random
import numpy as np
from tflearn.layers.core import input_data, dropout, fully_connected
from tflearn.layers.estimator import regression
from statistics import mean, median
from collections import Counter

LR =1e-3 # as the game gets more complex tweak

env = gym.make('CartPole-v0') # Set the game environment 
env.reset()

goal_steps= 500 # every frame we go while the pole is still balanced is  +1

score_requirement =  50 #includes all games with scores 50 or grater
initial_games = 10000

def random_games():
    for episode in range (5):
        env.reset()
        for t in range (goal_steps):
            env.render() # To see whats happending in the game (Slows down the process)
            action = env.action_space.sample() # This generates random actions
            observation , reward, done, info = env.step(action)
            # observation - an array of data, like pixel data, or pole position and cart position
            # reward - if the pole was balanced or not
            # done - is the game over
            # info - any other info
            if done:
                break


# random_games()

# When we have an environment we can generate like this, we can generate training examples



def initial_population():
    training_data = []
    scores = [] # With the previous code it will only append values greater than 50
    accepted_scores = []
    # this iterates through the games
    for _ in range(initial_games):
        score = 0
        game_memory = []
        prev_observation = []
        # ++++++++++++++++++++++++ Below This is the actual game
        for _ in range(goal_steps):
            action = random.randrange(0,2) # this will only genereate 0 and 1s
            observation, reward, done, info = env.step(action) # this code implies the observation occurs
            # after the action, which logically doesnt make sense, hence why we use the empty list prev_observation below

            if len(prev_observation) > 0:
                game_memory.append([prev_observation,action])

            prev_observation = observation
            score += reward
            if done:
                break

        if score >= score_requirement:
            accepted_scores.append(score)
            for data in game_memory:
                if data[1] == 1: #Data in this is the first instance in the list of
            # lists containing, prev_observation and action
                    output = [0,1]

                elif data[1] == 0:
                    output = [1,0]

                training_data.append([data[0],output])

        env.reset()
        scores.append(score)


    training_data_save = np.array(training_data)
    np.save('save.npy', training_data_save)

    print('Average accepted score:', mean(accepted_scores))
    print('Median accepted score:', median(accepted_scores))
    print('Runs through the 10,000 examples')
    print(Counter(accepted_scores))

    return training_data

# We are outside the game at this point, weve rin through how many iterations of it and collected data on it,
# the next step is using the collected data

# We have collected the information the next step is building a neural network model

def nn_model(input_size): # TensorFlow allows you to load an already defined model:Separate the model and the training
    # of the model.
    network = input_data(shape=[None, input_size, 1], name = 'input')

    network = fully_connected(network, 128, activation='relu') # Layer 1
    network = dropout(network, 0.8)

    network = fully_connected(network, 256, activation='relu') # Layer 2
    network = dropout(network, 0.8)

    network = fully_connected(network, 512, activation='relu') # Layer 3
    network = dropout(network, 0.8)

    network = fully_connected(network, 256, activation='relu') # Layer 4
    network = dropout(network, 0.8)

    network = fully_connected(network, 128, activation='relu') # Layer 5
    network = dropout(network, 0.8)

    network = fully_connected(network, 2, activation= 'softmax') #This is binary(left or right, hence the two)
    network = regression(network, optimizer='adam', learning_rate=LR,
                         loss = 'categorical_crossentropy', name='targets')
    model= tflearn.DNN(network, tensorboard_dir='log')

    return  model

def train_model(training_data, model=False):
    X = np.array([i[0] for i in training_data]).reshape(-1, len(training_data[0][0]), 1) # List comprehension woop woop
    Y = [i[1] for i in training_data]

    if not model:
        model = nn_model(input_size = len(X[0]))
    model.fit({'input':X}, {"targets":Y}, n_epoch=5, snapshot_step=500, show_metric=True,
              run_id='Openaistuff')
    return model

training_data = initial_population()
model= train_model(training_data)
