#Taylor Lucero run in env of python 3.7
# There was no back propagation now Optimization or Normalization
import numpy as np

#=========== Defines the Helper functions

def sigmoid(x, deriv=False): # Activation Function
    if deriv == True:
        return x*(1-x)
    return 1/(1+np.exp(-x))

#-------Defines the inputs and Outputs
X = np.array ([[0,0,1],
               [0,1,1],
               [1,0,1],
               [1,1,1],
               [0,1,0],
               [1,0,0]]) # These are the input values.

Y= np.array ([[0,0,1,1,1,1]]).T # These are the output values relative to the input values, in terms that there
# are four inputs, one for each element in the out put value
#----------------------------

#+++++++++ Begings the Neural Processes
#np.random.seed(1) # Sets the seed so similar statistics appear accross the board

syn0 = 2*np.random.random((3,1)) - 1 #This is the synapse (What is the Synapse, is that like the node or the wieght)

for i in range(10000): # Set the loop and iteration of the of the network
    l0 = X
    l1 = sigmoid(np.dot(l0,syn0)) # uses the dot product to output a scalar for the first loss value

    l1_error = Y - l1 # The error of the loss
    l1_delta = l1_error * sigmoid(l1,True) #

    syn0 += np.dot(l0.T,l1_delta) # Updates the weights?

print(l1)