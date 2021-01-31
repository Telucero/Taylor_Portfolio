# Taylor Lucero

# Main Idea:
# Optimization technique: Neural Style transfer used to take two images
# A Content Image & Style Image and merge them together into an output image
# with the Content of the content image made in style of the style image.
# Adam Vs

# Implementation:
# Implemented by optimizing the output to match the content statistics of the
# content image and the style statistics of the style reference image.

# Setup

import os
import tensorflow as tf
import tensorflow_probability as tfp
import IPython.display as display
import matplotlib.pyplot as plt
import matplotlib as mpl
mpl.rcParams['figure.figsize'] = (12, 12)
mpl.rcParams['axes.grid'] = False
import numpy as np
import PIL.Image
import time
import functools



# Defines a function Tensor_to_Img(tensor)
# Multiplies the input by 255 and turns into an array of datatype uint8
# Checking the dimensions of the numpy array if > 3
# The first dimension of the tensor shape is 1  then the tensor equals the
# First element in the numpy array
# This function returns an image memory from the object

def Tensor_to_Img(tensor):
    tensor = tensor * 255
    tensor = np.array(tensor, dtype=np.uint8)
    if np.ndim(tensor) > 3:
        assert tensor.shape[0] == 1
        tensor = tensor[0]
    return PIL.Image.fromarray(tensor)


# Choose the Content and Style images
content = "/Users/taylorlucero/Documents/GitHub/Taylor_Portfolio/Backups/images/Banksy_piece.jpeg"
style = "/Users/taylorlucero/Documents/GitHub/Taylor_Portfolio/Backups/images/Abstract_color.jpeg"



# Define a function to load an image and limit its
# Maximum dimension to 512 pixels.
# Initializing the max dimensions to 512
# Reading the file with given image path
# Decoding the image with the 3 color channels
# Converting the image into a data type float32

def Img_load(img_path):
    max_dim = 512
    img = tf.io.read_file(img_path)
    img = tf.image.decode_image(img, channels=3)  # channels is 3 becuase of RGB
    img = tf.image.convert_image_dtype(img, tf.float32)

    shape = tf.cast(tf.shape(img)[:-1], tf.float32)
    long_dim = max(shape)
    scale = max_dim / long_dim

    new_shape = tf.cast(shape * scale, tf.int32)

    img = tf.image.resize(img, new_shape)
    img = img[tf.newaxis, :]
    return img


# Create a function to display the image

def imshow(image, title=None):
    if len(image.shape) > 3:
        image = tf.squeeze(image, axis=0)

    plt.imshow(image)
    if title:
        plt.title(title)


# use Img_load to read and manipulate content and style images to the
# correct dimensions

content_img = Img_load(content)
style_img = Img_load(style)

plt.subplot(1, 2, 1)
imshow(content_img, "Content Image")

plt.subplot(1, 2, 2)
imshow(style_img, " Style Image")
########################## Everything Before this is for helper function ########

# Defining the content and the style_img using the VGG19 network
# architecture (play around with different stuctures) but do not use the classification head
# just use the learned features and statistics to identify complex features.

# VGG19 is a unique Convnet form with initial input 224x224x64 with
# five max-pool layers and two Full convolutional with a softmax layer

#Define content and style representations by loading VGG19
x = tf.keras.applications.vgg19.preprocess_input(content_img * 255)
x = tf.image.resize(x, (224, 224))
vgg = tf.keras.applications.VGG19(include_top=True, weights='imagenet')
prediction_probabilities = vgg(x)
prediction_probabilities.shape

predicted_top_5 = tf.keras.applications.vgg19.decode_predictions(prediction_probabilities.numpy())[0]
[(class_name, prob) for (number, class_name, prob) in predicted_top_5]

vgg = tf.keras.applications.VGG19(include_top=False, weights='imagenet')

print()
for layer in vgg.layers:
    print(layer.name)

content_layers = ['block5_conv2']

style_layers = ['block1_conv1',
                'block2_conv1',
                'block3_conv1',
                'block4_conv1',
                'block5_conv1']

num_content_layers = len(content_layers)
num_style_layers = len(style_layers)

def vgg_layers(layer_names):
# creates a vgg model that returns a list of intermediate output values
# Load our model, load pretrained VGG that was trained on imagenet data

    vgg = tf.keras.applications.VGG19(include_top=False, weights ='imagenet')
    vgg.trainable= False

    outputs = [vgg.get_layer(name).output for name in layer_names]

    model = tf.keras.Model([vgg.input], outputs)
    return model

# The next few lines create the model

style_extractor= vgg_layers(style_layers)
style_outputs = style_extractor(style_img*255)

# Look at the statistics of each layers output

for name, output in zip(style_layers, style_outputs):
    print(name)
    print(" shape:" , output.numpy().shape)
    print(" min: ", output.numpy().min())
    print(" max: ", output.numpy().max())
    print(" mean: ", output.numpy().mean())
    print()

# Calculate style, The content of an image is represented
# by the values of the intermediate feature maps
# The style of an image can be described by the means and correlations
# across the different feature maps.

def gram_matrix(input_tensor):
  result = tf.linalg.einsum('bijc,bijd->bcd', input_tensor, input_tensor)
  input_shape = tf.shape(input_tensor)
  num_locations = tf.cast(input_shape[1]*input_shape[2], tf.float32)
  return result/(num_locations)


# Creates a class with subclasses that are called, when called on an image, this
# model returns the gram matrix(style) of the style layers and content of the
# Content of the content layer

class StyleContentModel(tf.keras.models.Model):
  def __init__(self, style_layers, content_layers):
    super(StyleContentModel, self).__init__()
    self.vgg =  vgg_layers(style_layers + content_layers)
    self.style_layers = style_layers
    self.content_layers = content_layers
    self.num_style_layers = len(style_layers)
    self.vgg.trainable = False


  def call(self, inputs):
    inputs = inputs*255.0
    preprocessed_input = tf.keras.applications.vgg19.preprocess_input(inputs)
    outputs = self.vgg(preprocessed_input)
    style_outputs, content_outputs = (outputs[:self.num_style_layers],
                                      outputs[self.num_style_layers:])

    style_outputs = [gram_matrix(style_output)
                     for style_output in style_outputs]

    content_dict = {content_name: value
                    for content_name, value
                    in zip(self.content_layers, content_outputs)}

    style_dict = {style_name: value
                  for style_name, value
                  in zip(self.style_layers, style_outputs)}

    return {'content': content_dict, 'style': style_dict}


extractor = StyleContentModel(style_layers, content_layers)


results = extractor(tf.constant(content_img))

print('Styles:')
for name, output in sorted(results['style'].items()):
  print("  ", name)
  print("    shape: ", output.numpy().shape)
  print("    min: ", output.numpy().min())
  print("    max: ", output.numpy().max())
  print("    mean: ", output.numpy().mean())
  print()

print("Contents:")
for name, output in sorted(results['content'].items()):
  print("  ", name)
  print("    shape: ", output.numpy().shape)
  print("    min: ", output.numpy().min())
  print("    max: ", output.numpy().max())
  print("    mean: ", output.numpy().mean())

# Run gradient descent to with back-propagation to optimize
# the image
# The Previous code extracted the style and which mean the style
# Transfer algorithm.

# Set Style and Content target values
S_targets = extractor(style_img)['style']
C_targets = extractor(content_img)['content']

# Define a tf.Variable to contain the image to optimize
# Since the content image is essentially the base
# We use that shape for the tf.Variable
# You also need to define a function to keep the
# pixel values between 0 and 1

image= tf.Variable(content_img)

def clip_0_1(image):
    return tf.clip_by_value(image, clip_value_min=0.0, clip_value_max = 1.0)

# The optimizer We can use Adam or LBFGS.
optimizer = tf.optimizers.Adam(learning_rate=0.02, beta_1=0.99, epsilon=1e-1)
#optimizer = tf.optimizers.Adagrad ( learning_rate=0.02, initial_accumulator_value=0.1, epsilon=1e-1 )

s_weight = 1e-1
c_weight = 1e4

# The function below calculates the loss function for both style
# and content and applies the weights, and sums the results to find the loss.
# This was done by calc the mean square error for the image's output relative to each target, then
# took the wieghted sum of the losses

def style_content_loss(outputs):
    style_outputs = outputs['style']
    content_outputs = outputs['content']
    style_loss = tf.add_n([tf.reduce_mean((style_outputs[name]-S_targets[name])**2)
                           for name in style_outputs.keys()])
    style_loss *= s_weight / num_style_layers

    content_loss = tf.add_n([tf.reduce_mean((content_outputs[name]-C_targets[name])**2)
                             for name in content_outputs.keys()])
    content_loss *= c_weight / num_content_layers
    loss = style_loss + content_loss
    return loss
total_variation_weight=40


@tf.function()
def train_step(image):
    with tf.GradientTape() as tape:
        outputs = extractor(image)
        loss = style_content_loss(outputs)
        loss += total_variation_weight * tf.image.total_variation(image)

    grad = tape.gradient(loss, image)
    optimizer.apply_gradients([(grad,image)])
    image.assign(clip_0_1(image))



train_step(image)
train_step(image)
train_step(image)
Tensor_to_Img(image).show()

import time
start = time.time()

epochs = 10 # Number of full cycles
steps_per_epoch = 100

step = 0 #initilization

for n in range(epochs):
    for m in range(steps_per_epoch):
        step += 1
        train_step(image)
        print("+", end='')
    display.clear_output(wait=True)
    Tensor_to_Img(image).show()
    print("Train step : {}".format(step))

end = time.time()
print("Total time: {:.1f}".format(end-start))


# Apply a regularization method in the training function to reduce high frequency artifacts
# its seems the major difference that Adagrad and Ada have is how they treat the learning rate
# Adagrad is better with sparse data, because it adapts the learning rate to the parameters.



